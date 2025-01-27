`default_nettype none
module servant_nexys_a7
  (
   input wire  i_clk,
   input wire  i_rst,
   input wire  ext_irq,
   output wire o_uart_tx,
   output wire q);

   parameter   memfile = "zephyr_hello.hex";
   parameter   memsize = 8192;

   wire        main_clk;
   wire        wb_clk;
   wire        wb_rst;
   wire        sleep;

   assign o_uart_tx = q;

   servant_nexys_a7_clock_gen
     clock_gen
       (.i_clk (i_clk),
        .i_rst (i_rst),
        .i_clk0_en (1),
        .i_clk1_en (!sleep),
        .o_clk0 (main_clk),
        .o_clk1 (wb_clk),
        .o_rst (wb_rst));

   servant
     #(.memfile (memfile),
       .memsize (memsize))
   servant
     (.wb_clk (wb_clk),
      .main_clk (main_clk),
      .wb_rst (wb_rst),
      .q      (q),
      .ext_irq (ext_irq),
      .o_sleep (sleep));

endmodule
`default_nettype wire
