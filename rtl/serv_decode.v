`default_nettype none
module serv_decode
  (
   input wire 	     clk,
   input wire 	     i_rst,
   input wire 	     i_mtip,
   input wire 	     i_timer_irq_en,
   input wire [31:0] i_wb_rdt,
   input wire 	     i_wb_en,
   input wire 	     i_rf_ready,
   output wire [4:0] o_cnt,
   output reg [3:0]  o_cnt_r,
   output wire 	     o_cnt_done,
   output wire 	     o_ctrl_en,
   output wire 	     o_ctrl_pc_en,
   output reg 	     o_ctrl_jump,
   output wire 	     o_ctrl_jalr,
   output wire 	     o_ctrl_jal_or_jalr,
   output wire 	     o_ctrl_utype,
   output wire 	     o_ctrl_lui,
   output wire 	     o_ctrl_trap,
   output wire 	     o_ctrl_mret,
   input wire 	     i_ctrl_misalign,
   output wire 	     o_rf_rd_en,
   output reg [4:0]  o_rf_rd_addr,
   output reg [4:0]  o_rf_rs1_addr,
   output reg [4:0]  o_rf_rs2_addr,
   output wire 	     o_alu_en,
   output wire 	     o_alu_init,
   output wire 	     o_alu_sub,
   output wire [1:0] o_alu_bool_op,
   output reg 	     o_alu_cmp_sel,
   output wire 	     o_alu_cmp_neg,
   output reg 	     o_alu_cmp_uns,
   input wire 	     i_alu_cmp,
   output wire 	     o_alu_shamt_en,
   output wire 	     o_alu_sh_signed,
   output wire 	     o_alu_sh_right,
   output reg [1:0]  o_alu_rd_sel,
   output wire 	     o_mem_en,
   output wire 	     o_mem_cmd,
   output wire 	     o_mem_init,
   output wire [1:0] o_mem_bytecnt,
   input wire 	     i_mem_misalign,
   output wire 	     o_csr_mstatus_en,
   output wire 	     o_csr_mie_en,
   output wire 	     o_csr_mtvec_en,
   output wire 	     o_csr_mip_en,
   output wire 	     o_csr_mscratch_en,
   output wire 	     o_csr_mepc_en,
   output wire 	     o_csr_mcause_en,
   output wire 	     o_csr_mtval_en,
   output reg [1:0]  o_csr_source,
   output reg [3:0]  o_csr_mcause,
   output wire 	     o_csr_imm,
   output wire 	     o_csr_d_sel,
   output reg [2:0]  o_funct3,
   output wire 	     o_imm,
   output wire 	     o_op_b_source,
   output wire 	     o_rd_alu_en,
   output wire 	     o_rd_mem_en);

`include "serv_params.vh"

   localparam [1:0]
     IDLE     = 2'd0,
     INIT     = 2'd1,
     RUN      = 2'd2,
     TRAP     = 2'd3;

   reg [1:0]    state;

   reg [4:0] cnt;
   reg 	cnt_done;

   reg [4:0] opcode;
   reg [31:0] imm;
   reg 	      op20;
   reg 	      op21;
   reg 	      op22;
   reg 	      op26;

   assign o_cnt = cnt;

   wire      running;
   wire      mem_op;
   wire      shift_op;
   wire      slt_op;
   wire      branch_op;
   wire      e_op;

   reg       imm30;

   assign o_cnt_done = cnt_done;

   assign mem_op = !opcode[4] & !opcode[2] & !opcode[0];

   wire      op_or_opimm = (!opcode[4] & opcode[2] & !opcode[0]);

   assign shift_op = op_or_opimm & (o_funct3[1:0] == 2'b01);
   assign slt_op   = op_or_opimm & (o_funct3[2:1] == 2'b01);

   assign branch_op = (opcode[4:2] == 3'b110) & !opcode[0];

   assign e_op = (opcode[4:2] == 3'b111) & !op21 & !(|o_funct3);

   assign o_ctrl_pc_en  = running | o_ctrl_trap;
   wire take_branch = (opcode[4:2] == 3'b110) & (opcode[0] | i_alu_cmp);

   assign o_ctrl_jalr = opcode[4] & (opcode[1:0] == 2'b01);

   assign o_ctrl_utype = !opcode[4] & opcode[2] & opcode[0];
   assign o_ctrl_jal_or_jalr = opcode[4] & opcode[0];
   assign o_ctrl_mret = (opcode[4] & opcode[2]) & op21 & !(|o_funct3);

   assign o_rf_rd_en = running & (opcode[2] |
				  (!opcode[2] & opcode[4] & opcode[0]) |
				  (!opcode[2] & !opcode[3] & !opcode[0]));

   assign o_alu_en   = cnt_en;
   assign o_ctrl_en  = cnt_en;

   assign o_ctrl_lui = (opcode[0] & !opcode[4] & opcode[3]);


   assign o_alu_init = (state == INIT);

   reg alu_sub_r;
   assign o_alu_sub = alu_sub_r;

   always @(posedge clk)
     alu_sub_r <= opcode[3] & imm30;

   assign o_alu_cmp_neg = branch_op & o_funct3[0];
   /*
    300 0_000 mstatus RWSC
    304 0_100 mie SCWi
    305 0_101 mtvec RW
    340 1_000 mscratch
    341 1_001 mepc  RW
    342 1_010 mcause R
    343 1_011 mtval
    344 1_100 mip CWi
    */
   assign o_csr_mstatus_en = csr_en & !op26 & !op22;
   assign o_csr_mie_en     = csr_en & !op26 &  op22 & !op20;
   assign o_csr_mtvec_en = ((!op26 & op20 & opcode[4] & opcode[2]) & state[1]) | (state == TRAP);
   assign o_csr_mscratch_en = csr_en & op26 & !op22 & !op21 & !op20;
   assign o_csr_mepc_en     = csr_en & op26         & !op21 &  op20 | (o_ctrl_mret & state[1]);
   assign o_csr_mcause_en   = csr_en                &  op21 & !op20;
   assign o_csr_mtval_en    = csr_en                &  op21 &  op20;
   assign o_csr_mip_en      = csr_en & op26 & op22;

   wire csr_en = opcode[4] & opcode[2] & (|o_funct3) & running;


   always @(o_funct3, o_rf_rs1_addr, o_ctrl_trap, o_ctrl_mret) begin
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

      casez(o_funct3[1:0])
	2'b01   : o_csr_source = CSR_SOURCE_EXT; //Check for x0
	2'b10   : o_csr_source = CSR_SOURCE_SET;
	2'b11   : o_csr_source = CSR_SOURCE_CLR;
	default : o_csr_source = 2'bxx;
      endcase
      if (((o_rf_rs1_addr == 5'd0) & o_funct3[1]) | o_ctrl_trap | o_ctrl_mret)
	o_csr_source = CSR_SOURCE_CSR;

   end

   assign o_csr_imm = (cnt < 5) ? o_rf_rs1_addr[cnt[2:0]] : 1'b0;
   assign o_csr_d_sel = o_funct3[2];

   assign o_alu_shamt_en = (cnt < 5) & (state == INIT);
   assign o_alu_sh_signed = imm30;
   assign o_alu_sh_right = o_funct3[2];

   assign o_mem_en   = mem_op & cnt_en;
   assign o_mem_cmd  = opcode[3];

   assign o_mem_init = mem_op & (state == INIT);
   assign o_mem_bytecnt = cnt[4:3];

   assign o_alu_bool_op = o_funct3[1:0];

   always @(posedge clk) begin
      casez(o_funct3)
        3'b000  : o_alu_rd_sel <= ALU_RESULT_ADD;
        3'b001  : o_alu_rd_sel <= ALU_RESULT_SR;
        3'b01?  : o_alu_rd_sel <= ALU_RESULT_LT;
        3'b100  : o_alu_rd_sel <= ALU_RESULT_BOOL;
        3'b101  : o_alu_rd_sel <= ALU_RESULT_SR;
        3'b11?  : o_alu_rd_sel <= ALU_RESULT_BOOL;
      endcase // casez (o_funct3)

      if (i_wb_en) begin
         o_rf_rd_addr  <= i_wb_rdt[11:7];
         o_rf_rs1_addr <= i_wb_rdt[19:15];
         o_rf_rs2_addr <= i_wb_rdt[24:20];
         o_funct3      <= i_wb_rdt[14:12];
         imm30         <= i_wb_rdt[30];
         opcode        <= i_wb_rdt[6:2];
	 op20 <= i_wb_rdt[20];
	 op21 <= i_wb_rdt[21];
	 op22 <= i_wb_rdt[22];
	 op26 <= i_wb_rdt[26];

	 imm[31] <= sign_bit;
	 imm[30:20] <= utype ? i_wb_rdt[30:20] : {11{sign_bit}};
	 imm[19:12] <= (utype | jtype) ? i_wb_rdt[19:12] : {8{sign_bit}};
	 imm[11]    <= btype ? i_wb_rdt[7] :
		       utype ? 1'b0 :
		       jtype ? i_wb_rdt[20] :
		       sign_bit;
	 imm[10:5]  <= utype ? 6'd0 : i_wb_rdt[30:25];
	 imm[4:1]   <= (sorbtype) ? i_wb_rdt[11:8] :
		       (iorjtype) ? i_wb_rdt[24:21] :
		       4'd0;
	 imm[0]     <= itype ? i_wb_rdt[20] :
		       stype ? i_wb_rdt[7] :
		       1'b0;
      end
      if (cnt_en)
	imm <= {imm[0], imm[31:1]};
   end

   wire [4:0] op_code = i_wb_rdt[6:2];

   wire btype = op_code[4] & !op_code[2] & !op_code[0];
   wire itype = (!op_code[3] & !op_code[0]) | (!op_code[2]&!op_code[1]&op_code[0]) | (!op_code[0]&op_code[2]);
   wire jtype = op_code[1];
   wire stype = op_code[3] & ~op_code[2] & ~op_code[4];
   wire utype = !op_code[4] & op_code[0];

   wire iorjtype = (op_code[0] & ~op_code[2]) | (op_code[2] & ~op_code[0]) | (~op_code[0] & ~op_code[3]);
   wire sorbtype = op_code[3:0] == 4'b1000;
   wire sign_bit = i_wb_rdt[31];

   assign o_imm = imm[0];

   //0 (OP_B_SOURCE_IMM) when OPIMM
   //1 (OP_B_SOURCE_RS2) when BRANCH or OP
   assign o_op_b_source = opcode[3];

   assign o_rd_alu_en  = !opcode[0] & opcode[2] & !opcode[4];
   assign o_rd_mem_en =              !opcode[2] & !opcode[4];

   wire cnt_en = (state != IDLE);

   assign running = (state == RUN);

   assign o_ctrl_trap = (state == TRAP);

   always @(posedge clk) begin
      o_csr_mcause[3:0] <= 4'd0;
      if (i_mem_misalign)
	o_csr_mcause[3:0] <= {2'b01, o_mem_cmd, 1'b0};
      if (e_op)
	o_csr_mcause <= {!op20,3'b011};
   end

   //slt*, branch/jump, shift, load/store
   wire two_stage_op =
        slt_op | (opcode[4:2] == 3'b110) | (opcode[2:1] == 2'b00) |
        shift_op;
   reg 	stage_one_done;

   reg 	mtip_r;
   reg 	pending_irq;

   always @(posedge clk) begin
      if (state == INIT)
	o_ctrl_jump <= take_branch;
      if (state == IDLE)
	o_ctrl_jump <= 1'b0;

      mtip_r <= i_mtip;

      if (i_mtip & !mtip_r & i_timer_irq_en)
	pending_irq <= 1'b1;

      cnt_done <= (cnt[4:2] == 3'b111) & o_cnt_r[2];

      case (state)
        IDLE : begin
           if (i_rf_ready) begin
	      state <= RUN;
              if (two_stage_op & !stage_one_done)
		state <= INIT;
	      if (e_op | pending_irq)
		state <= TRAP;
	   end
        end
        INIT : begin
	   stage_one_done <= 1'b1;

           if (cnt_done)
             state <= (i_mem_misalign | (take_branch & i_ctrl_misalign)) ? TRAP :
		      mem_op ? IDLE : RUN;
        end
        RUN : begin
	   stage_one_done <= 1'b0;
           if (cnt_done)
             state <= IDLE;
        end
	TRAP : begin
	   pending_irq <= 1'b0;
           if (cnt_done)
             state <= IDLE;
	end
        default : state <= IDLE;
      endcase

      cnt <= cnt + {4'd0,cnt_en};
      if (cnt_en)
	o_cnt_r <= {o_cnt_r[2:0],o_cnt_r[3]};

      if (i_rst) begin
	 state <= IDLE;
	 cnt   <= 5'd0;
	 pending_irq <= 1'b0;
	 stage_one_done <= 1'b0;
	 o_ctrl_jump <= 1'b0;
	 o_cnt_r <= 4'b0001;
      end
   end
endmodule
