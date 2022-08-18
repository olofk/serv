////////////////////////////////////////////////////////////////////////////////
//
// Filename: 	helloworld.v
//
// Project:	ICO Zip, iCE40 ZipCPU demonsrtation project
//
// Purpose:	To create a *very* simple UART test program, which can be used
//		as the top level design file of any FPGA program.
//
//
// Creator:	Dan Gisselquist, Ph.D.
//		Gisselquist Technology, LLC
//
////////////////////////////////////////////////////////////////////////////////
//
// Copyright (C) 2015-2017, Gisselquist Technology, LLC
//
// This program is free software (firmware): you can redistribute it and/or
// modify it under the terms of  the GNU General Public License as published
// by the Free Software Foundation, either version 3 of the License, or (at
// your option) any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTIBILITY or
// FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
// for more details.
//
// You should have received a copy of the GNU General Public License along
// with this program.  (It's in the $(ROOT)/doc directory.  Run make with no
// target there if the PDF file isn't present.)  If not, see
// <http://www.gnu.org/licenses/> for a copy.
//
// License:	GPL, v3, as defined and found on www.gnu.org,
//		http://www.gnu.org/licenses/gpl.html
//
//
////////////////////////////////////////////////////////////////////////////////
//
//
//
module	helloworld(i_clk,
			o_ledg,
			i_rts, i_uart_rx, o_cts,
			o_uart_tx);
	//
	input		i_clk;
	output	wire	o_ledg;
	input		i_rts, i_uart_rx;
	output		o_cts;
	output	wire	o_uart_tx;

	assign	o_cts = 1'b1;

	// If i_setup isnt set up as an input parameter, it needs to be set.
	// We do so here, to a setting appropriate to create a 115200 Baud
	// comms system from a 100MHz clock.  This also sets us to an 8-bit
	// data word, 1-stop bit, and no parity.
	wire	[29:0]	i_setup;
	assign		i_setup = 30'd868;	// 115200 Baud, if clk @ 100MHz

	reg	pwr_reset;
	initial	pwr_reset = 1'b1;
	always @(posedge i_clk)
		pwr_reset <= 1'b0;

	reg	[24:0]	ledctr;
	initial	ledctr = 0;
	always @(posedge i_clk)
		if (!o_uart_tx)
			ledctr <= 0;
		else if (ledctr != {(25){1'b1}})
			ledctr <= ledctr + 1'b1;
	assign	o_ledg = !ledctr[24];

	reg	[7:0]	message	[0:15];
	
	initial begin
		message[ 0] = "H";
		message[ 1] = "e";
		message[ 2] = "l";
		message[ 3] = "l";
		message[ 4] = "o";
		message[ 5] = ",";
		message[ 6] = " ";
		message[ 7] = "W";
		message[ 8] = "o";
		message[ 9] = "r";
		message[10] = "l";
		message[11] = "d";
		message[12] = "!";
		message[13] = " ";
		message[14] = "\r";
		message[15] = "\n";
	end

	reg	[27:0]	counter;
	initial	counter = 28'hffffff0;
	always @(posedge i_clk)
		counter <= counter + 1'b1;

	wire		tx_break, tx_busy;
	reg		tx_stb;
	reg	[3:0]	tx_index;
	reg	[7:0]	tx_data;

	assign	tx_break = 1'b0;

	initial	tx_index = 4'h0;
	always @(posedge i_clk)
		if ((tx_stb)&&(!tx_busy))
			tx_index <= tx_index + 1'b1;
	always @(posedge i_clk)
		tx_data <= message[tx_index];

	initial	tx_stb = 1'b0;
	always @(posedge i_clk)
		if (&counter)
			tx_stb <= 1'b1;
		else if ((tx_stb)&&(!tx_busy)&&(tx_index==4'hf))
			tx_stb <= 1'b0;

	// 868 is 115200 Baud, based upon a 100MHz clock
	txuartlite #(.TIMING_BITS(10), .CLOCKS_PER_BAUD(868))
		transmitter(i_clk, tx_stb, tx_data, o_uart_tx, tx_busy);

endmodule
////////////////////////////////////////////////////////////////////////////////
//
// Filename: 	txuartlite.v
//
// Project:	wbuart32, a full featured UART with simulator
//
// Purpose:	Transmit outputs over a single UART line.  This particular UART
//		implementation has been extremely simplified: it does not handle
//	generating break conditions, nor does it handle anything other than the
//	8N1 (8 data bits, no parity, 1 stop bit) UART sub-protocol.
//
//	To interface with this module, connect it to your system clock, and
//	pass it the byte of data you wish to transmit.  Strobe the i_wr line
//	high for one cycle, and your data will be off.  Wait until the 'o_busy'
//	line is low before strobing the i_wr line again--this implementation
//	has NO BUFFER, so strobing i_wr while the core is busy will just
//	get ignored.  The output will be placed on the o_txuart output line.
//
//	(I often set both data and strobe on the same clock, and then just leave
//	them set until the busy line is low.  Then I move on to the next piece
//	of data.)
//
// Creator:	Dan Gisselquist, Ph.D.
//		Gisselquist Technology, LLC
//
////////////////////////////////////////////////////////////////////////////////
//
// Copyright (C) 2015-2017, Gisselquist Technology, LLC
//
// This program is free software (firmware): you can redistribute it and/or
// modify it under the terms of  the GNU General Public License as published
// by the Free Software Foundation, either version 3 of the License, or (at
// your option) any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTIBILITY or
// FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
// for more details.
//
// You should have received a copy of the GNU General Public License along
// with this program.  (It's in the $(ROOT)/doc directory.  Run make with no
// target there if the PDF file isn't present.)  If not, see
// <http://www.gnu.org/licenses/> for a copy.
//
// License:	GPL, v3, as defined and found on www.gnu.org,
//		http://www.gnu.org/licenses/gpl.html
//
//
////////////////////////////////////////////////////////////////////////////////
//
//
`default_nettype	none
//
`define	TXUL_BIT_ZERO	4'h0
`define	TXUL_BIT_ONE	4'h1
`define	TXUL_BIT_TWO	4'h2
`define	TXUL_BIT_THREE	4'h3
`define	TXUL_BIT_FOUR	4'h4
`define	TXUL_BIT_FIVE	4'h5
`define	TXUL_BIT_SIX	4'h6
`define	TXUL_BIT_SEVEN	4'h7
`define	TXUL_STOP	4'h8
`define	TXUL_IDLE	4'hf
//
//
module txuartlite(i_clk, i_wr, i_data, o_uart_tx, o_busy);
	parameter	[4:0]	TIMING_BITS = 5'd24;
	localparam		TB = TIMING_BITS;
	parameter	[(TB-1):0]	CLOCKS_PER_BAUD = 8; // 24'd868;
	parameter	[0:0]	F_OPT_CLK2FFLOGIC = 1'b0;
	input	wire		i_clk;
	input	wire		i_wr;
	input	wire	[7:0]	i_data;
	// And the UART input line itself
	output	reg		o_uart_tx;
	// A line to tell others when we are ready to accept data.  If
	// (i_wr)&&(!o_busy) is ever true, then the core has accepted a byte
	// for transmission.
	output	wire		o_busy;

	reg	[(TB-1):0]	baud_counter;
	reg	[3:0]	state;
	reg	[7:0]	lcl_data;
	reg		r_busy, zero_baud_counter;

	initial	r_busy = 1'b1;
	initial	state  = `TXUL_IDLE;
	always @(posedge i_clk)
	begin
		if (!zero_baud_counter)
			// r_busy needs to be set coming into here
			r_busy <= 1'b1;
		else if (state > `TXUL_STOP)	// STATE_IDLE
		begin
			state <= `TXUL_IDLE;
			r_busy <= 1'b0;
			if ((i_wr)&&(!r_busy))
			begin	// Immediately start us off with a start bit
				r_busy <= 1'b1;
				state <= `TXUL_BIT_ZERO;
			end
		end else begin
			// One clock tick in each of these states ...
			r_busy <= 1'b1;
			if (state <=`TXUL_STOP) // start bit, 8-d bits, stop-b
				state <= state + 1'b1;
			else
				state <= `TXUL_IDLE;
		end
	end

	// o_busy
	//
	// This is a wire, designed to be true is we are ever busy above.
	// originally, this was going to be true if we were ever not in the
	// idle state.  The logic has since become more complex, hence we have
	// a register dedicated to this and just copy out that registers value.
	assign	o_busy = (r_busy);


	// lcl_data
	//
	// This is our working copy of the i_data register which we use
	// when transmitting.  It is only of interest during transmit, and is
	// allowed to be whatever at any other time.  Hence, if r_busy isn't
	// true, we can always set it.  On the one clock where r_busy isn't
	// true and i_wr is, we set it and r_busy is true thereafter.
	// Then, on any zero_baud_counter (i.e. change between baud intervals)
	// we simple logically shift the register right to grab the next bit.
	initial	lcl_data = 8'hff;
	always @(posedge i_clk)
		if ((i_wr)&&(!r_busy))
			lcl_data <= i_data;
		else if (zero_baud_counter)
			lcl_data <= { 1'b1, lcl_data[7:1] };

	// o_uart_tx
	//
	// This is the final result/output desired of this core.  It's all
	// centered about o_uart_tx.  This is what finally needs to follow
	// the UART protocol.
	//
	initial	o_uart_tx = 1'b1;
	always @(posedge i_clk)
		if ((i_wr)&&(!r_busy))
			o_uart_tx <= 1'b0;	// Set the start bit on writes
		else if (zero_baud_counter)	// Set the data bit.
			o_uart_tx <= lcl_data[0];


	// All of the above logic is driven by the baud counter.  Bits must last
	// CLOCKS_PER_BAUD in length, and this baud counter is what we use to
	// make certain of that.
	//
	// The basic logic is this: at the beginning of a bit interval, start
	// the baud counter and set it to count CLOCKS_PER_BAUD.  When it gets
	// to zero, restart it.
	//
	// However, comparing a 28'bit number to zero can be rather complex--
	// especially if we wish to do anything else on that same clock.  For
	// that reason, we create "zero_baud_counter".  zero_baud_counter is
	// nothing more than a flag that is true anytime baud_counter is zero.
	// It's true when the logic (above) needs to step to the next bit.
	// Simple enough?
	//
	// I wish we could stop there, but there are some other (ugly)
	// conditions to deal with that offer exceptions to this basic logic.
	//
	// 1. When the user has commanded a BREAK across the line, we need to
	// wait several baud intervals following the break before we start
	// transmitting, to give any receiver a chance to recognize that we are
	// out of the break condition, and to know that the next bit will be
	// a stop bit.
	//
	// 2. A reset is similar to a break condition--on both we wait several
	// baud intervals before allowing a start bit.
	//
	// 3. In the idle state, we stop our counter--so that upon a request
	// to transmit when idle we can start transmitting immediately, rather
	// than waiting for the end of the next (fictitious and arbitrary) baud
	// interval.
	//
	// When (i_wr)&&(!r_busy)&&(state == `TXUL_IDLE) then we're not only in
	// the idle state, but we also just accepted a command to start writing
	// the next word.  At this point, the baud counter needs to be reset
	// to the number of CLOCKS_PER_BAUD, and zero_baud_counter set to zero.
	//
	// The logic is a bit twisted here, in that it will only check for the
	// above condition when zero_baud_counter is false--so as to make
	// certain the STOP bit is complete.
	initial	zero_baud_counter = 1'b1;
	initial	baud_counter = 0;
	always @(posedge i_clk)
	begin
		zero_baud_counter <= (baud_counter == 24'h01);
		if (state == `TXUL_IDLE)
		begin
			baud_counter <= 24'h0;
			zero_baud_counter <= 1'b1;
			if ((i_wr)&&(!r_busy))
			begin
				baud_counter <= CLOCKS_PER_BAUD - 24'h01;
				zero_baud_counter <= 1'b0;
			end
		end else if ((zero_baud_counter)&&(state == 4'h9))
		begin
			baud_counter <= 0;
			zero_baud_counter <= 1'b1;
		end else if (!zero_baud_counter)
			baud_counter <= baud_counter - 24'h01;
		else
			baud_counter <= CLOCKS_PER_BAUD - 24'h01;
	end

//
//
// FORMAL METHODS
//
//
//
`ifdef	FORMAL

`ifdef	TXUARTLITE
`define	ASSUME	assume
`else
`define	ASSUME	assert
`endif

	// Setup

	reg	f_past_valid, f_last_clk;

	generate if (F_OPT_CLK2FFLOGIC)
	begin

		always @($global_clock)
		begin
			restrict(i_clk == !f_last_clk);
			f_last_clk <= i_clk;
			if (!$rose(i_clk))
			begin
				`ASSUME($stable(i_wr));
				`ASSUME($stable(i_data));
			end
		end

	end endgenerate

	initial	f_past_valid = 1'b0;
	always @(posedge i_clk)
		f_past_valid <= 1'b1;

	initial	`ASSUME(!i_wr);
	always @(posedge i_clk)
		if ((f_past_valid)&&($past(i_wr))&&($past(o_busy)))
		begin
			`ASSUME(i_wr   == $past(i_wr));
			`ASSUME(i_data == $past(i_data));
		end

	// Check the baud counter
	always @(posedge i_clk)
		assert(zero_baud_counter == (baud_counter == 0));

	always @(posedge i_clk)
		if ((f_past_valid)&&($past(baud_counter != 0))&&($past(state != `TXUL_IDLE)))
			assert(baud_counter == $past(baud_counter - 1'b1));

	always @(posedge i_clk)
		if ((f_past_valid)&&(!$past(zero_baud_counter))&&($past(state != `TXUL_IDLE)))
			assert($stable(o_uart_tx));

	reg	[(TB-1):0]	f_baud_count;
	initial	f_baud_count = 1'b0;
	always @(posedge i_clk)
		if (zero_baud_counter)
			f_baud_count <= 0;
		else
			f_baud_count <= f_baud_count + 1'b1;

	always @(posedge i_clk)
		assert(f_baud_count < CLOCKS_PER_BAUD);

	always @(posedge i_clk)
		if (baud_counter != 0)
			assert(o_busy);

	reg	[9:0]	f_txbits;
	initial	f_txbits = 0;
	always @(posedge i_clk)
		if (zero_baud_counter)
			f_txbits <= { o_uart_tx, f_txbits[9:1] };

	always @(posedge i_clk)
	if ((f_past_valid)&&(!$past(zero_baud_counter))
			&&(!$past(state==`TXUL_IDLE)))
		assert(state == $past(state));

	reg	[3:0]	f_bitcount;
	initial	f_bitcount = 0;
	always @(posedge i_clk)
		if ((!f_past_valid)||(!$past(f_past_valid)))
			f_bitcount <= 0;
		else if ((state == `TXUL_IDLE)&&(zero_baud_counter))
			f_bitcount <= 0;
		else if (zero_baud_counter)
			f_bitcount <= f_bitcount + 1'b1;

	always @(posedge i_clk)
		assert(f_bitcount <= 4'ha);

	reg	[7:0]	f_request_tx_data;
	always @(posedge i_clk)
		if ((i_wr)&&(!o_busy))
			f_request_tx_data <= i_data;

	wire	[3:0]	subcount;
	assign	subcount = 10-f_bitcount;
	always @(posedge i_clk)
		if (f_bitcount > 0)
			assert(!f_txbits[subcount]);

	always @(posedge i_clk)
		if (f_bitcount == 4'ha)
		begin
			assert(f_txbits[8:1] == f_request_tx_data);
			assert( f_txbits[9]);
		end

	always @(posedge i_clk)
		assert((state <= `TXUL_STOP + 1'b1)||(state == `TXUL_IDLE));

	always @(posedge i_clk)
	if ((f_past_valid)&&($past(f_past_valid))&&($past(o_busy)))
		cover(!o_busy);

`endif	// FORMAL
`ifdef	VERIFIC_SVA
	reg	[7:0]	fsv_data;

	//
	// Grab a copy of the data any time we are sent a new byte to transmit
	// We'll use this in a moment to compare the item transmitted against
	// what is supposed to be transmitted
	//
	always @(posedge i_clk)
		if ((i_wr)&&(!o_busy))
			fsv_data <= i_data;

	//
	// One baud interval
	//
	// 1. The UART output is constant at DAT
	// 2. The internal state remains constant at ST
	// 3. CKS = the number of clocks per bit.
	//
	// Everything stays constant during the CKS clocks with the exception
	// of (zero_baud_counter), which is *only* raised on the last clock
	// interval
	sequence	BAUD_INTERVAL(CKS, DAT, SR, ST);
		((o_uart_tx == DAT)&&(state == ST)
			&&(lcl_data == SR)
			&&(!zero_baud_counter))[*(CKS-1)]
		##1 (o_uart_tx == DAT)&&(state == ST)
			&&(lcl_data == SR)
			&&(zero_baud_counter);
	endsequence

	//
	// One byte transmitted
	//
	// DATA = the byte that is sent
	// CKS  = the number of clocks per bit
	//
	sequence	SEND(CKS, DATA);
		BAUD_INTERVAL(CKS, 1'b0, DATA, 4'h0)
		##1 BAUD_INTERVAL(CKS, DATA[0], {{(1){1'b1}},DATA[7:1]}, 4'h1)
		##1 BAUD_INTERVAL(CKS, DATA[1], {{(2){1'b1}},DATA[7:2]}, 4'h2)
		##1 BAUD_INTERVAL(CKS, DATA[2], {{(3){1'b1}},DATA[7:3]}, 4'h3)
		##1 BAUD_INTERVAL(CKS, DATA[3], {{(4){1'b1}},DATA[7:4]}, 4'h4)
		##1 BAUD_INTERVAL(CKS, DATA[4], {{(5){1'b1}},DATA[7:5]}, 4'h5)
		##1 BAUD_INTERVAL(CKS, DATA[5], {{(6){1'b1}},DATA[7:6]}, 4'h6)
		##1 BAUD_INTERVAL(CKS, DATA[6], {{(7){1'b1}},DATA[7:7]}, 4'h7)
		##1 BAUD_INTERVAL(CKS, DATA[7], 8'hff, 4'h8)
		##1 BAUD_INTERVAL(CKS, 1'b1, 8'hff, 4'h9);
	endsequence

	//
	// Transmit one byte
	//
	// Once the byte is transmitted, make certain we return to
	// idle
	//
	assert property (
		@(posedge i_clk)
		(i_wr)&&(!o_busy)
		|=> ((o_busy) throughout SEND(CLOCKS_PER_BAUD,fsv_data))
		##1 (!o_busy)&&(o_uart_tx)&&(zero_baud_counter));

	assume property (
		@(posedge i_clk)
		(i_wr)&&(o_busy) |=>
			(i_wr)&&(o_busy)&&($stable(i_data)));

	//
	// Make certain that o_busy is true any time zero_baud_counter is
	// non-zero
	//
	always @(*)
		assert((o_busy)||(zero_baud_counter) );

	// If and only if zero_baud_counter is true, baud_counter must be zero
	// Insist on that relationship here.
	always @(*)
		assert(zero_baud_counter == (baud_counter == 0));

	// To make certain baud_counter stays below CLOCKS_PER_BAUD
	always @(*)
		assert(baud_counter < CLOCKS_PER_BAUD);

	//
	// Insist that we are only ever in a valid state
	always @(*)
		assert((state <= `TXUL_STOP+1'b1)||(state == `TXUL_IDLE));

`endif // Verific SVA
endmodule

