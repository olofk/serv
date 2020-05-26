`default_nettype none
module serv_alu
  (
   input wire 	    clk,
   input wire 	    i_rst,
   input wire 	    i_en,
   input wire 	    i_cnt0,
   input wire 	    i_rs1,
   input wire 	    i_rs2,
   input wire 	    i_imm,
   input wire 	    i_op_b_rs2,
   input wire 	    i_buf,
   input wire 	    i_init,
   input wire 	    i_cnt_done,
   input wire 	    i_sub,
   input wire [1:0] i_bool_op,
   input wire 	    i_cmp_eq,
   input wire 	    i_cmp_uns,
   output wire 	    o_cmp,
   input wire 	    i_shamt_en,
   input wire 	    i_sh_right,
   input wire 	    i_sh_signed,
   output wire 	    o_sh_done,
   input wire [3:0] i_rd_sel,
   output wire 	    o_rd);

   wire        result_add;
   wire        result_eq;
   wire        result_lt;
   wire        result_sh;

   reg 	       result_lt_r;

   reg [4:0]   shamt;
   reg 	       shamt_msb;

   wire        shamt_ser;
   wire        plus_1;

   wire        add_cy;
   reg 	       add_cy_r;

   wire        b_inv_plus_1;
   wire        b_inv_plus_1_cy;
   reg 	       b_inv_plus_1_cy_r;

   wire op_b = i_op_b_rs2 ? i_rs2 : i_imm;
   assign shamt_ser = i_sh_right ? op_b : b_inv_plus_1;

   serv_shift shift
     (
      .i_clk (clk),
      .i_load (i_init),
      .i_shamt (shamt),
      .i_shamt_msb (shamt_msb),
      .i_signbit (i_sh_signed & i_rs1),
      .i_right  (i_sh_right),
      .o_done   (o_sh_done),
      .i_d (i_buf),
      .o_q (result_sh));

   wire add_b = i_sub ? b_inv_plus_1 : op_b;
   assign {add_cy,result_add}   = i_rs1+add_b+add_cy_r;
   assign {b_inv_plus_1_cy,b_inv_plus_1} = {1'b0,~op_b}+plus_1+b_inv_plus_1_cy_r;

   reg        lt_r;

   reg        eq_r;

   wire       lt_sign = i_cnt_done & !i_cmp_uns;

   wire       eq = (i_rs1 == op_b);

   assign result_eq = eq & eq_r;
   assign result_lt = eq ? lt_r : op_b^lt_sign;

   assign plus_1 = i_cnt0;
   assign o_cmp = i_cmp_eq ? result_eq : result_lt;

   localparam [15:0] BOOL_LUT = 16'h8E96;//And, Or, =, xor
   wire result_bool = BOOL_LUT[{i_bool_op, i_rs1, op_b}];

   assign o_rd = (i_rd_sel[0] & result_add) |
                 (i_rd_sel[1] & result_sh) |
                 (i_rd_sel[2] & result_lt_r & plus_1) |
                 (i_rd_sel[3] & result_bool);


   always @(posedge clk) begin
      add_cy_r <= i_en & add_cy;
      b_inv_plus_1_cy_r <= i_en & b_inv_plus_1_cy;

      lt_r <= result_lt & i_en;

      if (i_en) begin
	 result_lt_r <= result_lt;
      end
      eq_r <= result_eq | ~i_en;

      if (i_shamt_en) begin
	 shamt_msb <= b_inv_plus_1_cy;
	 shamt <= {shamt_ser,shamt[4:1]};
      end
   end

endmodule
