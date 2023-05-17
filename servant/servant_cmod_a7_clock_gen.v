`default_nettype none
module servant_cmod_a7_clock_gen
  (input wire  i_clk,
   input wire  i_rst,
   output wire o_clk,
   output reg  o_rst);

   wire   clkfb;
   wire   locked;
   reg 	  locked_r;

   MMCME2_BASE
     #(.CLKIN1_PERIOD   (83.333), //12MHz

       /* Set VCO frequency to 12*64=768 MHz
	Allowed values are 2.0 to 64.0. Resulting VCO freq
	needs to be 600-1200MHz */
       .CLKFBOUT_MULT_F (64.000),

       .CLKOUT0_DIVIDE_F (48.000)) // 768/48 = 16 MHz
   pll
     (.CLKIN1   (i_clk),
      .RST      (i_rst),
      .CLKOUT0  (o_clk),
      .LOCKED   (locked),
      .CLKFBOUT (clkfb),
      .CLKFBIN  (clkfb));

   always @(posedge o_clk) begin
      locked_r <= locked;
      o_rst  <= !locked_r;
   end

endmodule
`default_nettype wire
