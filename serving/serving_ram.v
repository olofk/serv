/* serving_ram.v : Shared RF I/D SRAM for the serving SoC
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
   (input wire          i_clk,
    input wire [aw-1:0] i_waddr,
    input wire [7:0]    i_wdata,
    input wire          i_wen,
    input wire [aw-1:0] i_raddr,
    output wire [7:0]   o_rdata,

    input wire [aw-1:2] i_wb_adr,
    input wire [31:0]   i_wb_dat,
    input wire [3:0]    i_wb_sel,
    input wire          i_wb_we,
    input wire          i_wb_stb,
    output wire [31:0]  o_wb_rdt,
    output reg          o_wb_ack);

   reg [1:0]            bsel;
   reg [7:0] rdata;

   wire                 wb_en = i_wb_stb & !i_wen & !o_wb_ack;

   wire                 wb_we = i_wb_we & i_wb_sel[bsel];

   wire                 we = wb_en ? wb_we : i_wen;

   reg [7:0]            mem [0:depth-1] /* verilator public */;

   wire [aw-1:0]        waddr = wb_en ? {i_wb_adr[aw-1:2],bsel} : i_waddr;
   wire [7:0]           wdata = wb_en ? i_wb_dat[bsel*8+:8]     : i_wdata;
   wire [aw-1:0]        raddr = wb_en ? {i_wb_adr[aw-1:2],bsel} : i_raddr;

   reg [23:0]           wb_rdt;
   assign o_wb_rdt = {rdata, wb_rdt};

   always @(posedge i_clk) begin
      if (wb_en) bsel <= bsel + 2'd1;
      o_wb_ack <= wb_en & &bsel;
      if (bsel == 2'b01) wb_rdt[7:0]   <= rdata;
      if (bsel == 2'b10) wb_rdt[15:8]  <= rdata;
      if (bsel == 2'b11) wb_rdt[23:16] <= rdata;
   end

   always @(posedge i_clk) begin
      if (we) mem[waddr]   <= wdata;
      rdata <= mem[raddr];
   end

   initial
     if(|memfile) begin
        $display("Preloading %m from %s", memfile);
        $readmemh(memfile, mem);
     end

   assign o_rdata = rdata;
endmodule
