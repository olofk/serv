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
  #( // Memory parameters
    parameter depth = 256,    //depth = 8192 then 1024 location 1024-128=896/2=448
    parameter aw    = $clog2(depth),  
    parameter memfile = ""
  )
  (
    input wire          i_clk,
    input wire          i_rst,
    input wire [aw-1:0] i_waddr,
    input wire [7:0]    i_wdata,
    input wire          i_wen,
    input wire [aw-1:0] i_raddr,
    output reg [7:0]    o_rdata
    //input wire          i_ren
  );
// 128 bytes for register file, 
  reg [7:0] mem [0:depth-1] /* verilator public */;
  integer i;

  // Synchronous read/write logic
  always @(posedge i_clk) begin
   if (i_rst) begin
   o_rdata <= 8'h00;
   end else begin
      if (i_wen) begin
        mem[i_waddr] <= i_wdata;  // Perform write
        o_rdata      <= 8'h00;    // Mask output during write
      end else begin
        o_rdata <= mem[i_raddr];  // Perform read
      end
    end
end

  // Initial block: zero-initialize memory, then optionally preload file
initial begin
 // o_rdata = 8'h00;
  for (i = 0; i < depth; i = i + 1)
    mem[i] = 8'h00;

  if (|memfile) begin
    $display("Preloading %m from %s", memfile);
    $readmemh(memfile, mem);
  end
end

endmodule
