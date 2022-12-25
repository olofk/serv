`default_nettype none

module serv_synth_wrapper
  #(
    /* Register signals before or after the decoder
     0 : Register after the decoder. Faster but uses more resources
     1 : (default) Register before the decoder. Slower but uses less resources
     */
    parameter PRE_REGISTER = 1,
    /* Amount of reset applied to design
       "NONE" : No reset at all. Relies on a POR to set correct initialization
                 values and that core isn't reset during runtime
       "MINI" : Standard setting. Resets the minimal amount of FFs needed to
                 restart execution from the instruction at RESET_PC
     */
    parameter RESET_STRATEGY = "MINI",
    parameter WITH_CSR = 1,
    parameter RF_WIDTH = 2,
	parameter RF_L2D   = $clog2((32+(WITH_CSR*4))*32/RF_WIDTH))
  (
   input wire 		      clk,
   input wire 		      i_rst,
   input wire 		      i_timer_irq,
   output wire [31:0] 	      o_ibus_adr,
   output wire 		      o_ibus_cyc,
   input wire [31:0] 	      i_ibus_rdt,
   input wire 		      i_ibus_ack,
   output wire [31:0] 	      o_dbus_adr,
   output wire [31:0] 	      o_dbus_dat,
   output wire [3:0] 	      o_dbus_sel,
   output wire 		      o_dbus_we ,
   output wire 		      o_dbus_cyc,
   input wire [31:0] 	      i_dbus_rdt,
   input wire 		      i_dbus_ack,

   output wire [RF_L2D-1:0]   o_waddr,
   output wire [RF_WIDTH-1:0] o_wdata,
   output wire 		      o_wen,
   output wire [RF_L2D-1:0]   o_raddr,
   input wire [RF_WIDTH-1:0]  i_rdata);

   localparam CSR_REGS = WITH_CSR*4;

   wire 	      rf_wreq;
   wire 	      rf_rreq;
   wire [4+WITH_CSR:0] wreg0;
   wire [4+WITH_CSR:0] wreg1;
   wire 	      wen0;
   wire 	      wen1;
   wire 	      wdata0;
   wire 	      wdata1;
   wire [4+WITH_CSR:0] rreg0;
   wire [4+WITH_CSR:0] rreg1;
   wire 	      rf_ready;
   wire 	      rdata0;
   wire 	      rdata1;

   serv_rf_ram_if
     #(.width    (RF_WIDTH),
       .reset_strategy (RESET_STRATEGY),
       .csr_regs (CSR_REGS))
   rf_ram_if
     (.i_clk    (clk),
      .i_rst    (i_rst),
      .i_wreq   (rf_wreq),
      .i_rreq   (rf_rreq),
      .o_ready  (rf_ready),
      .i_wreg0  (wreg0),
      .i_wreg1  (wreg1),
      .i_wen0   (wen0),
      .i_wen1   (wen1),
      .i_wdata0 (wdata0),
      .i_wdata1 (wdata1),
      .i_rreg0  (rreg0),
      .i_rreg1  (rreg1),
      .o_rdata0 (rdata0),
      .o_rdata1 (rdata1),
      .o_waddr  (o_waddr),
      .o_wdata  (o_wdata),
      .o_wen    (o_wen),
      .o_raddr  (o_raddr),
      .i_rdata  (i_rdata));

   serv_top
     #(.RESET_PC (32'd0),
       .PRE_REGISTER (PRE_REGISTER),
       .RESET_STRATEGY (RESET_STRATEGY),
       .WITH_CSR (WITH_CSR),
       .MDU(1'b0))
   cpu
     (
      .clk      (clk),
      .i_rst    (i_rst),
      .i_timer_irq  (i_timer_irq),
      .o_rf_rreq   (rf_rreq),
      .o_rf_wreq   (rf_wreq),
      .i_rf_ready  (rf_ready),
      .o_wreg0     (wreg0),
      .o_wreg1     (wreg1),
      .o_wen0      (wen0),
      .o_wen1      (wen1),
      .o_wdata0    (wdata0),
      .o_wdata1    (wdata1),
      .o_rreg0     (rreg0),
      .o_rreg1     (rreg1),
      .i_rdata0    (rdata0),
      .i_rdata1    (rdata1),

      .o_ibus_adr   (o_ibus_adr),
      .o_ibus_cyc   (o_ibus_cyc),
      .i_ibus_rdt   (i_ibus_rdt),
      .i_ibus_ack   (i_ibus_ack),

      .o_dbus_adr   (o_dbus_adr),
      .o_dbus_dat   (o_dbus_dat),
      .o_dbus_sel   (o_dbus_sel),
      .o_dbus_we    (o_dbus_we),
      .o_dbus_cyc   (o_dbus_cyc),
      .i_dbus_rdt   (i_dbus_rdt),
      .i_dbus_ack   (i_dbus_ack),

      //Extension
      .o_ext_funct3 (),
      .i_ext_ready  (1'b0),
      .i_ext_rd     (32'd0),
      .o_ext_rs1    (),
      .o_ext_rs2    (),
      //MDU
      .o_mdu_valid  ());

endmodule
`default_nettype wire
