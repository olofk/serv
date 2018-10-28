`default_nettype none
module serv_alu
  (
   input       clk,
   input       i_en,
   input [2:0] i_funct3,
   input       i_rs1,
   input       i_op_b,
   input       i_cmp_en, 
   output      o_cmp, 
   output      o_rd);

   localparam [2:0]
     ADDI  = 3'b000,
     SLTI  = 3'b010,
     SLTIU = 3'b011,
     XORI  = 3'b100,
     ORI   = 3'b110,
     ANDI  = 3'b111;

   localparam[2:0]
     BEQ = 3'b000;
   
   wire       result_add;
   wire       result_eq;
   
   ser_add ser_add
     (
      .clk (clk),
      .a   (i_rs1),
      .b   (i_op_b),
      .clr (!i_en),
      .q   (result_add));

   reg        eq;

   ser_eq ser_eq
     (
      .clk (clk),
      .a   (i_rs1),
      .b   (i_op_b),
      .clr (!i_cmp_en),
      .q   (result_eq));
     
   assign o_cmp = (i_funct3 == BEQ) ? result_eq : 1'bx;

   assign o_rd = (i_funct3 == ADDI) ? result_add : 1'b0;
   
endmodule
   
