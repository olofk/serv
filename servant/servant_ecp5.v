`default_nettype none
module servant_ecp5
(
 input wire  clk,
 input wire btn0,
 output wire wifi_gpio0,
 output wire uart_txd,
 output wire q);

   parameter memfile = "zephyr_hello.hex";
   parameter memsize = 8192;

   wire      wb_clk;
   wire      wb_rst;

   assign wifi_gpio0 = btn0;
   assign uart_txd = q;

   servant_ecp5_clock_gen clock_gen
     (.i_clk (clk),
      .i_rst (!btn0),
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
