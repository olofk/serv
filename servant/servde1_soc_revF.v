`default_nettype none
module servde1_soc_revF
(
 input wire 	   i_clk,
 input wire 	   i_rst_n,
 output wire 	   q,
 output wire 	   uart_txd);

   parameter memfile = "zephyr_hello.hex";
   parameter memsize = 8192;

   wire      wb_clk;
   wire      wb_rst;

   assign uart_txd = q;

   servde1_soc_revF_clock_gen clock_gen
     (.i_clk (i_clk),
      .i_rst (!i_rst_n),
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
