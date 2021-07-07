/* serving_mux.v : Simple Wishbone mux for the serving SoC
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

module serving_mux
  (
   input wire         i_clk,
   input wire         i_rst,

   input wire [31:0]  i_wb_cpu_adr,
   input wire [31:0]  i_wb_cpu_dat,
   input wire [3:0]   i_wb_cpu_sel,
   input wire         i_wb_cpu_we,
   input wire         i_wb_cpu_stb,
   output wire [31:0] o_wb_cpu_rdt,
   output wire        o_wb_cpu_ack,

   output wire [31:0] o_wb_mem_adr,
   output wire [31:0] o_wb_mem_dat,
   output wire [3:0]  o_wb_mem_sel,
   output wire        o_wb_mem_we,
   output wire        o_wb_mem_stb,
   input wire [31:0]  i_wb_mem_rdt,
   input wire         i_wb_mem_ack,

   output wire [31:0] o_wb_ext_adr,
   output wire [31:0] o_wb_ext_dat,
   output wire [3:0]  o_wb_ext_sel,
   output wire        o_wb_ext_we,
   output wire        o_wb_ext_stb,
   input wire [31:0]  i_wb_ext_rdt,
   input wire         i_wb_ext_ack);

   wire               ext = (i_wb_cpu_adr[31:30] != 2'b00);

   assign o_wb_cpu_rdt = ext ? i_wb_ext_rdt : i_wb_mem_rdt;
   assign o_wb_cpu_ack = ext ? i_wb_ext_ack : i_wb_mem_ack;

   assign o_wb_mem_adr = i_wb_cpu_adr;
   assign o_wb_mem_dat = i_wb_cpu_dat;
   assign o_wb_mem_sel = i_wb_cpu_sel;
   assign o_wb_mem_we  = i_wb_cpu_we;
   assign o_wb_mem_stb = i_wb_cpu_stb & !ext;

   assign o_wb_ext_adr = i_wb_cpu_adr;
   assign o_wb_ext_dat = i_wb_cpu_dat;
   assign o_wb_ext_sel = i_wb_cpu_sel;
   assign o_wb_ext_we  = i_wb_cpu_we;
   assign o_wb_ext_stb = i_wb_cpu_stb & ext;

endmodule
