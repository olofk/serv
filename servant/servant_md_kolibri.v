// based on servant_upduino2.v

`default_nettype none
module servant_md_kolibri
  (
   input wire clk48,
   output wire led,
   output wire tx);

   parameter memfile = "zephyr_hello.hex";
   parameter memsize = 8192;

   wire        clk32;
   wire        locked;

   reg         rst = 1'b1;

   // 48MHz -> 32MHz
	SB_PLL40_CORE #(
      .FEEDBACK_PATH("SIMPLE"),
      .DIVR(4'b0010),        // DIVR =  2
      .DIVF(7'b0111111),     // DIVF = 63
      .DIVQ(3'b101),         // DIVQ =  5
      .FILTER_RANGE(3'b001)  // FILTER_RANGE = 1
   ) uut (
      .LOCK(locked),
      .RESETB(1'b1),
      .BYPASS(1'b0),
      .REFERENCECLK(clk48),
      .PLLOUTCORE(clk32)
   );

   always @(posedge clk32)
     rst <= !locked;

   servant
     #(.memfile (memfile),
       .memsize (memsize))
   servant
     (.wb_clk (clk32),
      .wb_rst (rst),
      .q      (tx));

	assign led = tx;

endmodule
