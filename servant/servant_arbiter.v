module serv_arbiter
  (
   input wire 	      i_ibus_active,
   input wire [31:0]  i_wb_cpu_dbus_adr,
   input wire [31:0]  i_wb_cpu_dbus_dat,
   input wire [3:0]   i_wb_cpu_dbus_sel,
   input wire 	      i_wb_cpu_dbus_we,
   input wire 	      i_wb_cpu_dbus_cyc,
   output wire [31:0] o_wb_cpu_dbus_rdt,
   output wire 	      o_wb_cpu_dbus_ack,

   input wire [31:0]  i_wb_cpu_ibus_adr,
   input wire 	      i_wb_cpu_ibus_cyc,
   output wire [31:0] o_wb_cpu_ibus_rdt,
   output wire 	      o_wb_cpu_ibus_ack,

   output wire [31:0] o_wb_cpu_adr,
   output wire [31:0] o_wb_cpu_dat,
   output wire [3:0]  o_wb_cpu_sel,
   output wire 	      o_wb_cpu_we,
   output wire 	      o_wb_cpu_cyc,
   input wire [31:0]  i_wb_cpu_rdt,
   input wire 	      i_wb_cpu_ack);

   assign o_wb_cpu_dbus_rdt = i_wb_cpu_rdt;
   assign o_wb_cpu_dbus_ack = i_wb_cpu_ack & !i_ibus_active;

   assign o_wb_cpu_ibus_rdt = i_wb_cpu_rdt;
   assign o_wb_cpu_ibus_ack = i_wb_cpu_ack & i_ibus_active;

   assign o_wb_cpu_adr = i_ibus_active ? i_wb_cpu_ibus_adr : i_wb_cpu_dbus_adr;
   assign o_wb_cpu_dat = i_wb_cpu_dbus_dat;
   assign o_wb_cpu_sel = i_wb_cpu_dbus_sel;
   assign o_wb_cpu_we  = i_wb_cpu_dbus_we & !i_ibus_active;
   assign o_wb_cpu_cyc = i_ibus_active ? i_wb_cpu_ibus_cyc : i_wb_cpu_dbus_cyc;

endmodule
