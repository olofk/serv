`default_nettype none
module serv_decode
  (
   input wire 	     clk,
   input wire 	     i_rst,
   input wire [31:0] i_wb_rdt,
   input wire 	     i_wb_en,
   output wire 	     o_cnt_done,
   output wire 	     o_ibus_active,
   output wire 	     o_ctrl_en,
   output wire 	     o_ctrl_pc_en,
   output wire 	     o_ctrl_jump,
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
   output reg 	     o_mem_dat_valid,
   input wire 	     i_mem_dbus_ack,
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
   output wire [1:0] o_rd_source);

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

   reg [1:0]    state = IDLE;
   reg 		go;

   reg [4:0] cnt     = 5'd0;

   wire      running;
   wire      mem_op;
   wire      shift_op;
   wire      csr_op;
   wire      slt_op;
   wire      branch_op;
   wire      e_op;
   wire      jump_misaligned;

   reg       imm30;

   assign o_cnt_done = cnt_done;

   assign o_ibus_active = (state == IDLE);

   assign mem_op = (opcode == OP_LOAD) | (opcode == OP_STORE);
   assign shift_op = ((opcode == OP_OPIMM) & (o_funct3[1:0] == 2'b01)) |
                     ((opcode == OP_OP   ) & (o_funct3[1:0] == 2'b01));

   assign slt_op = (((opcode == OP_OPIMM) | (opcode == OP_OP)) &
		    (o_funct3[2:1] == 2'b01));

   assign branch_op = (opcode == OP_BRANCH);

   assign e_op = (opcode == OP_SYSTEM) & !(|o_funct3);

   assign o_ctrl_pc_en  = running | o_ctrl_trap;
   assign o_ctrl_jump = (opcode == OP_JAL) |
                        (opcode == OP_JALR) |
                        (branch_op & i_alu_cmp);

   assign o_ctrl_jalr = (opcode == OP_JALR);

   assign o_ctrl_auipc = (opcode == OP_AUIPC);

   assign o_ctrl_mret = (opcode == OP_SYSTEM) & imm[21] & !(|o_funct3);

   assign o_rf_rd_en = running & !o_ctrl_trap &
                       (opcode != OP_STORE) &
                       !branch_op;

   assign o_rf_rs_en = cnt_en;

   assign o_alu_en = cnt_en;

   assign o_ctrl_lui = opcode == OP_LUI;

   assign o_ctrl_en = cnt_en;

   assign o_alu_init = (state == INIT);

   assign o_alu_sub = (opcode == OP_OP) ? imm30 /*    ? 1'b1*/ :
                      (branch_op & (o_funct3 == 3'b100)) ? 1'b1 :
                      (branch_op & (o_funct3 == 3'b101)) ? 1'b1 :
                      (branch_op & (o_funct3 == 3'b110)) ? 1'b1 :
                      1'b0;


   assign o_alu_cmp_neg = branch_op & o_funct3[0];

   assign o_csr_en = ((((opcode == OP_SYSTEM) & (|o_funct3)) |
		     o_ctrl_mret) & running) | o_ctrl_trap;

   always @(o_funct3, imm) begin
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
      if (((o_rf_rs1_addr == 5'd0) & o_funct3[1]) | o_ctrl_trap | o_ctrl_mret)
	o_csr_source = CSR_SOURCE_CSR;

      casez(imm[31:20])
	12'h305 : o_csr_sel = CSR_SEL_MTVEC;
	12'h340 : o_csr_sel = CSR_SEL_MSCRATCH;
	12'h341 : o_csr_sel = CSR_SEL_MEPC;
	12'h342 : o_csr_sel = CSR_SEL_MCAUSE;
	12'h343 : o_csr_sel = CSR_SEL_MTVAL;
	//12'hf14 : o_csr_sel = CSR_SEL_MHARTID;
	default : begin
	   o_csr_sel = 3'bxxx;
	   /*if (o_csr_en) begin
	      $display("%0t: CSR %03h not implemented", $time, imm[31:20]);
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

   wire jal_misalign  = imm[21] & (opcode == OP_JAL);

   reg [4:0] opcode;
   reg [31:0] imm;
   reg 	      signbit;

   reg [8:0]  imm19_12_20;
   reg 	      imm7;
   reg [5:0]  imm30_25;
   reg [4:0]  imm24_20;
   reg [4:0]  imm11_7;

   always @(posedge clk) begin
      if (i_wb_en) begin
         o_rf_rd_addr  <= i_wb_rdt[11:7];
         o_rf_rs1_addr <= i_wb_rdt[19:15];
         o_rf_rs2_addr <= i_wb_rdt[24:20];
         o_funct3      <= i_wb_rdt[14:12];
         imm30         <= i_wb_rdt[30];
         opcode        <= i_wb_rdt[6:2];
         imm           <= i_wb_rdt;
	 signbit       <= i_wb_rdt[31];
      end
      if (cnt_done | go | i_mem_dbus_ack) begin
	 imm19_12_20 <= {imm[19:12],imm[20]};
	 imm7 <= imm[7];
	 imm30_25 <= imm[30:25];
	 imm24_20 <= imm[24:20];
	 imm11_7  <= imm[11:7];

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

   wire gate1  = (cnt == 0) & ((opcode == OP_BRANCH) | (opcode == OP_JAL));
   wire gate12 = (cnt < 12) & utype;

   assign o_imm = (!(gate1 | gate12) & (cnt_done ? signbit : m1 ? imm11_7[0] : imm24_20[0]));

   assign o_op_b_source = (opcode == OP_OPIMM)  ? OP_B_SOURCE_IMM :
                          (opcode == OP_BRANCH) ? OP_B_SOURCE_RS2 :
                          (opcode == OP_OP)     ? OP_B_SOURCE_RS2 :
                          1'bx;

   always @(o_funct3, cnt) begin
      o_mem_dat_valid = 1'b0;
      casez(o_funct3[1:0])
        2'b00 : o_mem_dat_valid = (cnt < 8);
        2'b01 : o_mem_dat_valid = (cnt < 16);
        2'b10 : o_mem_dat_valid = 1'b1;
        default: o_mem_dat_valid = 1'b0;
      endcase
   end



   assign o_rd_source = (opcode == OP_JAL)   ? RD_SOURCE_CTRL :
                        (opcode == OP_OPIMM) ? RD_SOURCE_ALU  :
                        (opcode == OP_OP)    ? RD_SOURCE_ALU  :
                        (opcode == OP_LUI)   ? RD_SOURCE_CTRL :
                        (opcode == OP_AUIPC) ? RD_SOURCE_CTRL :
                        (opcode == OP_JALR)  ? RD_SOURCE_CTRL :
                        (opcode == OP_SYSTEM) ? RD_SOURCE_CSR :
                        RD_SOURCE_MEM;

   always @(posedge clk) begin
      go <= i_wb_en;
      if (i_rst)
	go <= 1'b0;
   end

   wire cnt_en = (state != IDLE);

   wire cnt_done = cnt == 31;
   assign running = (state == RUN);

   assign o_ctrl_trap = (state == TRAP);

   always @(i_mem_misalign, o_mem_cmd, e_op, imm) begin
      o_csr_mcause[3:0] = 4'd0;
      if (i_mem_misalign & !o_mem_cmd)
	o_csr_mcause[3:0] = 4'd4;
      if (i_mem_misalign & o_mem_cmd)
	o_csr_mcause[3:0] = 4'd6;
      if (e_op & !imm[20])
	o_csr_mcause[3:0] = 4'd11;
      if (e_op & imm[20])
	o_csr_mcause[3:0] = 4'd3;
   end

   always @(posedge clk) begin
      state <= state;
      case (state)
        IDLE : begin
           if (go) begin
	      state <= RUN;
              if (branch_op |
                  slt_op | (opcode == OP_JAL) | (opcode == OP_JALR) |
                  mem_op | shift_op)
		state <= INIT;
	      if (e_op)
		state <= TRAP;
	   end
	   if (i_mem_dbus_ack)
	     state <= RUN;
        end
        INIT : begin
           if (cnt_done)
             state <= (i_mem_misalign | (o_ctrl_jump & i_ctrl_misalign)) ? TRAP :
		      mem_op ? IDLE : RUN;
        end
        RUN : begin
           if (cnt_done)
             state <= IDLE;
        end
	TRAP : begin
           if (cnt_done)
             state <= IDLE;
	end
        default : state <= IDLE;
      endcase

      cnt <= cnt + {4'd0,cnt_en};

      if (i_rst) begin
	 state <= IDLE;
	 cnt   <= 5'd0;
      end
   end
endmodule
