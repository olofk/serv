`default_nettype none
module servant_ice40_cm36 (
    input  wire i_clk,
    output wire o_led,
    output wire o_uart_tx
);

  parameter memfile = "blinky.hex";
  parameter memsize = 7168;

  wire wb_clk;
  wire wb_rst;
  wire q;

  /* Duplicate the SERV output to both LED and UART pins. */
  assign o_led = q;
  assign o_uart_tx = q;

  /* iCE40 CM36 has no PLL. Drive everything from the external clock. */
  assign wb_clk = i_clk;

  /* Board has no button that can be used for reset. */
  assign wb_rst = 1'b0;

  servant #(
      .memfile(memfile),
      .memsize(memsize)
  ) servant (
      .wb_clk(wb_clk),
      .wb_rst(wb_rst),
      .q     (q)
  );

endmodule
