`default_nettype none
module serv_alu
  (
   input wire 	    clk,
   //State
   input wire 	    i_init,
   input wire 	    i_en,
   input wire 	    i_cnt0,
   input wire 	    i_shamt_en,
   output wire 	    o_cmp,
   output wire 	    o_sh_done,
   output wire 	    o_sh_done_r,
   //Control
   input wire 	    i_op_b_rs2,
   input wire 	    i_sub,
   input wire [1:0] i_bool_op,
   input wire 	    i_cmp_eq,
   input wire 	    i_cmp_sig,
   input wire [3:0] i_rd_sel,
   //Data
   input wire 	    i_rs1,
   input wire 	    i_rs2,
   input wire 	    i_imm,
   input wire 	    i_buf,
   output wire 	    o_rd);

   wire        result_add;
   wire        result_eq;

   reg 	       result_lt_r;
   reg 	       eq_r;

   reg [5:0]   shamt_r;

   wire        add_cy;
   reg 	       add_cy_r;

   wire op_b = i_op_b_rs2 ? i_rs2 : i_imm;

   //Sign-extended operands
   wire rs1_sx  = i_rs1 & i_cmp_sig;
   wire op_b_sx = op_b  & i_cmp_sig;

   wire result_lt = rs1_sx + ~op_b_sx + add_cy;

   wire add_b = op_b^i_sub;

   assign {add_cy,result_add}   = i_rs1+add_b+add_cy_r;

   assign result_eq = !result_add & eq_r;

   assign o_cmp = i_cmp_eq ? result_eq : result_lt;

   localparam [15:0] BOOL_LUT = 16'h8E96;//And, Or, =, xor
   wire result_bool = BOOL_LUT[{i_bool_op, i_rs1, op_b}];

   assign o_rd = (i_rd_sel[0] & result_add) |
                 (i_rd_sel[1] & i_buf) |
                 (i_rd_sel[2] & result_lt_r & i_cnt0) |
                 (i_rd_sel[3] & result_bool);


   wire [5:0] shamt = i_init ? {1'b0,op_b,shamt_r[4:1]} : shamt_r-1;
   assign o_sh_done = shamt[5];
   assign o_sh_done_r = shamt_r[5];

   always @(posedge clk) begin
      add_cy_r <= i_en ? add_cy : i_sub;

      if (i_en) begin
	 result_lt_r <= result_lt;
      end
      eq_r <= result_eq | ~i_en;

      if (i_shamt_en)
	 shamt_r <= shamt;
   end

endmodule
