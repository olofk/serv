`default_nettype none
module servant_ax309
(
 input wire  i_clk,
 input wire  i_rst,
 output wire o_uart_tx,
 output wire q);

   parameter memfile = "zephyr_hello.hex";
   parameter memsize = 8192;

   wire      wb_clk;
   wire      wb_rst;

   assign o_uart_tx = q;

   servant_ax309_clock_gen
   clock_gen
     (.i_clk (i_clk),
      .i_rst (i_rst),
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
