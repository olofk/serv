`default_nettype none
module servant_ac701
(
   input wire  sys_clk_p,
   input wire  sys_clk_n,
   input wire btn,
   output wire q);

   parameter frequency = 16;
   parameter memfile = "zephyr_hello.hex";
   parameter memsize = 8192;
   parameter PLL = "NONE";

   wire      wb_clk;
   reg       wb_rst;
   wire      clk;
   wire      clkfb;
   wire      locked;
   reg       locked_r;

   IBUFDS ibufds
   (
     .I  (sys_clk_p),
     .IB (sys_clk_n),
     .O  (clk)
   );

   PLLE2_BASE
     #(.BANDWIDTH("OPTIMIZED"),
       .CLKFBOUT_MULT(8),
       .CLKIN1_PERIOD(5.0), //200MHz
       .CLKOUT0_DIVIDE((frequency == 32) ? 50 : 100),
       .DIVCLK_DIVIDE(1),
       .STARTUP_WAIT("FALSE"))
   PLLE2_BASE_inst
     (.CLKOUT0(wb_clk),
      .CLKOUT1(),
      .CLKOUT2(),
      .CLKOUT3(),
      .CLKOUT4(),
      .CLKOUT5(),
      .CLKFBOUT(clkfb),
      .LOCKED(locked),
      .CLKIN1(clk),
      .PWRDWN(1'b0),
      .RST(1'b0),
      .CLKFBIN(clkfb));

   always @(posedge wb_clk) begin
      locked_r <= locked;
      wb_rst <= !locked_r;
   end

   servant
     #(.memfile (memfile),
       .memsize (memsize))
   servant
     (.wb_clk (wb_clk),
      .wb_rst (wb_rst),
      .q      (q));

endmodule
