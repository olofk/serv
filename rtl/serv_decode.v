`default_nettype none
module serv_decode
  #(parameter [0:0] PRE_REGISTER = 1,
    parameter [0:0] MDU = 0)
  (
   input wire 	     clk,
   //Input
   input wire [31:2] i_wb_rdt,
   input wire 	     i_wb_en,
   //To state
   output reg 	     o_e_op,//xx
   output reg 	     o_ebreak,//xx
   //To ctrl
   output reg 	     o_ctrl_mret,//xx
   //To CSR
   output reg 	     o_csr_en,//xx
   output reg [1:0]  o_csr_addr,//xx
   output reg 	     o_csr_mstatus_en,//xx
   output reg 	     o_csr_mie_en,//xx
   output reg 	     o_csr_mcause_en,//xx
   output reg [1:0]  o_csr_source,//xx
   output reg 	     o_csr_d_sel,//xx
   output reg 	     o_csr_imm_en,//xx
   //To RF IF
   output reg 	     o_rd_csr_en);//xx

   reg [4:0] opcode;
   reg [2:0] funct3;
   reg        op20;
   reg        op21;
   reg        op22;
   reg        op26;

   reg       imm25;
   reg       imm30;

   //op20
   wire co_ebreak = op20;

   //csr_op matches system ops except eceall/ebreak/mret
   //e_op matches system opcodes except CSR accesses (funct3 == 0) and mret (!op21)
   wire co_rd_csr_en = opcode[4] & opcode[2] &  (|funct3);
   wire co_ctrl_mret = opcode[4] & opcode[2] & !(|funct3) &  op21;
   wire co_e_op      = opcode[4] & opcode[2] & !(|funct3) & !op21;

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
   wire co_csr_en         = op20 | (op26 & !op21);

   wire co_csr_mstatus_en = !op26 & !op22;
   wire co_csr_mie_en     = !op26 &  op22 & !op20;
   wire co_csr_mcause_en  =          op21 & !op20;

   wire [1:0] co_csr_source = funct3[1:0];
   wire co_csr_d_sel = funct3[2];
   wire co_csr_imm_en = opcode[4] & opcode[2] & funct3[2];
   wire [1:0] co_csr_addr = {op26 & op20, !op26 | op21};

   generate
      if (PRE_REGISTER) begin

         always @(posedge clk) begin
            if (i_wb_en) begin
               funct3 <= i_wb_rdt[14:12];
               imm30  <= i_wb_rdt[30];
               imm25  <= i_wb_rdt[25];
               opcode <= i_wb_rdt[6:2];
               op20   <= i_wb_rdt[20];
               op21   <= i_wb_rdt[21];
               op22   <= i_wb_rdt[22];
               op26   <= i_wb_rdt[26];
            end
         end

         always @(*) begin
            o_e_op             = co_e_op;
            o_ebreak           = co_ebreak;
            o_ctrl_mret        = co_ctrl_mret;
            o_csr_en           = co_csr_en;
            o_csr_addr         = co_csr_addr;
            o_csr_mstatus_en   = co_csr_mstatus_en;
            o_csr_mie_en       = co_csr_mie_en;
            o_csr_mcause_en    = co_csr_mcause_en;
            o_csr_source       = co_csr_source;
            o_csr_d_sel        = co_csr_d_sel;
            o_csr_imm_en       = co_csr_imm_en;
            o_rd_csr_en        = co_rd_csr_en;
         end

      end else begin

         always @(*) begin
            funct3  = i_wb_rdt[14:12];
            imm30   = i_wb_rdt[30];
            imm25   = i_wb_rdt[25];
            opcode  = i_wb_rdt[6:2];
            op20    = i_wb_rdt[20];
            op21    = i_wb_rdt[21];
            op22    = i_wb_rdt[22];
            op26    = i_wb_rdt[26];
         end

         always @(posedge clk) begin
            if (i_wb_en) begin
               o_e_op             <= co_e_op;
               o_ebreak           <= co_ebreak;
               o_ctrl_mret        <= co_ctrl_mret;
               o_csr_en           <= co_csr_en;
               o_csr_addr         <= co_csr_addr;
               o_csr_mstatus_en   <= co_csr_mstatus_en;
               o_csr_mie_en       <= co_csr_mie_en;
               o_csr_mcause_en    <= co_csr_mcause_en;
               o_csr_source       <= co_csr_source;
               o_csr_d_sel        <= co_csr_d_sel;
               o_csr_imm_en       <= co_csr_imm_en;
               o_rd_csr_en        <= co_rd_csr_en;
            end
         end

      end
   endgenerate

endmodule
