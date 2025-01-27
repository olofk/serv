`default_nettype none
module servant_nexys_a7_clock_gen
  (input wire  i_clk,
   input wire  i_rst,
   input wire  i_clk0_en,
   input wire  i_clk1_en,
   output wire o_clk0,
   output wire o_clk1,
   output reg  o_rst);

   wire   clkfb;
   wire   locked;
   wire   pll_rst;
   wire   pll_clk;
   reg 	  locked_r;

   assign pll_rst = !i_rst;

   MMCME2_BASE
     #(.CLKIN1_PERIOD   (10), //100MHz

       /* Set VCO frequency to 100*8.0=800 MHz
	Allowed values are 2.0 to 64.0. Resulting VCO freq
	needs to be 600-1200MHz */
       .CLKFBOUT_MULT_F (6.000),

       .CLKOUT0_DIVIDE_F (64.000)) // 800/25 = 32 MHz
   pll
     (.CLKIN1   (i_clk),
      .RST      (pll_rst),
      .CLKOUT0  (pll_clk),
      .LOCKED   (locked),
      .CLKFBOUT (clkfb),
      .CLKFBIN  (clkfb));

  always @(posedge pll_clk) begin
      locked_r <= locked;
      o_rst  <= !locked_r;
  end
  
  BUFGCE clk0_buf
  (
    .I (pll_clk),
    .O (o_clk0),
    .CE (i_clk0_en));

  BUFGCE clk1_buf
  (
    .I (pll_clk),
    .O (o_clk1),
    .CE (i_clk1_en));


   

endmodule
`default_nettype wire
