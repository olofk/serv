`default_nettype none
module servant_ecp5_evn
(
 input wire  clk,
 input wire nreset,
 output wire led0,
 output wire uart_txd);

   parameter memfile = "zephyr_hello.hex";
   parameter memsize = 8192;

   wire      wb_clk;
   wire      wb_rst;

   assign led0 = nreset;

   servant_ecp5_evn_clock_gen clock_gen
     (.i_clk (clk),
      .i_rst (!nreset),
      .o_clk (wb_clk),
      .o_rst (wb_rst));

   servant
     #(.memfile (memfile),
       .memsize (memsize))
   servant
     (.wb_clk (wb_clk),
      .wb_rst (wb_rst),
      .q      (uart_txd));

endmodule
