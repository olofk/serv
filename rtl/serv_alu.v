`default_nettype none
module serv_alu
  (
   input       clk,
   input       i_en,
   input [2:0] i_funct3,
   input       i_rs1,
   input       i_op_b,
   output      o_rd);

   localparam [2:0]
     ADDI  = 3'b000,
     SLTI  = 3'b010,
     SLTIU = 3'b011,
     XORI  = 3'b100,
     ORI   = 3'b110,
     ANDI  = 3'b111;

   wire       result_add;
   
   ser_add ser_add
     (
      .clk (clk),
      .a   (i_rs1),
      .b   (i_op_b),
      .clr (!i_en),
      .q   (result_add));

   assign o_rd = (i_funct3 == ADDI) ? result_add : 1'b0;
   
endmodule   
   
