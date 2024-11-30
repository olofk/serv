`default_nettype none
module servant_te0802
  (
    input wire  i_clk,
    output wire o_uart_tx,
    output wire o_led_0
  );

   parameter memfile = "zephyr_hello.hex";
   parameter memsize = 8192;

   wire      clk;
   wire      rst;
   wire      q;

   assign o_uart_tx = q;
   assign o_led_0 = q;

   servant_te0802_clock_gen
   clock_gen
     (.i_clk (i_clk),
      .o_clk (clk),
      .o_rst (rst));

   servant
     #(.memfile (memfile),
       .memsize (memsize))
   servant
     (.wb_clk (clk),
      .wb_rst (rst),
      .q      (q));

endmodule
