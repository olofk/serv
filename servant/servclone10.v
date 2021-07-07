`default_nettype none
module servclone10
(
 input wire        i_clk,
 input wire        i_rst,
 output wire       q,
 output wire       uart_txd);

   parameter memfile = "zephyr_hello.hex";
   parameter memsize = 8192;

   wire      wb_clk;
   wire      wb_rst;

   assign uart_txd = q;

   servclone10_clock_gen clock_gen
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
