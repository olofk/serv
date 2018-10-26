module serv_decode
  (
   input        clk,
   input [31:0] i_i_rd_dat,
   input        i_i_rd_vld,
   output reg   o_i_rd_rdy = 1'b1,
   output       o_ctrl_en,
   output       o_ctrl_jump,
   output [2:0] o_funct3,
   output       o_rf_rd_en,
   output [4:0] o_rf_rd_addr,
   output       o_rf_rs_en,
   output [4:0] o_rf_rs1_addr,
   output [4:0] o_rf_rs2_addr,
   output       o_mem_en,
   output       o_mem_init,
   output       o_mem_dat_valid, 
   input        i_mem_busy,
   output reg   o_imm,
   output       o_offset_source,
   output       o_op_b_source,
   output [1:0] o_rd_source);

`include "serv_params.vh"


   localparam [1:0]
     IDLE     = 2'd0,
     MEM_INIT = 2'd1,
     MEM_WAIT = 2'd2,
     RUN      = 2'd3;
   
   localparam [4:0]
     OP_LOAD  = 5'b00000,
     OP_OPIMM = 5'b00100,
     OP_LUI   = 5'b01101,
     OP_JAL   = 5'b11011;

   reg [1:0]    state = 2'd0;
   
   reg [4:0] cnt     = 5'd0;

   wire      running;
   wire      mem_op;
   assign mem_op = (opcode == OP_LOAD);

   assign o_ctrl_en  = running;
   assign o_ctrl_jump = (opcode == OP_JAL);

   assign o_rf_rd_en = running & ((opcode == OP_JAL)   |
                                  (opcode == OP_OPIMM) |
                                  (opcode == OP_LUI));
   assign o_rf_rs_en = (running & (opcode == OP_OPIMM)) |
                       (state == MEM_INIT);
   assign o_mem_en   = mem_op & cnt_en;
   assign o_mem_init = (state == MEM_INIT);

   assign o_rf_rd_addr  = i_i_rd_dat[11:7];
   assign o_funct3  = i_i_rd_dat[14:12];
   assign o_rf_rs1_addr = i_i_rd_dat[19:15];
   assign o_rf_rs2_addr = i_i_rd_dat[24:20];
   assign o_offset_source = (opcode == OP_JAL) ? OFFSET_SOURCE_IMM : 1'b0;

   assign o_op_b_source = (opcode == OP_OPIMM) ? OP_B_SOURCE_IMM : 1'b0;

   assign o_mem_dat_valid = (o_funct3[1:0] == 2'b00) ? cnt < 8 : 
                            (o_funct3[1:0] == 2'b01) ? cnt < 16 : 1'b1;
   
   wire [4:0] opcode = i_i_rd_dat[6:2];


   assign o_rd_source = (opcode == OP_JAL)   ? RD_SOURCE_CTRL :
                        (opcode == OP_OPIMM) ? RD_SOURCE_ALU  :
                        (opcode == OP_LUI)   ? RD_SOURCE_IMM  : 2'b00;
   
   always @(cnt, opcode) begin
      o_imm = 1'bx;
      if (opcode == OP_JAL)
        if      (cnt > 19) o_imm = i_i_rd_dat[31];
        else if (cnt > 11) o_imm = i_i_rd_dat[cnt];
        else if (cnt > 10) o_imm = i_i_rd_dat[20];
        else if (cnt > 0)  o_imm = i_i_rd_dat[cnt+20];
        else               o_imm = 1'b0;
      else if (opcode == OP_OPIMM)
        if      (cnt > 10) o_imm = i_i_rd_dat[31];
        else               o_imm = i_i_rd_dat[cnt+20];
      else if (opcode == OP_LUI)
        if      (cnt > 11) o_imm = i_i_rd_dat[cnt];
        else               o_imm = 1'b0;
      else if (opcode == OP_LOAD)
        if (cnt > 10)      o_imm = i_i_rd_dat[31];
        else               o_imm = i_i_rd_dat[cnt+20];
   end

   wire go = i_i_rd_vld & o_i_rd_rdy;

   wire cnt_en = (state == RUN) | (state == MEM_INIT);

   wire cnt_done = cnt == 31;
   assign running = (state == RUN);

   always @(posedge clk) begin
      state <= state;
      case (state)
        IDLE : begin
           if (go)
             state <= mem_op ? MEM_INIT : RUN;
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
      endcase

      cnt <= cnt + {4'd0,cnt_en};

      if (go) begin
        o_i_rd_rdy <= 1'b0;
      end else if (cnt_done & (state == RUN)) begin
         o_i_rd_rdy <= 1'b1;
      end
   end

endmodule
