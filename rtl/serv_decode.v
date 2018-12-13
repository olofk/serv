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
   output wire 	     o_cnt_done,
   output wire 	     o_ctrl_en,
   output wire 	     o_ctrl_pc_en,
   output reg 	     o_ctrl_jump,
   output wire 	     o_ctrl_jalr,
   output wire 	     o_ctrl_auipc,
   output wire 	     o_ctrl_lui,
   output wire 	     o_ctrl_trap,
   output wire 	     o_ctrl_mret,
   input wire 	     i_ctrl_misalign,
   output wire 	     o_rf_rd_en,
   output reg [4:0]  o_rf_rd_addr,
   output wire 	     o_rf_rs_en,
   output reg [4:0]  o_rf_rs1_addr,
   output reg [4:0]  o_rf_rs2_addr,
   output wire 	     o_alu_en,
   output wire 	     o_alu_init,
   output wire 	     o_alu_sub,
   output reg 	     o_alu_cmp_sel,
   output wire 	     o_alu_cmp_neg,
   output reg 	     o_alu_cmp_uns,
   input wire 	     i_alu_cmp,
   output wire 	     o_alu_shamt_en,
   output wire 	     o_alu_sh_signed,
   output wire 	     o_alu_sh_right,
   output reg [2:0]  o_alu_rd_sel,
   output wire 	     o_mem_en,
   output wire 	     o_mem_cmd,
   output wire 	     o_mem_init,
   output wire [1:0] o_mem_bytecnt,
   input wire 	     i_mem_misalign,
   output wire 	     o_csr_en,
   output reg [2:0]  o_csr_sel,
   output reg [1:0]  o_csr_source,
   output reg [3:0]  o_csr_mcause,
   output wire 	     o_csr_imm,
   output wire 	     o_csr_d_sel,
   output reg [2:0]  o_funct3,
   output wire 	     o_imm,
   output wire 	     o_op_b_source,
   output wire 	     o_rd_ctrl_en,
   output wire 	     o_rd_alu_en,
   output wire 	     o_rd_csr_en,
   output wire 	     o_rd_mem_en);

`include "serv_params.vh"

   localparam [1:0]
     IDLE     = 2'd0,
     INIT     = 2'd1,
     RUN      = 2'd2,
     TRAP     = 2'd3;

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

   reg [1:0]    state;

   reg [4:0] cnt;
   reg 	cnt_done;

   reg [4:0] opcode;
   reg [30:7] op;
   reg 	      signbit;

   reg [8:0]  imm19_12_20;
   reg 	      imm7;
   reg [5:0]  imm30_25;
   reg [4:0]  imm24_20;
   reg [4:0]  imm11_7;

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

   assign e_op = (opcode[4:2] == 3'b111) & !(|o_funct3);

   assign o_ctrl_pc_en  = running | o_ctrl_trap;
   wire take_branch = (opcode[4:2] == 3'b110) & (opcode[0] | i_alu_cmp);

   assign o_ctrl_jalr = opcode[4] & (opcode[2:0] == 3'b001);

   assign o_ctrl_auipc = !opcode[3] & opcode[2] & opcode[0];

   assign o_ctrl_mret = (opcode[4] & opcode[2]) & op[21] & !(|o_funct3);

   assign o_rf_rd_en = running & (opcode[2] |
				  (!opcode[2] & opcode[4] & opcode[0]) |
				  (!opcode[2] & !opcode[3] & !opcode[0]));

   assign o_rf_rs_en = cnt_en;
   assign o_alu_en   = cnt_en;
   assign o_ctrl_en  = cnt_en;

   assign o_ctrl_lui = (opcode[0] & !opcode[4] & opcode[3]);


   assign o_alu_init = (state == INIT);

   reg alu_sub_r;
   assign o_alu_sub = alu_sub_r;

   always @(posedge clk)
     alu_sub_r <= (opcode == OP_OP) ? imm30 /*    ? 1'b1*/ :
                  (branch_op & (o_funct3 == 3'b100)) ? 1'b1 :
                  (branch_op & (o_funct3 == 3'b101)) ? 1'b1 :
                  (branch_op & (o_funct3 == 3'b110)) ? 1'b1 :
                  1'b0;


   assign o_alu_cmp_neg = branch_op & o_funct3[0];

   assign o_csr_en = ((((opcode[4] & opcode[2]) & (|o_funct3)) |
		     o_ctrl_mret) & running) | o_ctrl_trap;

   wire [3:0] csr_sel = {op[26],op[22:20]};

   always @(o_funct3, op, csr_sel, o_rf_rs1_addr, o_ctrl_trap, o_ctrl_mret) begin
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

      casez(csr_sel)
	4'b0_000 : o_csr_sel = CSR_SEL_MSTATUS;
	4'b0_100 : o_csr_sel = CSR_SEL_MIE;
	4'b0_101 : o_csr_sel = CSR_SEL_MTVEC;
	4'b1_000 : o_csr_sel = CSR_SEL_MSCRATCH;
	4'b1_001 : o_csr_sel = CSR_SEL_MEPC;
	4'b1_010 : o_csr_sel = CSR_SEL_MCAUSE;
	4'b1_011 : o_csr_sel = CSR_SEL_MTVAL;
	4'b1_100 : o_csr_sel = CSR_SEL_MIP;
	default : begin
	   o_csr_sel = 3'bxxx;
	   /*if (o_csr_en) begin
	      $display("%0t: CSR %03h not implemented", $time, op[31:20]);
	      //#100 $finish;
	   end*/
	end
      endcase
      if (o_ctrl_trap)
	o_csr_sel = CSR_SEL_MTVEC;
      if (o_ctrl_mret)
	o_csr_sel = CSR_SEL_MEPC;
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

   wire jal_misalign  = op[21] & opcode[1] & opcode[4];


   always @(posedge clk) begin
      casez(o_funct3)
        3'b000  : o_alu_rd_sel <= ALU_RESULT_ADD;
        3'b001  : o_alu_rd_sel <= ALU_RESULT_SR;
        3'b01?  : o_alu_rd_sel <= ALU_RESULT_LT;
        3'b100  : o_alu_rd_sel <= ALU_RESULT_XOR;
        3'b101  : o_alu_rd_sel <= ALU_RESULT_SR;
        3'b110  : o_alu_rd_sel <= ALU_RESULT_OR;
        3'b111  : o_alu_rd_sel <= ALU_RESULT_AND;
        //default : o_alu_rd_sel <= 3'bxx;
      endcase

      if (i_wb_en) begin
         o_rf_rd_addr  <= i_wb_rdt[11:7];
         o_rf_rs1_addr <= i_wb_rdt[19:15];
         o_rf_rs2_addr <= i_wb_rdt[24:20];
         o_funct3      <= i_wb_rdt[14:12];
         imm30         <= i_wb_rdt[30];
         opcode        <= i_wb_rdt[6:2];
         op           <= i_wb_rdt[30:7];
	 signbit       <= i_wb_rdt[31];
      end
      if (cnt_done | i_rf_ready) begin
	 imm19_12_20 <= {op[19:12],op[20]};
	 imm7 <= op[7];
	 imm30_25 <= op[30:25];
	 imm24_20 <= op[24:20];
	 imm11_7  <= op[11:7];

      end else begin
	 imm19_12_20 <= {m3 ? signbit : imm24_20[0], imm19_12_20[8:1]};
	 imm7        <= signbit;
	 imm30_25    <= {m2[1] ? imm7 : m2[0] ? signbit : imm19_12_20[0], imm30_25[5:1]};
	 imm24_20    <= {imm30_25[0], imm24_20[4:1]};
	 imm11_7     <= {imm30_25[0], imm11_7[4:1]};
      end
   end

   wire utype = !opcode[4] & (opcode[2:0] == 3'b101);
   wire sorbtype = opcode[3:0] == 4'b1000;
   wire iorstype = (opcode == OP_OPIMM) | (opcode == OP_JALR) | (opcode == OP_LOAD) | (opcode == OP_STORE);

   wire m1 = sorbtype;

   wire [1:0] m2;
   assign m2[1] = (opcode == OP_BRANCH);
   assign m2[0] = iorstype;

   wire m3 = opcode[4];

   wire gate1  = (cnt == 0) & ((opcode == OP_BRANCH) | (opcode[1] & opcode[4]));
   wire gate12 = (cnt < 12) & utype;

   assign o_imm = (!(gate1 | gate12) & (cnt_done ? signbit : m1 ? imm11_7[0] : imm24_20[0]));

   assign o_op_b_source = (opcode == OP_OPIMM)  ? OP_B_SOURCE_IMM :
                          (opcode == OP_BRANCH) ? OP_B_SOURCE_RS2 :
                          (opcode == OP_OP)     ? OP_B_SOURCE_RS2 :
                          1'bx;

   assign o_rd_ctrl_en =  opcode[0];
   assign o_rd_alu_en  = !opcode[0] & opcode[2] & !opcode[4];
   assign o_rd_csr_en =               opcode[2] &  opcode[4];
   assign o_rd_mem_en =              !opcode[2] & !opcode[4];

   wire cnt_en = (state != IDLE);

   assign running = (state == RUN);

   assign o_ctrl_trap = (state == TRAP);

   always @(posedge clk) begin
      o_csr_mcause[3:0] <= 4'd0;
      if (i_mem_misalign)
	o_csr_mcause[3:0] <= {2'b01, o_mem_cmd, 1'b0};
      if (e_op)
	o_csr_mcause <= {!op[20],3'b011};
   end

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

      cnt_done <= cnt == 30;

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

      if (i_rst) begin
	 state <= IDLE;
	 cnt   <= 5'd0;
	 pending_irq <= 1'b0;
	 stage_one_done <= 1'b0;
	 o_ctrl_jump <= 1'b0;
      end
   end
endmodule
