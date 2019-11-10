`default_nettype none
module servix_clock_gen
  (input wire  i_clk,
   output wire o_clk,
   output reg  o_rst);

   parameter frequency = 32;

   wire   clkfb;
   wire   locked;
   reg 	  locked_r;

   PLLE2_BASE
     #(.BANDWIDTH("OPTIMIZED"),
       .CLKFBOUT_MULT(16),
       .CLKIN1_PERIOD(10.0), //100MHz
       .CLKOUT0_DIVIDE((frequency == 32) ? 50 : 100),
       .DIVCLK_DIVIDE(1),
       .STARTUP_WAIT("FALSE"))
   PLLE2_BASE_inst
     (.CLKOUT0(o_clk),
      .CLKOUT1(),
      .CLKOUT2(),
      .CLKOUT3(),
      .CLKOUT4(),
      .CLKOUT5(),
      .CLKFBOUT(clkfb),
      .LOCKED(locked),
      .CLKIN1(i_clk),
      .PWRDWN(1'b0),
      .RST(1'b0),
      .CLKFBIN(clkfb));

   always @(posedge o_clk) begin
      locked_r <= locked;
      o_rst  <= !locked_r;
   end

endmodule
