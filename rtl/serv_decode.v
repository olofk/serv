`default_nettype none
module serv_decode
  (
   input wire        clk,
   //Input
   input wire [31:2] i_wb_rdt,
   input wire        i_wb_en,
   //To state
   output wire       o_sh_right,
   output wire       o_bne_or_bge,
   output wire       o_cond_branch,
   output wire       o_e_op,
   output wire       o_ebreak,
   output wire       o_branch_op,
   output wire       o_mem_op,
   output wire       o_shift_op,
   output wire       o_slt_op,
   output wire       o_rd_op,
   //To bufreg
   output wire       o_bufreg_rs1_en,
   output wire       o_bufreg_imm_en,
   output wire       o_bufreg_clr_lsb,
   output wire       o_bufreg_sh_signed,
   //To ctrl
   output wire       o_ctrl_jal_or_jalr,
   output wire       o_ctrl_utype,
   output wire       o_ctrl_pc_rel,
   output wire       o_ctrl_mret,
   //To alu
   output wire       o_alu_sub,
   output wire [1:0] o_alu_bool_op,
   output wire       o_alu_cmp_eq,
   output wire       o_alu_cmp_sig,
   output wire [2:0] o_alu_rd_sel,
   //To mem IF
   output wire       o_mem_signed,
   output wire       o_mem_word,
   output wire       o_mem_half,
   output wire       o_mem_cmd,
   //To CSR
   output wire       o_csr_en,
   output wire [1:0] o_csr_addr,
   output wire       o_csr_mstatus_en,
   output wire       o_csr_mie_en,
   output wire       o_csr_mcause_en,
   output wire [1:0] o_csr_source,
   output wire       o_csr_d_sel,
   output wire       o_csr_imm_en,
   //To top
   output wire [3:0] o_immdec_ctrl,
   output wire [3:0] o_immdec_en,
   output wire       o_op_b_source,
   output wire       o_rd_csr_en,
   output wire       o_rd_alu_en);

   reg [4:0] opcode;
   reg [2:0] funct3;
   reg        op20;
   reg        op21;
   reg        op22;
   reg        op26;

   reg       imm30;

   //opcode
   wire      op_or_opimm = (!opcode[4] & opcode[2] & !opcode[0]);

   assign o_mem_op   = !opcode[4] & !opcode[2] & !opcode[0];
   assign o_branch_op = opcode[4] & !opcode[2];

   //jal,branch =     imm
   //jalr       = rs1+imm
   //mem        = rs1+imm
   //shift      = rs1
   assign o_bufreg_rs1_en = !opcode[4] | (!opcode[1] & opcode[0]);
   assign o_bufreg_imm_en = !opcode[2];

   //Clear LSB of immediate for BRANCH and JAL ops
   //True for BRANCH and JAL
   //False for JALR/LOAD/STORE/OP/OPIMM?
   assign o_bufreg_clr_lsb = opcode[4] & ((opcode[1:0] == 2'b00) | (opcode[1:0] == 2'b11));

   //Conditional branch
   //True for BRANCH
   //False for JAL/JALR
   assign o_cond_branch = !opcode[0];

   assign o_ctrl_utype       = !opcode[4] & opcode[2] & opcode[0];
   assign o_ctrl_jal_or_jalr = opcode[4] & opcode[0];

   //PC-relative operations
   //True for jal, b* auipc
   //False for jalr, lui
   assign o_ctrl_pc_rel = (opcode[2:0] == 3'b000) |
                          (opcode[1:0] == 2'b11) |
                          (opcode[4:3] == 2'b00);
   //Write to RD
   //True for OP-IMM, AUIPC, OP, LUI, SYSTEM, JALR, JAL, LOAD
   //False for STORE, BRANCH, MISC-MEM
   assign o_rd_op = (opcode[2] |
                     (!opcode[2] & opcode[4] & opcode[0]) |
                     (!opcode[2] & !opcode[3] & !opcode[0]));

   //
   //funct3
   //

   assign o_sh_right   = funct3[2];
   assign o_bne_or_bge = funct3[0];

   //
   // opcode & funct3
   //

   assign o_shift_op = op_or_opimm & (funct3[1:0] == 2'b01);
   assign o_slt_op   = op_or_opimm & (funct3[2:1] == 2'b01);

   //Matches system ops except eceall/ebreak/mret
   wire csr_op = opcode[4] & opcode[2] & (|funct3);


   //op20
   assign o_ebreak = op20;


   //opcode & funct3 & op21

   assign o_ctrl_mret = opcode[4] & opcode[2] & op21 & !(|funct3);
   //Matches system opcodes except CSR accesses (funct3 == 0)
   //and mret (!op21)
   assign o_e_op = opcode[4] & opcode[2] & !op21 & !(|funct3);

   //opcode & funct3 & imm30

   assign o_bufreg_sh_signed = imm30;

   /*
    True for sub, b*, slt*
    False for add*
    op    opcode f3  i30
    b*    11000  xxx x   t
    addi  00100  000 x   f
    slt*  0x100  01x x   t
    add   01100  000 0   f
    sub   01100  000 1   t
    */
   assign o_alu_sub = funct3[1] | funct3[0] | (opcode[3] & imm30) | opcode[4];

   /*
    Bits 26, 22, 21 and 20 are enough to uniquely identify the eight supported CSR regs
    mtvec, mscratch, mepc and mtval are stored externally (normally in the RF) and are
    treated differently from mstatus, mie and mcause which are stored in serv_csr.

    The former get a 2-bit address as seen below while the latter get a
    one-hot enable signal each.

    Hex|2 222|Reg     |csr
    adr|6 210|name    |addr
    ---|-----|--------|----
    300|0_000|mstatus | xx
    304|0_100|mie     | xx
    305|0_101|mtvec   | 01
    340|1_000|mscratch| 00
    341|1_001|mepc    | 10
    342|1_010|mcause  | xx
    343|1_011|mtval   | 11

    */

   //true  for mtvec,mscratch,mepc and mtval
   //false for mstatus, mie, mcause
   wire csr_valid = op20 | (op26 & !op21);

   assign o_rd_csr_en = csr_op;

   assign o_csr_en         = csr_op & csr_valid;
   assign o_csr_mstatus_en = csr_op & !op26 & !op22;
   assign o_csr_mie_en     = csr_op & !op26 &  op22 & !op20;
   assign o_csr_mcause_en  = csr_op         &  op21 & !op20;

   assign o_csr_source = funct3[1:0];
   assign o_csr_d_sel = funct3[2];
   assign o_csr_imm_en = opcode[4] & opcode[2] & funct3[2];
   assign o_csr_addr = {op26 & op20, !op26 | op21};

   assign o_alu_cmp_eq = funct3[2:1] == 2'b00;

   assign o_alu_cmp_sig = ~((funct3[0] & funct3[1]) | (funct3[1] & funct3[2]));

   assign o_mem_cmd  = opcode[3];
   assign o_mem_signed = ~funct3[2];
   assign o_mem_word   = funct3[1];
   assign o_mem_half   = funct3[0];

   assign o_alu_bool_op = funct3[1:0];

   //True for S (STORE) or B (BRANCH) type instructions
   //False for J type instructions
   assign o_immdec_ctrl[0] = opcode[3:0] == 4'b1000;
   //True for OP-IMM, LOAD, STORE, JALR  (I S)
   //False for LUI, AUIPC, JAL           (U J)
   assign o_immdec_ctrl[1] = (opcode[1:0] == 2'b00) | (opcode[2:1] == 2'b00);
   assign o_immdec_ctrl[2] = opcode[4] & !opcode[0];
   assign o_immdec_ctrl[3] = opcode[4];

   assign o_immdec_en[3] = opcode[4] | opcode[3] | opcode[2] | !opcode[0];                 //B I J S U
   assign o_immdec_en[2] = (opcode[4] & opcode[2]) | !opcode[3] | opcode[0];               //  I J   U
   assign o_immdec_en[1] = (opcode[2:1] == 2'b01) | (opcode[2] & opcode[0]) | o_csr_imm_en;//    J   U
   assign o_immdec_en[0] = ~o_rd_op;                                                       //B     S

   assign o_alu_rd_sel[0] = (funct3 == 3'b000); // Add/sub
   assign o_alu_rd_sel[1] = (funct3[2:1] == 2'b01); //SLT*
   assign o_alu_rd_sel[2] = funct3[2]; //Bool
   always @(posedge clk) begin
      if (i_wb_en) begin
         funct3        <= i_wb_rdt[14:12];
         imm30         <= i_wb_rdt[30];
         opcode        <= i_wb_rdt[6:2];
         op20 <= i_wb_rdt[20];
         op21 <= i_wb_rdt[21];
         op22 <= i_wb_rdt[22];
         op26 <= i_wb_rdt[26];
      end
   end

   //0 (OP_B_SOURCE_IMM) when OPIMM
   //1 (OP_B_SOURCE_RS2) when BRANCH or OP
   assign o_op_b_source = opcode[3];

   assign o_rd_alu_en  = !opcode[0] & opcode[2] & !opcode[4];


endmodule
