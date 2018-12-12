`default_nettype none
module serv_alu
  (
   input wire 	    clk,
   input wire 	    i_rst,
   input wire 	    i_en,
   input wire 	    i_rs1,
   input wire 	    i_op_b,
   input wire 	    i_init,
   input wire 	    i_cnt_done,
   input wire 	    i_sub,
   input wire [1:0] i_bool_op,
   input wire 	    i_cmp_sel,
   input wire 	    i_cmp_neg,
   input wire 	    i_cmp_uns,
   output wire 	    o_cmp,
   input wire 	    i_shamt_en,
   input wire 	    i_sh_right,
   input wire 	    i_sh_signed,
   input wire [1:0] i_rd_sel,
   output wire 	    o_rd);

`include "serv_params.vh"

   wire        result_add;
   wire        result_eq;
   wire        result_lt;
   wire        result_sh;

   reg 	       result_lt_r;

   wire [4:0]  shamt;

   reg         en_r;
   wire        v;
   reg         init_r;
   wire        shamt_l;
   wire        shamt_ser;
   wire        plus_1;

   ser_add ser_add_inv_shamt_plus1
     (
      .clk (clk),
      .rst (i_rst),
      .a   (~i_op_b),
      .b   (plus_1),
      .clr (!i_en),
      .q   (shamt_l),
      .o_v ());

   assign shamt_ser = i_sh_right ? i_op_b : shamt_l;

   shift_reg #(.LEN (5)) shamt_reg
     (.clk (clk),
      .i_rst (i_rst),
      .i_en (i_shamt_en),
      .i_d  (shamt_ser),
      .o_q  (shamt[0]),
      .o_par (shamt[4:1]));

   ser_shift shift
     (
      .i_clk (clk),
      .i_rst (i_rst),
      .i_load (i_init),
      .i_shamt (shamt),
      .i_signed (i_sh_signed),
      .i_right  (i_sh_right),
      .i_d (i_rs1),
      .o_q (result_sh));

   wire       b_inv_plus_1;

   ser_add ser_add_inv_plus_1
     (
      .clk (clk),
      .rst (i_rst),
      .a   (~i_op_b),
      .b   (plus_1),
      .clr (!i_en),
      .q   (b_inv_plus_1),
      .o_v ());

   wire       add_b = i_sub ? b_inv_plus_1 : i_op_b;

   ser_add ser_add
     (
      .clk (clk),
      .rst (i_rst),
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

   ser_lt ser_lt
     (
      .i_clk (clk),
      .i_a   (i_rs1),
      .i_b   (i_op_b),
      .i_clr (!i_init),
      .i_sign (i_cnt_done & !i_cmp_uns),
      .o_q   (result_lt));

   reg last_eq;

   assign plus_1 = i_en & !en_r;
   assign o_cmp = i_cmp_neg^((i_cmp_sel == ALU_CMP_EQ) ? (result_eq & (i_rs1 == i_op_b)) : result_lt);

   localparam [15:0] BOOL_LUT = 16'h8E96;//And, Or, =, xor
   wire result_bool = BOOL_LUT[{i_bool_op, i_rs1, i_op_b}];

   assign o_rd = (i_rd_sel == ALU_RESULT_ADD) ? result_add :
                 (i_rd_sel == ALU_RESULT_SR)  ? result_sh :
                 (i_rd_sel == ALU_RESULT_LT)  ? (result_lt_r & init_r & ~i_init) :
                 (i_rd_sel == ALU_RESULT_BOOL) ? result_bool : 1'bx;


   always @(posedge clk) begin
      if (i_init) begin
         last_eq <= i_rs1 == i_op_b;
	 result_lt_r <= result_lt;
      end

      en_r <= i_en;
      init_r <= i_init;

   end
endmodule
