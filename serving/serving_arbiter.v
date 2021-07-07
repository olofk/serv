/* serving_arbiter.v : I/D arbiter for the serving SoC
 *  Relies on the fact that not both masters are active at the same time
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

module serving_arbiter
  (
   input wire [31:0]  i_wb_cpu_dbus_adr,
   input wire [31:0]  i_wb_cpu_dbus_dat,
   input wire [3:0]   i_wb_cpu_dbus_sel,
   input wire         i_wb_cpu_dbus_we,
   input wire         i_wb_cpu_dbus_stb,
   output wire [31:0] o_wb_cpu_dbus_rdt,
   output wire        o_wb_cpu_dbus_ack,

   input wire [31:0]  i_wb_cpu_ibus_adr,
   input wire         i_wb_cpu_ibus_stb,
   output wire [31:0] o_wb_cpu_ibus_rdt,
   output wire        o_wb_cpu_ibus_ack,

   output wire [31:0] o_wb_mem_adr,
   output wire [31:0] o_wb_mem_dat,
   output wire [3:0]  o_wb_mem_sel,
   output wire        o_wb_mem_we,
   output wire        o_wb_mem_stb,
   input wire [31:0]  i_wb_mem_rdt,
   input wire         i_wb_mem_ack);

   assign o_wb_cpu_dbus_rdt = i_wb_mem_rdt;
   assign o_wb_cpu_dbus_ack = i_wb_mem_ack & !i_wb_cpu_ibus_stb;

   assign o_wb_cpu_ibus_rdt = i_wb_mem_rdt;
   assign o_wb_cpu_ibus_ack = i_wb_mem_ack & i_wb_cpu_ibus_stb;

   assign o_wb_mem_adr = i_wb_cpu_ibus_stb ? i_wb_cpu_ibus_adr : i_wb_cpu_dbus_adr;
   assign o_wb_mem_dat = i_wb_cpu_dbus_dat;
   assign o_wb_mem_sel = i_wb_cpu_dbus_sel;
   assign o_wb_mem_we  = i_wb_cpu_dbus_we & !i_wb_cpu_ibus_stb;
   assign o_wb_mem_stb = i_wb_cpu_ibus_stb | i_wb_cpu_dbus_stb;


endmodule
