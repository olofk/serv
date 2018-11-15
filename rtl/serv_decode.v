module serv_decode
  (
   input 	    clk,
   input [31:0]     i_wb_rdt,
   input 	    i_wb_en,
   output 	    o_ibus_active,
   output 	    o_ctrl_en,
   output 	    o_ctrl_jump,
   output 	    o_ctrl_jalr,
   output 	    o_ctrl_auipc,
   output reg 	    o_ctrl_trap = 1'b0,
   output 	    o_ctrl_mret,
   output 	    o_rf_rd_en,
   output reg [4:0] o_rf_rd_addr,
   output 	    o_rf_rs_en,
   output reg [4:0] o_rf_rs1_addr,
   output reg [4:0] o_rf_rs2_addr,
   output 	    o_alu_en,
   output 	    o_alu_init,
   output 	    o_alu_sub,
   output reg 	    o_alu_cmp_sel,
   output 	    o_alu_cmp_neg,
   output reg 	    o_alu_cmp_uns,
   input 	    i_alu_cmp,
   output 	    o_alu_shamt_en,
   output 	    o_alu_sh_signed,
   output 	    o_alu_sh_right,
   output reg [2:0] o_alu_rd_sel,
   output 	    o_mem_en,
   output 	    o_mem_cmd,
   output 	    o_mem_init,
   output reg 	    o_mem_dat_valid,
   input 	    i_mem_busy,
   input 	    i_mem_misalign,
   output 	    o_csr_en,
   output reg [2:0] o_csr_sel,
   output reg [1:0] o_csr_source,
   output reg [2:0] o_funct3,
   output reg 	    o_imm,
   output 	    o_offset_source,
   output 	    o_op_b_source,
   output [2:0]     o_rd_source);

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
     OP_JAL    = 5'b11011,
     OP_SYSTEM = 5'b11100;

   reg [2:0]    state = IDLE;

   reg [4:0] cnt     = 5'd0;

   wire      running;
   wire      mem_op;
   wire      shift_op;
   wire      csr_op;

   wire      jump_misaligned;

   reg       signbit;

   assign o_ibus_active = (state == IDLE);

   assign mem_op = (opcode == OP_LOAD) | (opcode == OP_STORE);
   assign shift_op = ((opcode == OP_OPIMM) & (o_funct3[1:0] == 2'b01)) |
                     ((opcode == OP_OP   ) & (o_funct3[1:0] == 2'b01));

   assign o_ctrl_en  = running;
   assign o_ctrl_jump = (opcode == OP_JAL) |
                        (opcode == OP_JALR) |
                        ((opcode == OP_BRANCH) & i_alu_cmp);

   assign o_ctrl_jalr = (opcode == OP_JALR);

   assign o_ctrl_auipc = (opcode == OP_AUIPC);

   assign o_ctrl_mret = (opcode == OP_SYSTEM) & imm[21] & !(|o_funct3);

   assign o_rf_rd_en = running & !o_ctrl_trap &
                       (opcode != OP_STORE) &
                       (opcode != OP_BRANCH);

   assign o_rf_rs_en = cnt_en;

   assign o_alu_en = cnt_en;

   assign o_alu_init = (state == COMPARE) |
                       (state == SH_INIT);

   assign o_alu_sub = (opcode == OP_OP) ? signbit /*    ? 1'b1*/ :
                      ((opcode == OP_BRANCH) & (o_funct3 == 3'b100)) ? 1'b1 :
                      ((opcode == OP_BRANCH) & (o_funct3 == 3'b101)) ? 1'b1 :
                      ((opcode == OP_BRANCH) & (o_funct3 == 3'b110)) ? 1'b1 :
                      ((opcode == OP_OPIMM)  & (o_funct3 == 3'b000)) ? 1'b0 :
                      1'bx;


   assign o_alu_cmp_neg = (opcode == OP_BRANCH) & o_funct3[0];

   assign o_csr_en = ((opcode == OP_SYSTEM) & (|o_funct3) | o_ctrl_mret | o_ctrl_trap) & running;

   always @(o_funct3) begin
      casez (o_funct3)
        3'b00?  : o_alu_cmp_sel = ALU_CMP_EQ;
        3'b01?  : o_alu_cmp_sel = ALU_CMP_LT;
        3'b1??  : o_alu_cmp_sel = ALU_CMP_LT;
        default : o_alu_cmp_sel = 1'bx;
      endcase

      casez (o_funct3)
        3'b00?  : o_alu_cmp_uns = 1'b0;
        3'b010  : o_alu_cmp_uns = 1'b0;
        3'b011  : o_alu_cmp_uns = 1'b1;
        3'b10?  : o_alu_cmp_uns = 1'b0;
        3'b11?  : o_alu_cmp_uns = 1'b1;
        default : o_alu_cmp_uns = 1'bx;
      endcase

      casez(o_funct3)
        3'b000  : o_alu_rd_sel = ALU_RESULT_ADD;
        3'b001  : o_alu_rd_sel = ALU_RESULT_SR;
        3'b01?  : o_alu_rd_sel = ALU_RESULT_LT;
        3'b100  : o_alu_rd_sel = ALU_RESULT_XOR;
        3'b101  : o_alu_rd_sel = ALU_RESULT_SR;
        3'b110  : o_alu_rd_sel = ALU_RESULT_OR;
        3'b111  : o_alu_rd_sel = ALU_RESULT_AND;
        default : o_alu_rd_sel = 3'bxx;
      endcase

      casez(o_funct3[1:0])
	2'b01   : o_csr_source = CSR_SOURCE_EXT; //Check for x0
	2'b10   : o_csr_source = CSR_SOURCE_SET;
	2'b11   : o_csr_source = CSR_SOURCE_CLR;
	default : o_csr_source = 2'bxx;
      endcase
      if ((o_rf_rs1_addr == 5'd0) | o_ctrl_trap | o_ctrl_mret)
	o_csr_source = CSR_SOURCE_CSR;

      casez(imm[31:20])
	12'h305 : o_csr_sel = CSR_SEL_MTVEC;
	12'h341 : o_csr_sel = CSR_SEL_MEPC;
	12'h342 : o_csr_sel = CSR_SEL_MCAUSE;
	12'h343 : o_csr_sel = CSR_SEL_MTVAL;
	//12'hf14 : o_csr_sel = CSR_SEL_MHARTID;
	default : begin
	   o_csr_sel = 3'bxxx;
	   if (o_csr_en) begin
	      $display("%0t: CSR %03h not implemented", $time, imm[31:20]);
	      //#100 $finish;
	   end
	end
      endcase
      if (o_ctrl_trap)
	o_csr_sel = CSR_SEL_MTVEC;
      if (o_ctrl_mret)
	o_csr_sel = CSR_SEL_MEPC;
   end
   assign o_alu_shamt_en = (state == SH_INIT) & (cnt < 5);
   assign o_alu_sh_signed = signbit;
   assign o_alu_sh_right = o_funct3[2];

   assign o_mem_en   = mem_op & cnt_en;
   assign o_mem_cmd  = (opcode == OP_STORE);

   assign o_mem_init = (state == MEM_INIT);

   assign jal_misalign  = imm[21] & (opcode == OP_JAL);

   reg [4:0] opcode;
   reg [31:0] imm;

   always @(posedge clk) begin
      if (i_wb_en) begin
         o_rf_rd_addr  <= i_wb_rdt[11:7];
         o_rf_rs1_addr <= i_wb_rdt[19:15];
         o_rf_rs2_addr <= i_wb_rdt[24:20];
         o_funct3      <= i_wb_rdt[14:12];
         signbit       <= i_wb_rdt[30];
         opcode        <= i_wb_rdt[6:2];
         imm           <= i_wb_rdt;
      end
   end

   assign o_offset_source = (opcode == OP_JAL)    ? OFFSET_SOURCE_IMM :
                            (opcode == OP_AUIPC)  ? OFFSET_SOURCE_IMM :
                            (opcode == OP_BRANCH) ? OFFSET_SOURCE_IMM :
                            (opcode == OP_JALR)   ? OFFSET_SOURCE_IMM :
                            1'bx;

   assign o_op_b_source = (opcode == OP_OPIMM)  ? OP_B_SOURCE_IMM :
                          (opcode == OP_BRANCH) ? OP_B_SOURCE_RS2 :
                          (opcode == OP_OP)     ? OP_B_SOURCE_RS2 :
                          1'bx;

   always @(o_funct3, cnt, o_mem_init)
     if (o_mem_init)
       o_mem_dat_valid = 1'bx;
     else
       casez(o_funct3[1:0])
         2'b00 : o_mem_dat_valid = (cnt < 8);
         2'b01 : o_mem_dat_valid = (cnt < 16);
         2'b10 : o_mem_dat_valid = 1'b1;
         default: o_mem_dat_valid = 1'bx;
       endcase



   assign o_rd_source = (opcode == OP_JAL)   ? RD_SOURCE_CTRL :
                        (opcode == OP_OPIMM) ? RD_SOURCE_ALU  :
                        (opcode == OP_OP)    ? RD_SOURCE_ALU  :
                        (opcode == OP_LUI)   ? RD_SOURCE_IMM  :
                        (opcode == OP_AUIPC) ? RD_SOURCE_CTRL :
                        (opcode == OP_JALR)  ? RD_SOURCE_CTRL :
                        (opcode == OP_SYSTEM) ? RD_SOURCE_CSR :
                        (opcode == OP_LOAD)  ? RD_SOURCE_MEM  : 3'bxx;

   //31, cnt, 20, +20, +7, 7, 1'b0
   always @(cnt, opcode, imm) begin
      o_imm = 1'bx;
      if (opcode == OP_JAL)
        if      (cnt > 19) o_imm = imm[31];
        else if (cnt > 11) o_imm = imm[cnt];
        else if (cnt > 10) o_imm = imm[20];
        else if (cnt > 0)  o_imm = imm[cnt+20];
        else               o_imm = 1'b0;
      else if ((opcode == OP_OPIMM) | (opcode == OP_JALR))
        if      (cnt > 10) o_imm = imm[31];
        else               o_imm = imm[cnt+20];
      else if ((opcode == OP_LUI) | (opcode == OP_AUIPC))
        if      (cnt > 11) o_imm = imm[cnt];
        else               o_imm = 1'b0;
      else if (opcode == OP_LOAD)
        if (cnt > 10)      o_imm = imm[31];
        else               o_imm = imm[cnt+20];
      else if (opcode == OP_BRANCH)
        if      (cnt > 11) o_imm = imm[31];
        else if (cnt > 10) o_imm = imm[7];
        else if (cnt > 4) o_imm = imm[cnt+20];
        else if (cnt > 0) o_imm = imm[cnt+7];
        else               o_imm = 1'b0;
      else if (opcode == OP_STORE)
        if (cnt > 10)     o_imm = imm[31];
        else if (cnt > 4) o_imm = imm[cnt+20];
        else              o_imm = imm[cnt+7];
   end

   reg go = 1'b0;
   always @(posedge clk)
     go <= i_wb_en;

   wire cnt_en =
        (state == RUN) |
        (state == COMPARE) |
        (state == SH_INIT) |
        (state == MEM_INIT);

   wire cnt_done = cnt == 31;
   assign running = (state == RUN);

   always @(posedge clk) begin
      if (cnt_done)
	o_ctrl_trap <= i_mem_misalign;
      if (go)
	o_ctrl_trap <= jal_misalign;
      state <= state;
      case (state)
        IDLE : begin
           if (go)
             state <= (opcode == OP_BRANCH) ? COMPARE  :
                      (((opcode == OP_OPIMM) | (opcode == OP_OP))& (o_funct3[2:1] == 2'b01)) ? COMPARE :
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

   end
`define SERV_DECODE_CHECKS
`ifdef SERV_DECODE_CHECKS
   reg unknown_op = 1'b0;

   always @(opcode)
     if (i_wb_en) begin
	if (!((opcode == OP_LOAD) |
	      (opcode == OP_STORE ) |
	      (opcode == OP_OPIMM ) |
	      (opcode == OP_AUIPC ) |
	      (opcode == OP_OP    ) |
	      (opcode == OP_LUI   ) |
	      (opcode == OP_BRANCH) |
	      (opcode == OP_JALR  ) |
	      (opcode == OP_SYSTEM  ) |
	      (opcode == OP_JAL   ))) begin
	   $display("Unknown opcode %b at %0t", opcode, $time);
	end // if ((opcode != OP_LOAD) |...
     end // if (i_wb_en)
`endif
endmodule
