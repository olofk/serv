module serv_auto_decode
  #(parameter [0:0] MDU = 1'b0)
  (
   input wire i_clk,
   //Input
   input wire i_en,
   input wire i_imm30,
   input wire [2:0] i_funct3,
   input wire [4:0] i_opcode,
   //MDU/Ext/CSR
   input wire i_imm25,
   output reg [2:0] o_ext_funct3,
   output reg o_mdu_op,
   input wire i_op20,
   input wire i_op21,
   input wire i_op22,
   input wire i_op26,
   output reg o_e_op,
   output reg o_ebreak,
   output reg o_ctrl_mret,
   output reg o_csr_en,
   output reg o_csr_addr1,
   output reg o_csr_addr0,
   output reg o_csr_mstatus_en,
   output reg o_csr_mie_en,
   output reg o_csr_mcause_en,
   output reg o_csr_source1,
   output reg o_csr_source0,
   output reg o_csr_d_sel,
   output reg o_csr_imm_en,
   output reg o_rd_csr_en,
   //Output
   output wire o_branch_op,
   output wire o_ctrl_jal_or_jalr,
   output wire o_slt_or_branch,
   output wire o_alu_rd_sel1,
   output wire o_op_b_source,
   output wire o_immdec_ctrl3,
   output wire o_immdec_ctrl0,
   output wire o_immdec_en0,
   output wire o_immdec_ctrl1,
   output wire o_bufreg_rs1_en,
   output wire o_immdec_ctrl2,
   output wire o_cond_branch,
   output wire o_immdec_en1,
   output wire o_immdec_en2,
   output wire o_immdec_en3,
   output wire o_bne_or_bge,
   output wire o_rd_alu_en,
   output wire o_sh_right,
   output wire o_alu_cmp_sig,
   output wire o_mem_signed,
   output wire o_shift_op,
   output wire o_alu_bool_op0,
   output wire o_two_stage_op,
   output wire o_rd_mem_en,
   output wire o_dbus_en,
   output wire o_bufreg_imm_en,
   output wire o_alu_rd_sel0,
   output wire o_bufreg_clr_lsb,
   output wire o_ctrl_pc_rel,
   output wire o_alu_sub,
   output wire o_alu_bool_op1,
   output wire o_bufreg_sh_signed,
   output wire o_alu_cmp_eq,
   output wire o_mem_word,
   output wire o_ctrl_utype,
   output wire o_mem_cmd,
   output wire o_rd_op,
   output wire o_alu_rd_sel2,
   output wire o_mem_half);

   reg imm30;
   reg [2:0] funct3;
   reg [4:0] opcode;

always @(posedge i_clk)
   if (i_en) begin
      imm30 <= i_imm30;
      funct3 <= i_funct3;
      opcode <= i_opcode;
   end
   assign o_branch_op = opcode[4];
   assign o_ctrl_jal_or_jalr = o_branch_op;   assign o_slt_or_branch = opcode[4] | (funct3[1] & opcode[2] & ~funct3[2]);
   assign o_alu_rd_sel1 = o_slt_or_branch;   assign o_op_b_source = opcode[4] | (opcode[3] & ~opcode[0]);
   assign o_immdec_ctrl3 = o_op_b_source;   assign o_immdec_ctrl0 = opcode[3] & ~opcode[0] & ~opcode[2];
   assign o_immdec_en0 = o_immdec_ctrl0;   assign o_immdec_ctrl1 = (~opcode[0] & ~opcode[4]) | (opcode[0] & ~opcode[1] & ~opcode[2]);
   assign o_bufreg_rs1_en = o_immdec_ctrl1;   assign o_immdec_ctrl2 = opcode[4] & ~opcode[0];
   assign o_cond_branch = o_immdec_ctrl2;   assign o_immdec_en1 = opcode[1] | (opcode[0] & ~opcode[4]);
   assign o_immdec_en2 = opcode[0] | ~opcode[3];
   assign o_immdec_en3 = opcode[1] | ~opcode[3] | (opcode[0] & ~opcode[4]) | (~opcode[0] & ~opcode[2]);
   assign o_bne_or_bge = (opcode[2] & ~opcode[0]) | (funct3[0] & opcode[3] & ~opcode[0]);
   assign o_rd_alu_en = o_bne_or_bge;   assign o_sh_right = (funct3[2] & opcode[2]) | (opcode[4] & ~funct3[1]) | (~funct3[0] & ~funct3[2]) | (~funct3[2] & ~opcode[2]);
   assign o_alu_cmp_sig = o_sh_right;   assign o_mem_signed = o_sh_right;   assign o_shift_op = (funct3[0] & funct3[2] & opcode[2]) | (funct3[0] & opcode[2] & ~funct3[1]);
   assign o_alu_bool_op0 = o_shift_op;   assign o_two_stage_op = ~opcode[2] | (funct3[0] & ~funct3[1] & ~opcode[0]) | (funct3[1] & ~funct3[2] & ~opcode[0]);
   assign o_rd_mem_en = ~opcode[2] & ~opcode[4];
   assign o_dbus_en = o_rd_mem_en;   assign o_bufreg_imm_en = ~opcode[2] | (~funct3[0] & ~funct3[1] & ~funct3[2]);
   assign o_alu_rd_sel0 = o_bufreg_imm_en;   assign o_bufreg_clr_lsb = opcode[1] | (opcode[0] & ~opcode[3]) | (opcode[4] & ~opcode[0]) | (funct3[1] & opcode[2] & ~opcode[0]) | (imm30 & opcode[2] & opcode[3] & ~funct3[2] & ~opcode[0]);
   assign o_ctrl_pc_rel = o_bufreg_clr_lsb;   assign o_alu_sub = o_bufreg_clr_lsb;   assign o_alu_bool_op1 = o_bufreg_clr_lsb;   assign o_bufreg_sh_signed = (opcode[4] & ~funct3[2]) | (imm30 & opcode[2] & ~funct3[1]) | (funct3[1] & ~funct3[2] & ~opcode[2]);
   assign o_alu_cmp_eq = o_bufreg_sh_signed;   assign o_mem_word = o_bufreg_sh_signed;   assign o_ctrl_utype = (opcode[0] & ~opcode[4]) | (opcode[3] & ~opcode[2] & ~opcode[4]);
   assign o_mem_cmd = o_ctrl_utype;   assign o_rd_op = opcode[0] | opcode[2] | ~opcode[3];
   assign o_alu_rd_sel2 = (funct3[1] & funct3[2]) | (funct3[0] & ~opcode[2]) | (funct3[2] & opcode[2] & ~funct3[0]);
   assign o_mem_half = o_alu_rd_sel2;
   //MDU/CSR/Ext
   reg imm25;
   reg op20;
   reg op21;
   reg op22;
   reg op26;
   
always @(posedge i_clk)
   if (i_en) begin
      imm25 <= i_imm25;
      funct3 <= i_funct3;
      opcode <= i_opcode;
      op20 <= i_op20;
      op21 <= i_op21;
      op22 <= i_op22;
      op26 <= i_op26;
   end
   
   assign o_mdu_op = MDU & (opcode == 5'b01100) & imm25;
   assign o_ext_funct3 = funct3;
   assign o_ebreak = op20;
   assign o_ctrl_mret = opcode[4] & opcode[2] & !(|funct3) &  op21;
   assign o_e_op      = opcode[4] & opcode[2] & !(|funct3) & !op21;
/*   assign o_rd_csr_en = opcode[4] & opcode[2] &  (|funct3);
   assign o_csr_en         = op20 | (op26 & !op21);
   assign o_csr_mstatus_en = !op26 & !op22;
   assign o_csr_mie_en     = !op26 &  op22 & !op20;
   assign o_csr_mcause_en  =          op21 & !op20;
   assign o_csr_source1 = funct3[1];
   assign o_csr_source0 = funct3[0];
   assign o_csr_d_sel   = funct3[2];
   assign o_csr_imm_en  = opcode[4] & opcode[2] & funct3[2];
   assign o_csr_addr1   = op26 & op20;
   assign o_csr_addr0   = !op26 | op21;
*/
   assign o_rd_csr_en =  1'b0;
   assign o_csr_en         =  1'b0;
   assign o_csr_mstatus_en =  1'b0;
   assign o_csr_mie_en     =  1'b0;
   assign o_csr_mcause_en  =  1'b0;
   assign o_csr_source1 =  1'b0;
   assign o_csr_source0 =  1'b0;
   assign o_csr_d_sel   =  1'b0;
   assign o_csr_imm_en  =  1'b0;
   assign o_csr_addr1   =  1'b0;
   assign o_csr_addr0   = 1'b0;
   

endmodule
