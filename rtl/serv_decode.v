module serv_decode
  (
   input        clk,
   input [31:0] i_i_rd_dat,
   input        i_i_rd_vld,
   output reg   o_i_rd_rdy = 1'b1,
   output       o_ctrl_en,
   output       o_ctrl_jump,
   output       o_ctrl_jalr,
   output       o_ctrl_auipc, 
   output       o_rf_rd_en,
   output [4:0] o_rf_rd_addr,
   output       o_rf_rs_en,
   output [4:0] o_rf_rs1_addr,
   output [4:0] o_rf_rs2_addr,
   output       o_alu_en,
   output       o_alu_init,
   output       o_alu_sub,
   output       o_alu_cmp_sel,
   output       o_alu_cmp_neg,
   input        i_alu_cmp,
   output       o_alu_shamt_en,
   output [1:0] o_alu_rd_sel,
   output       o_mem_en,
   output       o_mem_cmd,
   output       o_mem_init,
   output       o_mem_dat_valid, 
   input        i_mem_busy,
   output [2:0] o_funct3,
   output reg   o_imm,
   output       o_offset_source,
   output       o_op_b_source,
   output [1:0] o_rd_source);

`include "serv_params.vh"

   localparam [2:0]
     IDLE     = 3'd0,
     COMPARE  = 3'd1,
     SH_INIT  = 3'd2,
     MEM_INIT = 3'd3,
     MEM_WAIT = 3'd4,
     RUN      = 3'd5;
   
   localparam [4:0]
     OP_LOAD   = 5'b00000,
     OP_STORE  = 5'b01000,
     OP_OPIMM  = 5'b00100,
     OP_AUIPC  = 5'b00101,
     OP_OP     = 5'b01100,
     OP_LUI    = 5'b01101,
     OP_BRANCH = 5'b11000,
     OP_JALR   = 5'b11001,
     OP_JAL    = 5'b11011;

   reg [2:0]    state = 3'd0;

   reg [4:0] cnt     = 5'd0;

   wire      running;
   wire      mem_op;
   wire      shift_op;
   
   assign mem_op = (opcode == OP_LOAD) | (opcode == OP_STORE);
   assign shift_op = (opcode == OP_OPIMM) & (o_funct3[1:0] == 2'b01);

   assign o_ctrl_en  = running;
   assign o_ctrl_jump = (opcode == OP_JAL) |
                        (opcode == OP_JALR) |
                        ((opcode == OP_BRANCH) & i_alu_cmp);

   assign o_ctrl_jalr = (opcode == OP_JALR);
   
   assign o_ctrl_auipc = (opcode == OP_AUIPC);

   assign o_rf_rd_en = running &
                       (opcode != OP_STORE) &
                       (opcode != OP_BRANCH);

   assign o_rf_rs_en = cnt_en /*(running & (opcode == OP_OPIMM)) |
                       (state == SH_INIT) |
                       (state == MEM_INIT)*/;
 //FIXME: Change for addi?

   assign o_alu_en = cnt_en;

   assign o_alu_init = (state == COMPARE) |
                       (state == SH_INIT);

   assign o_alu_sub = ((opcode == OP_OP) & i_i_rd_dat[30])     ? 1'b1 :
                      ((opcode == OP_BRANCH) & (o_funct3 == 3'b100)) ? 1'b1 :
                      ((opcode == OP_OPIMM)  & (o_funct3 == 3'b000)) ? 1'b0 :
                      1'bx;

   assign o_alu_cmp_sel = (o_funct3[2:1] == 2'b00) ? ALU_CMP_EQ :
                          (o_funct3[2] == 1'b1)    ? ALU_CMP_LT :
                          (o_funct3[2:1] == 2'b01) ? ALU_CMP_LT : 1'bx;

   assign o_alu_cmp_neg = (opcode == OP_BRANCH) & o_funct3[0];

   assign o_alu_shamt_en = (state == SH_INIT) & (cnt < 5);

   assign o_alu_rd_sel = (o_funct3 == 3'b000) ? ALU_RESULT_ADD :
                         (o_funct3[2:1] == 2'b01) ? ALU_RESULT_LT :
                         (o_funct3 == 3'b101) ? ALU_RESULT_SR :
2'bxx;
   
   assign o_mem_en   = mem_op & cnt_en;
   assign o_mem_cmd  = (opcode == OP_STORE);

   assign o_mem_init = (state == MEM_INIT);

   assign o_rf_rd_addr  = i_i_rd_dat[11:7];
   assign o_funct3  = i_i_rd_dat[14:12];
   assign o_rf_rs1_addr = i_i_rd_dat[19:15];
   assign o_rf_rs2_addr = i_i_rd_dat[24:20];
   assign o_offset_source = (opcode == OP_JAL)    ? OFFSET_SOURCE_IMM :
                            (opcode == OP_AUIPC)  ? OFFSET_SOURCE_IMM :
                            (opcode == OP_BRANCH) ? OFFSET_SOURCE_IMM :
                            (opcode == OP_JALR)   ? OFFSET_SOURCE_IMM :
                            1'bx;

   assign o_op_b_source = (opcode == OP_OPIMM)  ? OP_B_SOURCE_IMM :
                          (opcode == OP_BRANCH) ? OP_B_SOURCE_RS2 :
                          (opcode == OP_OP)     ? OP_B_SOURCE_RS2 :
                          1'bx;

   assign o_mem_dat_valid = (o_funct3[1:0] == 2'b00) ? cnt < 8 : 
                            (o_funct3[1:0] == 2'b01) ? cnt < 16 : 1'b1;
   
   wire [4:0] opcode = i_i_rd_dat[6:2];


   assign o_rd_source = (opcode == OP_JAL)   ? RD_SOURCE_CTRL :
                        (opcode == OP_OPIMM) ? RD_SOURCE_ALU  :
                        (opcode == OP_OP)    ? RD_SOURCE_ALU  :
                        (opcode == OP_LUI)   ? RD_SOURCE_IMM  :
                        (opcode == OP_AUIPC) ? RD_SOURCE_CTRL :
                        (opcode == OP_JALR)  ? RD_SOURCE_CTRL :
                        (opcode == OP_LOAD)  ? RD_SOURCE_MEM  : 2'bxx;
   
   always @(cnt, opcode, i_i_rd_dat) begin
      o_imm = 1'bx;
      if (opcode == OP_JAL)
        if      (cnt > 19) o_imm = i_i_rd_dat[31];
        else if (cnt > 11) o_imm = i_i_rd_dat[cnt];
        else if (cnt > 10) o_imm = i_i_rd_dat[20];
        else if (cnt > 0)  o_imm = i_i_rd_dat[cnt+20];
        else               o_imm = 1'b0;
      else if ((opcode == OP_OPIMM) | (opcode == OP_JALR))
        if      (cnt > 10) o_imm = i_i_rd_dat[31];
        else               o_imm = i_i_rd_dat[cnt+20];
      else if ((opcode == OP_LUI) | (opcode == OP_AUIPC))
        if      (cnt > 11) o_imm = i_i_rd_dat[cnt];
        else               o_imm = 1'b0;
      else if (opcode == OP_LOAD)
        if (cnt > 10)      o_imm = i_i_rd_dat[31];
        else               o_imm = i_i_rd_dat[cnt+20];
      else if (opcode == OP_BRANCH)
        if      (cnt > 11) o_imm = i_i_rd_dat[31];
        else if (cnt > 10) o_imm = i_i_rd_dat[7];
        else if (cnt > 4) o_imm = i_i_rd_dat[cnt+20];
        else if (cnt > 0) o_imm = i_i_rd_dat[cnt+7];
        else               o_imm = 1'b0;
      else if (opcode == OP_STORE)
        if (cnt > 10)     o_imm = i_i_rd_dat[31];
        else if (cnt > 4) o_imm = i_i_rd_dat[cnt+20];
        else              o_imm = i_i_rd_dat[cnt+7];
   end

   wire go = i_i_rd_vld & o_i_rd_rdy;

   wire cnt_en =
        (state == RUN) |
        (state == COMPARE) |
        (state == SH_INIT) |
        (state == MEM_INIT);

   wire cnt_done = cnt == 31;
   assign running = (state == RUN);

   always @(posedge clk) begin
      state <= state;
      case (state)
        IDLE : begin
           if (go)
             state <= (opcode == OP_BRANCH) ? COMPARE  :
                      mem_op                ? MEM_INIT :
                      shift_op              ? SH_INIT  : RUN;
        end
        SH_INIT : begin
           if (cnt_done)
             state <= RUN;
        end
        COMPARE : begin
           if (cnt_done)
             state <= RUN;
        end
        MEM_INIT :
          if (cnt_done)
            state <= MEM_WAIT;
        MEM_WAIT :
          if (!i_mem_busy)
            state <= RUN;
        RUN : begin
           if (cnt_done)
             state <= IDLE;
        end
        default : state <= 3'bxxx;
      endcase

      cnt <= cnt + {4'd0,cnt_en};

      if (go) begin
        o_i_rd_rdy <= 1'b0;
      end else if (cnt_done & (state == RUN)) begin
         o_i_rd_rdy <= 1'b1;
      end
   end

endmodule
