/*
 * servile_arbiter.v : I/D arbiter for the servile convenience wrapper.
 *  Relies on the fact that not ibus and dbus are active at the same time.
 *
 * SPDX-FileCopyrightText: 2024 Olof Kindgren <olof.kindgren@gmail.com>
 * SPDX-License-Identifier: Apache-2.0
 */

module servile_arbiter
  (
   input wire [31:0]  i_wb_cpu_dbus_adr,
   input wire [31:0]  i_wb_cpu_dbus_dat,
   input wire [3:0]   i_wb_cpu_dbus_sel,
   input wire 	      i_wb_cpu_dbus_we,
   input wire 	      i_wb_cpu_dbus_stb,
   output wire [31:0] o_wb_cpu_dbus_rdt,
   output wire 	      o_wb_cpu_dbus_ack,

   input wire [31:0]  i_wb_cpu_ibus_adr,
   input wire 	      i_wb_cpu_ibus_stb,
   output wire [31:0] o_wb_cpu_ibus_rdt,
   output wire 	      o_wb_cpu_ibus_ack,

   output wire [31:0] o_wb_mem_adr,
   output wire [31:0] o_wb_mem_dat,
   output wire [3:0]  o_wb_mem_sel,
   output wire 	      o_wb_mem_we,
   output wire 	      o_wb_mem_stb,
   input wire [31:0]  i_wb_mem_rdt,
   input wire 	      i_wb_mem_ack);

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
