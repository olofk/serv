`default_nettype none
module servant_ice40_cm36 (
    input  wire i_clk,
    output wire o_led
);

  parameter memfile = "blinky.hex";
  parameter memsize = 7168;

  wire wb_clk;
  reg  wb_rst;

  /* iCE40 CM36 has no PLL. Drive everything from the external clock. */
  assign wb_clk = i_clk;

  /* Board has no button that can be used for reset, but blinky doesn't
   * work at all if the reset isn't enabled for at least 25 clocks.
   *
   * This will generate a reset signal at power on.
   */
  reg [7:0] rst_cnt = '0;

  always @(posedge i_clk) begin
    if (rst_cnt < 255) begin
      rst_cnt <= rst_cnt + 1;
      wb_rst  <= 1;
    end else begin
      wb_rst <= 0;
    end
  end

  servant #(
      .memfile(memfile),
      .memsize(memsize)
  ) servant (
      .wb_clk(wb_clk),
      .wb_rst(wb_rst),
      .q     (o_led)
  );

endmodule
