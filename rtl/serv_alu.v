`default_nettype none
module serv_alu
  (
   input       clk,
   input       i_en,
   input [2:0] i_op,
   input [2:0] i_funct3,
   input       i_rs1,
   input       i_op_b,
   input       i_init, 
   output      o_cmp,
   input       i_shamt_en,
   output      o_rd);

`include "serv_params.vh"

   localparam[2:0]
     BEQ = 3'b000,
     BNE = 3'b001;
   
   wire       result_add;
   wire       result_eq;
   wire       result_sh;
   
   wire [4:0] shamt;
   
   shift_reg #(.LEN (5)) shamt_reg
     (.clk (clk),
      .i_en (i_shamt_en),
      .i_d  (i_op_b),
      .o_q  (shamt[0]),
      .o_par (shamt[4:1]));

   ser_shift shift
     (
      .i_clk (clk),
      .i_load (i_init),
      .i_shamt (shamt),
      .i_sr (/*FIXME*/),
      .i_d (i_rs1),
      .o_q (result_sh));
     
   ser_add ser_add
     (
      .clk (clk),
      .a   (i_rs1),
      .b   (i_op_b),
      .clr (!i_en),
      .q   (result_add));

   ser_eq ser_eq
     (
      .clk (clk),
      .a   (i_rs1),
      .b   (i_op_b),
      .clr (!i_init),
      .o_q (result_eq));

   assign o_cmp = (i_funct3 == BEQ) ? result_eq :
                  (i_funct3 == BNE) ? ~result_eq : 1'bx;

   assign o_rd = (i_op == ALU_OP_ADD) ? result_add :
                 (i_op == ALU_OP_SR)  ? result_sh :
                 1'bx;
   
endmodule
   
