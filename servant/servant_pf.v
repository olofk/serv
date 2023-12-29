`default_nettype none

module servant_pf (
	input  wire i_clk,
	input  wire resetb,
	output wire o_led1,
	output wire o_led2,
	output wire o_led3 = 1'b0,
	output wire o_led4 = 1'b0,
	output wire o_led5 = 1'b0,
	output wire o_led6 = 1'b0,
	output wire o_led7 = 1'b0,
	output wire o_led8 = 1'b0,
	output wire o_uart_tx);

	parameter memfile = "zephyr_hello.hex";
	parameter memsize = 8192;

	wire	clk;
	wire	rst;
	wire	q;
	wire	CLKINT_0_Y;
	reg		heartbeat;

	CLKINT CLKINT_0(
		.A (i_clk),
		.Y (CLKINT_0_Y)
	);

	servant_pf_clock_gen #(
		.refclk(50),
		.frequency(32)
	) clock_gen (
		.i_clk (CLKINT_0_Y),
		.o_clk (clk)
	);

	servant #(
		.memfile (memfile),
		.memsize (memsize)
	) servant (
		.wb_clk	(clk),
		.wb_rst	(rst),
		.q		(q)
	);

	// heartbeat LED
	reg [$clog2(32000000)-1:0] count = 0;
	always @(posedge clk) begin
		if (rst) begin
			count <= 0;
			heartbeat <= 0;
		end else
			count <= count + 1;
		if (count == 32000000-1) begin
			heartbeat <= !heartbeat;
			count <= 0;
		end
	end

	assign rst = ~resetb;
	assign o_led1 = q;
	assign o_led2 = heartbeat;
	assign o_uart_tx = q;

endmodule
