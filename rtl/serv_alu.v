`default_nettype none
module serv_alu
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
   input wire 	    i_rs1,
   input wire 	    i_op_b,
   input wire 	    i_buf,
   output wire 	    o_rd);

   wire        result_add;

   reg 	       cmp_r;

   wire        add_cy;
   reg 	       add_cy_r;

   //Sign-extended operands
   wire rs1_sx  = i_rs1 & i_cmp_sig;
   wire op_b_sx = i_op_b  & i_cmp_sig;

   wire add_b = i_op_b^i_sub;

   assign {add_cy,result_add}   = i_rs1+add_b+add_cy_r;

   wire result_lt = rs1_sx + ~op_b_sx + add_cy;

   wire result_eq = !result_add & (cmp_r | i_cnt0);

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
   wire result_bool = ((i_rs1 ^ i_op_b) & ~ i_bool_op[0]) | (i_bool_op[1] & i_op_b & i_rs1);

   assign o_rd = i_buf |
                 (i_rd_sel[0] & result_add) |
                 (i_rd_sel[1] & cmp_r & i_cnt0) |
                 (i_rd_sel[2] & result_bool);

   always @(posedge clk) begin
      add_cy_r <= i_en ? add_cy : i_sub;

      if (i_en)
	cmp_r <= o_cmp;
   end

endmodule
