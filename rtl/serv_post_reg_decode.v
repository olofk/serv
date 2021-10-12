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
   output reg o_branch_op,
   output wire o_ctrl_jal_or_jalr,
   output reg o_slt_or_branch,
   output wire o_alu_rd_sel1,
   output reg o_op_b_source,
   output wire o_immdec_ctrl3,
   output reg o_immdec_ctrl0,
   output wire o_immdec_en0,
   output reg o_immdec_ctrl1,
   output wire o_bufreg_rs1_en,
   output reg o_immdec_ctrl2,
   output wire o_cond_branch,
   output reg o_immdec_en1,
   output reg o_immdec_en2,
   output reg o_immdec_en3,
   output reg o_bne_or_bge,
   output wire o_rd_alu_en,
   output reg o_sh_right,
   output wire o_alu_cmp_sig,
   output wire o_mem_signed,
   output reg o_shift_op,
   output wire o_alu_bool_op0,
   output reg o_two_stage_op,
   output reg o_rd_mem_en,
   output wire o_dbus_en,
   output reg o_bufreg_imm_en,
   output wire o_alu_rd_sel0,
   output reg o_bufreg_clr_lsb,
   output wire o_ctrl_pc_rel,
   output wire o_alu_sub,
   output wire o_alu_bool_op1,
   output reg o_bufreg_sh_signed,
   output wire o_alu_cmp_eq,
   output wire o_mem_word,
   output reg o_ctrl_utype,
   output wire o_mem_cmd,
   output reg o_rd_op,
   output reg o_alu_rd_sel2,
   output wire o_mem_half);

//                  lajjbbbbbblllllsssassxoasssassssxssoa
//                  uuaaenlglgbhwbhbhwdllornlrrdulllorrrn
//                  iillqetete   uu   dttridlladblttrla d
//                   p r    uu        iiii iiii    u     
//                   c                  u                
//branch_op        |0011111111000000000000000000000000000|
//slt_or_branch    |  11111111000000000110000000001100000|
//op_b_source      |0011111111000001110000000001111111111|
//immdec_ctrl0     |0000111111000001110000000000000000000|
//immdec_ctrl1     |000100000011111111111111111  1   11  |
//immdec_ctrl2     |000011111100000000000000000          |
//immdec_en1       |1110000000000000000000000000000000000|
//immdec_en2       |1111000000111110001111111110000000000|
//immdec_en3       |1110111111111111111111111110000000000|
//bne_or_bge       |000001010100000   1111111111111111111|
//sh_right         |      110011 00    10   011  010 11  |
//shift_op         |  0000000000000000 00001111  10001101|
//two_stage_op     |0011111111111111110110001110011101100|
//rd_mem_en        |0000000000111111110000000000000000000|
//bufreg_imm_en    |  11111111111111111000000001100000000|
//bufreg_clr_lsb   |0110111111000000000110110000101100011|
//bufreg_sh_signed |    11000000100001 00    01   00 01  |
//ctrl_utype       |1100000000000001110000000000000000000|
//rd_op            |1111000000111110001111111111111111111|
//alu_rd_sel2      |          010010100001110000000010011|
//20 signals
//
always @(posedge i_clk)
   if (i_en) begin
      o_branch_op <= i_opcode[4];
      o_slt_or_branch <= i_opcode[4] | (i_funct3[1] & i_opcode[2] & ~i_funct3[2]);
      o_op_b_source <= i_opcode[4] | (i_opcode[3] & ~i_opcode[0]);
      o_immdec_ctrl0 <= i_opcode[3] & ~i_opcode[0] & ~i_opcode[2];
      o_immdec_ctrl1 <= (~i_opcode[0] & ~i_opcode[4]) | (i_opcode[0] & ~i_opcode[1] & ~i_opcode[2]);
      o_immdec_ctrl2 <= i_opcode[4] & ~i_opcode[0];
      o_immdec_en1 <= i_opcode[1] | (i_opcode[0] & ~i_opcode[4]);
      o_immdec_en2 <= i_opcode[0] | ~i_opcode[3];
      o_immdec_en3 <= i_opcode[1] | ~i_opcode[3] | (i_opcode[0] & ~i_opcode[4]) | (~i_opcode[0] & ~i_opcode[2]);
      o_bne_or_bge <= (i_opcode[2] & ~i_opcode[0]) | (i_funct3[0] & i_opcode[3] & ~i_opcode[0]);
      o_sh_right <= (i_funct3[2] & i_opcode[2]) | (i_opcode[4] & ~i_funct3[1]) | (~i_funct3[0] & ~i_funct3[2]) | (~i_funct3[2] & ~i_opcode[2]);
      o_shift_op <= (i_funct3[0] & i_funct3[2] & i_opcode[2]) | (i_funct3[0] & i_opcode[2] & ~i_funct3[1]);
      o_two_stage_op <= ~i_opcode[2] | (i_funct3[0] & ~i_funct3[1] & ~i_opcode[0]) | (i_funct3[1] & ~i_funct3[2] & ~i_opcode[0]);
      o_rd_mem_en <= ~i_opcode[2] & ~i_opcode[4];
      o_bufreg_imm_en <= ~i_opcode[2] | (~i_funct3[0] & ~i_funct3[1] & ~i_funct3[2]);
      o_bufreg_clr_lsb <= i_opcode[1] | (i_opcode[0] & ~i_opcode[3]) | (i_opcode[4] & ~i_opcode[0]) | (i_funct3[1] & i_opcode[2] & ~i_opcode[0]) | (i_imm30 & i_opcode[2] & i_opcode[3] & ~i_funct3[2] & ~i_opcode[0]);
      o_bufreg_sh_signed <= (i_opcode[4] & ~i_funct3[2]) | (i_imm30 & i_opcode[2] & ~i_funct3[1]) | (i_funct3[1] & ~i_funct3[2] & ~i_opcode[2]);
      o_ctrl_utype <= (i_opcode[0] & ~i_opcode[4]) | (i_opcode[3] & ~i_opcode[2] & ~i_opcode[4]);
      o_rd_op <= i_opcode[0] | i_opcode[2] | ~i_opcode[3];
      o_alu_rd_sel2 <= (i_funct3[1] & i_funct3[2]) | (i_funct3[0] & ~i_opcode[2]) | (i_funct3[2] & i_opcode[2] & ~i_funct3[0]);
   //MDU/CSR/Ext
   o_mdu_op <= MDU & (i_opcode == 5'b01100) & i_imm25;
//   o_ext_funct3 <= i_funct3;
   o_ebreak <= i_op20;
   o_ctrl_mret <= i_opcode[4] & i_opcode[2] & !(|i_funct3) &  i_op21;
   o_e_op      <= i_opcode[4] & i_opcode[2] & !(|i_funct3) & !i_op21;
/*
   o_rd_csr_en <= i_opcode[4] & i_opcode[2] &  (|i_funct3);
   o_csr_en         <= i_op20 | (i_op26 & !i_op21);
   o_csr_mstatus_en <= !i_op26 & !i_op22;
   o_csr_mie_en     <= !i_op26 &  i_op22 & !i_op20;
   o_csr_mcause_en  <=          i_op21 & !i_op20;
   o_csr_source1 <= i_funct3[1];
   o_csr_source0 <= i_funct3[0];
   o_csr_d_sel   <= i_funct3[2];
   o_csr_imm_en  <= i_opcode[4] & i_opcode[2] & i_funct3[2];
   o_csr_addr1   <= i_op26 & i_op20;
   o_csr_addr0   <= !i_op26 | i_op21;
   */end
   always @(*) begin
      o_ext_funct3 <= 3'd0;
      o_rd_csr_en <= 1'b0;
   o_csr_en         <=  1'b0;
   o_csr_mstatus_en <=  1'b0;
   o_csr_mie_en     <=  1'b0;
   o_csr_mcause_en  <=  1'b0;
   o_csr_source1 <=  1'b0;
   o_csr_source0 <=  1'b0;
   o_csr_d_sel   <=  1'b0;
   o_csr_imm_en  <=  1'b0;
   o_csr_addr1   <=  1'b0;
   o_csr_addr0   <=  1'b0;
   end

   assign o_ctrl_jal_or_jalr = o_branch_op;
   assign o_alu_rd_sel1 = o_slt_or_branch;
   assign o_immdec_ctrl3 = o_op_b_source;
   assign o_immdec_en0 = o_immdec_ctrl0;
   assign o_bufreg_rs1_en = o_immdec_ctrl1;
   assign o_cond_branch = o_immdec_ctrl2;
   assign o_rd_alu_en = o_bne_or_bge;
   assign o_alu_cmp_sig = o_sh_right;
   assign o_mem_signed = o_sh_right;
   assign o_alu_bool_op0 = o_shift_op;
   assign o_dbus_en = o_rd_mem_en;
   assign o_alu_rd_sel0 = o_bufreg_imm_en;
   assign o_ctrl_pc_rel = o_bufreg_clr_lsb;
   assign o_alu_sub = o_bufreg_clr_lsb;
   assign o_alu_bool_op1 = o_bufreg_clr_lsb;
   assign o_alu_cmp_eq = o_bufreg_sh_signed;
   assign o_mem_word = o_bufreg_sh_signed;
   assign o_mem_cmd = o_ctrl_utype;
   assign o_mem_half = o_alu_rd_sel2;


endmodule
