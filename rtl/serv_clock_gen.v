`default_nettype none
module serv_clock_gen
  (
   input  i_clk,
   output o_clk,
   output o_rst);

   parameter PLL = "NONE";

   generate
      if (PLL == "ICE40_CORE") begin
	 wire locked;
	 SB_PLL40_CORE
	   #(`include "pll.vh")
	 pll
	   (
	    .LOCK(locked),
	    .RESETB(1'b1),
	    .BYPASS(1'b0),
	    .REFERENCECLK(i_clk),
	    .PLLOUTCORE(o_clk));
	 reg [1:0] rst_reg;
	 always @(posedge o_clk)
	   rst_reg <= {!locked, rst_reg[1]};
	 assign o_rst = rst_reg[0];
      end else if (PLL == "ICE40_PAD") begin
	 wire locked;
	 SB_PLL40_PAD
	   #(`include "pll.vh")
	 pll
	   (
	    .LOCK(locked),
	    .RESETB(1'b1),
	    .BYPASS(1'b0),
	    .PACKAGEPIN (i_clk),
	    .PLLOUTCORE(o_clk));
	 reg [1:0] rst_reg;
	 always @(posedge o_clk)
	   rst_reg <= {!locked, rst_reg[1]};
	 assign o_rst = rst_reg[0];
      end else begin
	 assign o_clk = i_clk;

	 reg [4:0] rst_reg = 5'b11111;

	 always @(posedge o_clk)
	   rst_reg <= {1'b0, rst_reg[4:1]};
	 assign o_rst = rst_reg[0];
      end
   endgenerate
endmodule
