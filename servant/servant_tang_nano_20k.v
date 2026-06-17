`default_nettype none
module servant_tang_nano_20k(
    input wire i_clk,
    input wire i_rst,
    output wire led,
    output wire o_uart_tx
);

    wire wb_clk;
    wire locked;
    wire q;
    reg wb_rst = 1'b1;

    // UART output to LED
    assign led = o_uart_tx;
    assign o_uart_tx = q;

    parameter memfile = "zephyr_hello.hex";
    parameter memsize = 8192;

    // Create a 16MHz clock from 27MHz using PLL
    tang_nano_20k_clock_gen pll (
        .lock (locked),
        .clkoutd (wb_clk),
        .reset(i_rst),
        .clkin (i_clk)
    );

    always @(posedge wb_clk)
        wb_rst <= !locked;

    servant
        #(.memfile (memfile),
        .memsize (memsize))
    servant
        (.wb_clk (wb_clk),
        .wb_rst (wb_rst),
        .q      (q));

endmodule

