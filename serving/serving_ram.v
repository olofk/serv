/* serving_ram.v : I/D SRAM for the serving SoC
 *
 * ISC License
 *
 * Copyright (C) 2020 Olof Kindgren <olof.kindgren@gmail.com>
 *
 * Permission to use, copy, modify, and/or distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */

`default_nettype none
module serving_ram
  #(//Memory parameters
    parameter depth = 256,
    parameter aw    = $clog2(depth),
    parameter memfile = "")
   (input wire		i_clk,
    input wire [aw-1:0]	i_waddr,
    input wire [7:0]	i_wdata,
    input wire		i_wen,
    input wire [aw-1:0]	i_raddr,
    output reg [7:0]	o_rdata);

   reg [7:0]		mem [0:depth-1] /* verilator public */;

   always @(posedge i_clk) begin
      if (i_wen) mem[i_waddr]   <= i_wdata;
      o_rdata <= mem[i_raddr];
   end

   initial begin
     if(|memfile) begin
	$display("Preloading %m from %s", memfile);
	$readmemh(memfile, mem);
     end

     // The last 4 bytes are the `x0` (zero) register. Zero them out
     // to avoid starting the simulation with `x0` undefined.
     mem[depth-4] = 8'h0;
     mem[depth-3] = 8'h0;
     mem[depth-2] = 8'h0;
     mem[depth-1] = 8'h0;
   end
endmodule
