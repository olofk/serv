`default_nettype none
module serv_alu
  (
   input       clk,
   input       i_en,
   input       i_rs1,
   input       i_op_b,
   input       i_init,
   input       i_sub,
   input       i_cmp_sel,
   input       i_cmp_neg, 
   output      o_cmp,
   input       i_shamt_en,
   input [1:0] i_rd_sel,
   output      o_rd);

`include "serv_params.vh"

   wire        result_add;
   wire        result_eq;
   reg         result_lt = 1'b0;
   wire        result_sh;
   
   wire [4:0]  shamt;
   
   reg         en_r;
   wire        v;
   
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

   wire       plus_1 = i_en & !en_r;
   wire       b_inv_plus_1;

   ser_add ser_add_inv_plus_1
     (
      .clk (clk),
      .a   (~i_op_b),
      .b   (plus_1),
      .clr (!i_en),
      .q   (b_inv_plus_1),
      .o_v ());

   wire       add_b = i_sub ? b_inv_plus_1 : i_op_b;
   
   ser_add ser_add
     (
      .clk (clk),
      .a   (i_rs1),
      .b   (add_b),
      .clr (!i_en),
      .q   (result_add),
      .o_v (v));

   ser_eq ser_eq
     (
      .clk (clk),
      .a   (i_rs1),
      .b   (i_op_b),
      .clr (!i_init),
      .o_q (result_eq));

   assign o_cmp = i_cmp_neg^(i_cmp_sel ? result_eq : result_lt);

   assign o_rd = (i_rd_sel == ALU_RESULT_ADD) ? result_add :
                 (i_rd_sel == ALU_RESULT_SR)  ? result_sh :
                 1'bx;

   always @(posedge clk) begin
      if (i_init)
        result_lt <= /*v^*/result_add;

      en_r <= i_en;
   end
endmodule
   
