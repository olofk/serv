`default_nettype none
module servant_nexys_4
  (
   input wire  i_clk,
   input wire  i_rst,
   input wire  ext_irq,
   output wire o_uart_tx,
   output wire q);

   parameter   memfile = "zephyr_hello.hex";
   parameter   memsize = 8192;

   wire	       main_clk;
   wire	       wb_clk;
   wire	       wb_rst;

   wire	       sleep_req;
   wire	       wakeup_req;

   reg	       sleep;

   always @(posedge main_clk) begin
      if (sleep_req)
        sleep <= 0;
      if (wakeup_req)
        sleep <= 1;
      if (wb_rst)
        sleep <= 1;
   end

   assign o_uart_tx = q;

   servant_nexys_4_clock_gen
     clock_gen
       (.i_clk (i_clk),
	.i_rst (i_rst),
	.i_clk0_en (sleep),
	.i_clk1_en (1),
	.o_clk0 (main_clk),
	.o_clk1 (wb_clk),
	.o_rst (wb_rst));
   servant
     #(.memfile (memfile),
       .memsize (memsize))
   servant
     (.wb_clk (wb_clk),
      .wb_rst (wb_rst),
      .q      (q),
      .o_sleep_req  (sleep_req),
      .o_wakeup_req (wakeup_req));

endmodule
`default_nettype wire
