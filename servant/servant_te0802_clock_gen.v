`default_nettype none
module servant_te0802_clock_gen
  (input wire  i_clk,
   output wire o_clk,
   output reg  o_rst);

   wire   clkfb;
   wire   locked;
   reg 	  locked_r;

   // Generate a 32 MHz clock from the 25MHz clock input
   MMCME4_ADV
     #(.DIVCLK_DIVIDE    (1),
       .CLKFBOUT_MULT_F  (48.000),
       .CLKOUT0_DIVIDE_F (37.5),
       .CLKIN1_PERIOD    (40.0), //25MHz
       .STARTUP_WAIT     ("FALSE"))
   mmcm
     (.CLKFBOUT    (clkfb),
      .CLKFBOUTB   (),
      .CLKOUT0     (o_clk),
      .CLKOUT0B    (),
      .CLKOUT1     (),
      .CLKOUT1B    (),
      .CLKOUT2     (),
      .CLKOUT2B    (),
      .CLKOUT3     (),
      .CLKOUT3B    (),
      .CLKOUT4     (),
      .CLKOUT5     (),
      .CLKOUT6     (),
      .CLKIN1      (i_clk),
      .CLKIN2      (1'b0),
      .CLKINSEL    (1'b1),
      .LOCKED      (locked),
      .PWRDWN      (1'b0),
      .RST         (1'b0),
      .CLKFBIN     (clkfb));

   always @(posedge o_clk) begin
      locked_r <= locked;
      o_rst  <= !locked_r;
   end

endmodule
