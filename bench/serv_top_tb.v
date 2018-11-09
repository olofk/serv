`default_nettype none
module serv_top_tb;

   reg clk = 1'b1;
   reg wb_rst = 1'b1;

   reg [1023:0] firmware_file;

   wire         wb_clk = clk;

   always #5 clk <= !clk;
   initial #100 wb_rst = 1'b0;

`include "wb_intercon.vh"

   localparam MEMORY_SIZE = 16384*4;

   wb_ram
     #(.memfile ("firmware.hex"),
       .depth (MEMORY_SIZE))
   ram
     (// Wishbone interface
      .wb_clk_i (clk),
      .wb_rst_i (wb_rst),
      .wb_adr_i (wb_m2s_mem_adr[$clog2(MEMORY_SIZE)-1:0]),
      .wb_stb_i (wb_m2s_mem_stb),
      .wb_cyc_i (wb_m2s_mem_cyc),
      .wb_cti_i (wb_m2s_mem_cti),
      .wb_bte_i (wb_m2s_mem_bte),
      .wb_we_i  (wb_m2s_mem_we) ,
      .wb_sel_i (wb_m2s_mem_sel),
      .wb_dat_i (wb_m2s_mem_dat),
      .wb_dat_o (wb_s2m_mem_dat),
      .wb_ack_o (wb_s2m_mem_ack),
      .wb_err_o ());
   
   vlog_tb_utils vtu();

   testprint testprint
     (
      .i_wb_clk   (clk),
      .i_wb_dat   (wb_m2s_testprint_dat),
      .i_wb_we    (wb_m2s_testprint_we),
      .i_wb_cyc   (wb_m2s_testprint_cyc),
      .i_wb_stb   (wb_m2s_testprint_stb),
      .o_wb_ack   (wb_s2m_testprint_ack));

   serv_top
     #(.RESET_PC (32'd8))
   dut
     (
      .clk      (clk),
      .o_ibus_adr   (wb_m2s_cpu_ibus_adr),
      .o_ibus_cyc   (wb_m2s_cpu_ibus_cyc),
      .o_ibus_stb   (wb_m2s_cpu_ibus_stb),
      .i_ibus_rdt   (wb_s2m_cpu_ibus_dat),
      .i_ibus_ack   (wb_s2m_cpu_ibus_ack),
      .o_dbus_adr   (wb_m2s_cpu_dbus_adr),
      .o_dbus_dat   (wb_m2s_cpu_dbus_dat),
      .o_dbus_sel   (wb_m2s_cpu_dbus_sel),
      .o_dbus_we    (wb_m2s_cpu_dbus_we),
      .o_dbus_cyc   (wb_m2s_cpu_dbus_cyc),
      .o_dbus_stb   (wb_m2s_cpu_dbus_stb),
      .i_dbus_rdt   (wb_s2m_cpu_dbus_dat),
      .i_dbus_ack   (wb_s2m_cpu_dbus_ack));

   assign wb_m2s_cpu_ibus_dat = 32'd0;   
   assign wb_m2s_cpu_ibus_we = 1'b0;
   assign wb_m2s_cpu_ibus_sel = 4'b1111;
   assign wb_m2s_cpu_ibus_cti = 3'b000;
   assign wb_m2s_cpu_ibus_bte = 2'b00;
   
endmodule
