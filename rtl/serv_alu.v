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
   input wire [3:0] i_rd_sel,
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

   localparam [15:0] BOOL_LUT = 16'h8E96;//And, Or, =, xor
   wire result_bool = BOOL_LUT[{i_bool_op, i_rs1, i_op_b}];

   assign o_rd = (i_rd_sel[0] & result_add) |
                 (i_rd_sel[1] & i_buf) |
                 (i_rd_sel[2] & cmp_r & i_cnt0) |
                 (i_rd_sel[3] & result_bool);

   always @(posedge clk) begin
      add_cy_r <= i_en ? add_cy : i_sub;

      if (i_en)
	cmp_r <= o_cmp;
   end

endmodule
