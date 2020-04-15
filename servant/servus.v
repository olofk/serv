`default_nettype none
module servus
  (input wire  i_clk_p,
   input wire  i_clk_n,
   output wire o_uart_tx,
   output wire q);

   parameter memfile = "zephyr_hello.hex";
   parameter memsize = 8192;

   wire      i_clk;
   wire      clk;
   wire      rst;

   assign o_uart_tx = q;

   IBUFDS ibufds
     (.I  (i_clk_p),
      .IB (i_clk_n),
      .O  (i_clk));

   servus_clock_gen
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
