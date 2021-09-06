`default_nettype none
module servant_catzip
  (
   output wire g,
   output wire b,
   output wire r,
   output wire q);

   parameter memfile = "zephyr_hello.hex";
   parameter memsize = 8192;
   parameter PLL = "NONE";

   wire        i_clk;
   wire        clk40;
   wire        locked;

   SB_HFOSC inthosc
     (
      .CLKHFPU(1'b1),
      .CLKHFEN(1'b1),
      .CLKHF(clk48));

   SB_PLL40_CORE
     #(
       .FEEDBACK_PATH("SIMPLE"),
       .DIVR(4'b0100),
       .DIVF(7'b0011111),
       .DIVQ(3'b100),
       .FILTER_RANGE(3'b010))
   ice40_pll
     (.LOCK(locked),
      .RESETB(1'b1),
      .BYPASS(1'b0),
      .REFERENCECLK(clk40),
      .PLLOUTCORE(i_clk));

   SB_RGBA_DRV
     #(
       .CURRENT_MODE ("0b1"),
       .RGB0_CURRENT ("0b000111"),
       .RGB1_CURRENT ("0b000111"),
       .RGB2_CURRENT ("0b000111"))
   RGBA_DRIVER
     (
      .CURREN(1'b1),
      .RGBLEDEN(1'b1),
      .RGB0PWM(q),
      .RGB1PWM(q),
      .RGB2PWM(q),
      .RGB0(g),
      .RGB1(b),
      .RGB2(r));

   reg 	     rst = 1'b1;

/*
   //Delayed reset
   reg [25:0] cnt;
   always @(posedge i_clk) begin
      if (!cnt[25])
	cnt <= cnt + 1;
      rst <= !cnt[25];
   end
 */

   always @(posedge i_clk)
     rst <= !locked;

   servant
     #(.memfile (memfile),
       .memsize (memsize))
   servant
     (.wb_clk (i_clk),
      .wb_rst (rst),
      .q      (q));

endmodule
