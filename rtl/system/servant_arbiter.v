/* Arbitrates between dbus and ibus accesses.
 * Relies on the fact that not both masters are active at the same time
 */
module servant_arbiter
  (
   // From CPU (MUX)
   input wire [31:0]  i_wb_cpu_dbus_adr,
   input wire [31:0]  i_wb_cpu_dbus_dat,
   input wire [3:0]   i_wb_cpu_dbus_sel,
   input wire 	      i_wb_cpu_dbus_we,
   input wire 	      i_wb_cpu_dbus_cyc,
   output wire [31:0] o_wb_cpu_dbus_rdt,
   output wire 	      o_wb_cpu_dbus_ack,
   // From CPU (Mux)
   input wire [31:0]  i_wb_cpu_ibus_adr,
   input wire 	      i_wb_cpu_ibus_cyc,
   output wire [31:0] o_wb_cpu_ibus_rdt,
   output wire 	      o_wb_cpu_ibus_ack,
   // To debug module
   output wire [31:0] o_wb_dm_adr,
   output wire [31:0] o_wb_dm_dat,
   output wire [3:0]  o_wb_dm_sel,
   output wire        o_wb_dm_we,
   output wire        o_wb_dm_cyc,
   input  wire [31:0] i_wb_dm_rdt,
   input  wire        i_wb_dm_ack, 
   // To memory
   output wire [31:0] o_wb_cpu_adr,
   output wire [31:0] o_wb_cpu_dat,
   output wire [3:0]  o_wb_cpu_sel,
   output wire 	      o_wb_cpu_we,
   output wire 	      o_wb_cpu_cyc,
   input wire [31:0]  i_wb_cpu_rdt,
   input wire 	      i_wb_cpu_ack
);
 
   wire dm_sel = (i_wb_cpu_ibus_cyc && (&i_wb_cpu_ibus_adr[29:16])) ||
                 (i_wb_cpu_dbus_cyc && (&i_wb_cpu_dbus_adr[29:16]));
   wire mem_sel = !dm_sel;
   
   assign o_wb_cpu_dbus_rdt = i_wb_dm_ack? i_wb_dm_rdt: i_wb_cpu_rdt;
   assign o_wb_cpu_dbus_ack = (i_wb_cpu_ack & !i_wb_cpu_ibus_cyc) ||
                              (i_wb_dm_ack  & !i_wb_cpu_ibus_cyc);

   assign o_wb_cpu_ibus_rdt = i_wb_dm_ack? i_wb_dm_rdt: i_wb_cpu_rdt;
   assign o_wb_cpu_ibus_ack = (i_wb_cpu_ack & i_wb_cpu_ibus_cyc) ||
                              (i_wb_dm_ack  & i_wb_cpu_ibus_cyc);

   assign o_wb_cpu_adr = i_wb_cpu_ibus_cyc ? i_wb_cpu_ibus_adr : i_wb_cpu_dbus_adr;
   assign o_wb_cpu_dat = i_wb_cpu_dbus_dat;
   assign o_wb_cpu_sel = i_wb_cpu_dbus_sel;
   assign o_wb_cpu_we  = i_wb_cpu_dbus_we & !i_wb_cpu_ibus_cyc;
   assign o_wb_cpu_cyc = (i_wb_cpu_ibus_cyc | i_wb_cpu_dbus_cyc) & mem_sel;

   assign o_wb_dm_adr = i_wb_cpu_ibus_cyc ? i_wb_cpu_ibus_adr : i_wb_cpu_dbus_adr;
   assign o_wb_dm_dat = i_wb_cpu_dbus_dat;
   assign o_wb_dm_sel = i_wb_cpu_dbus_sel;
   assign o_wb_dm_we  = i_wb_cpu_dbus_we & !i_wb_cpu_ibus_cyc;
   assign o_wb_dm_cyc = (i_wb_cpu_ibus_cyc | i_wb_cpu_dbus_cyc) & dm_sel; 
    
endmodule
