/*
 * serv_alu.v : SERV Arithmetic Logic Unit
 *
 * SPDX-FileCopyrightText: 2018 Olof Kindgren <olof@award-winning.me>
 * SPDX-License-Identifier: ISC
 */
`default_nettype none
module serv_alu
  #(
   parameter W = 1,
   parameter B = W-1
  )
  (
   input wire 	    clk,
   //State
   input wire 	    i_en,
   input wire 	    i_cnt0,
   output wire 	    o_cmp,
   //Control
   input wire 	    i_sub,
   input wire [1:0] i_bool_op,
   input wire 	    i_cmp_eq,
   input wire 	    i_cmp_sig,
   input wire [2:0] i_rd_sel,
   //Data
   input wire  [B:0] i_rs1,
   input wire  [B:0] i_op_b,
   input wire  [B:0] i_buf,
   output wire [B:0] o_rd);

   wire [B:0]  result_add;
   wire [B:0]  result_slt;

   reg 	       cmp_r;

   wire        add_cy;
   reg [B:0]   add_cy_r;

   //Sign-extended operands
   wire rs1_sx  = i_rs1[B] & i_cmp_sig;
   wire op_b_sx = i_op_b[B]  & i_cmp_sig;

   wire [B:0] add_b = i_op_b^{W{i_sub}};

   assign {add_cy,result_add}   = i_rs1+add_b+add_cy_r;

   wire result_lt = rs1_sx + ~op_b_sx + add_cy;

   wire result_eq = !(|result_add) & (cmp_r | i_cnt0);

   assign o_cmp = i_cmp_eq ? result_eq : result_lt;

   /*
    The result_bool expression implements the following operations between
    i_rs1 and i_op_b depending on the value of i_bool_op

    00 xor
    01 0
    10 or
    11 and

    i_bool_op will be 01 during shift operations, so by outputting zero under
    this condition we can safely or result_bool with i_buf
    */
   wire [B:0] result_bool = ((i_rs1 ^ i_op_b) & ~{W{i_bool_op[0]}}) | ({W{i_bool_op[1]}} & i_op_b & i_rs1);

   assign result_slt[0] = cmp_r & i_cnt0;
   generate
      if (W>1) begin : gen_w_gt_1
	 assign result_slt[B:1] = {B{1'b0}};
      end
   endgenerate

   assign o_rd = i_buf |
                 ({W{i_rd_sel[0]}} & result_add) |
                 ({W{i_rd_sel[1]}} & result_slt) |
                 ({W{i_rd_sel[2]}} & result_bool);

   always @(posedge clk) begin
      add_cy_r    <= {W{1'b0}};
      add_cy_r[0] <= i_en ? add_cy : i_sub;

      if (i_en)
	cmp_r <= o_cmp;
   end

endmodule
