`default_nettype none
module servis
(
 input wire  i_clk,
 output wire q);

   parameter memfile = "zephyr_hello.hex";
   parameter memsize = 8192;
   parameter PLL = "NONE";

   wire      wb_clk;
   wire      wb_rst;

   servis_clock_gen
   clock_gen
     (.i_clk (i_clk),
      .o_clk (wb_clk),
      .o_rst (wb_rst));

   servant
     #(.memfile (memfile),
       .memsize (memsize))
   servant
     (.wb_clk (wb_clk),
      .wb_rst (wb_rst),
      .q      (q));

endmodule
