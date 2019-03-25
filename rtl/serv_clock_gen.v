`default_nettype none
module serv_clock_gen
  (
   input wire  i_clk,
   output wire o_clk,
   output wire o_rst);

   parameter [79:0] PLL = "NONE";

   generate
      if ((PLL == "ICE40_CORE") || (PLL == "ICE40_PAD")) begin
	 ice40_pll #(.PLL (PLL)) pll
	   (.i_clk (i_clk),
	    .o_clk (o_clk),
	    .o_rst (o_rst));
      end else begin
	 assign o_clk = i_clk;

	 reg [4:0] rst_reg = 5'b11111;

	 always @(posedge o_clk)
	   rst_reg <= {1'b0, rst_reg[4:1]};
	 assign o_rst = rst_reg[0];
      end
   endgenerate
endmodule
