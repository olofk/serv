`default_nettype none
module ice40_pll
  (
   input  i_clk,
   output o_clk,
   output o_rst);

   parameter PLL = "NONE";

   wire   locked;

   reg [1:0] rst_reg;
   always @(posedge o_clk)
     rst_reg <= {!locked, rst_reg[1]};
   assign o_rst = rst_reg[0];

   generate
      if (PLL == "ICE40_CORE") begin
         SB_PLL40_CORE
           #(`include "pll.vh")
         pll
           (
            .LOCK(locked),
            .RESETB(1'b1),
            .BYPASS(1'b0),
            .REFERENCECLK(i_clk),
            .PLLOUTCORE(o_clk));
      end else if (PLL == "ICE40_PAD") begin
         SB_PLL40_PAD
           #(`include "pll.vh")
         pll
           (
            .LOCK(locked),
            .RESETB(1'b1),
            .BYPASS(1'b0),
            .PACKAGEPIN (i_clk),
            .PLLOUTCORE(o_clk));
      end
   endgenerate
endmodule
