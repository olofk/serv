module serv_rf_top
#(
    parameter RESET_PC = 32'd0,
    parameter RF_WIDTH = 8,
	parameter RF_L2D   = $clog2((32+4)*32/RF_WIDTH)
)
(
    input  wire 	    clk,
    input  wire 	    i_rst,
    // Interrupts
    input  wire 	    i_timer_irq,
    // Instruction bus
    output wire [31:0]  o_ibus_adr,
    output wire 	    o_ibus_cyc,
    input  wire [31:0]  i_ibus_rdt,
    input  wire 	    i_ibus_ack,
    // Data bus
    output wire [31:0]  o_dbus_adr,
    output wire [31:0]  o_dbus_dat,
    output wire [3:0]   o_dbus_sel,
    output wire 	    o_dbus_we ,
    output wire 	    o_dbus_cyc,
    input  wire [31:0]  i_dbus_rdt,
    input  wire 	    i_dbus_ack,
    // Debug signals
    input  wire         i_dbg_halt, // halt
    input  wire         i_dbg_reset,
    output wire         o_dbg_process // set whenever CPU in debug mode (halt, ebreak, step)  
);
   
    localparam CSR_REGS = 4;

    wire 	            rf_wreq;
    wire 	            rf_rreq;
    wire [5:0]          wreg0;
    wire [5:0]          wreg1;
    wire 	            wen0;
    wire 	            wen1;
    wire 	            wdata0;
    wire 	            wdata1;
    wire [5:0]          rreg0;
    wire [5:0]          rreg1;
    wire 	            rf_ready;
    wire 	            rdata0;
    wire 	            rdata1;

    wire [RF_L2D-1:0]   waddr;
    wire [RF_WIDTH-1:0] wdata;
    wire 	            wen;
    wire [RF_L2D-1:0]   raddr;
    wire 	            ren;
    wire [RF_WIDTH-1:0] rdata;

   serv_top #(
     .RESET_PC (RESET_PC)
   ) cpu (
      .clk         (clk         ),
      .i_rst       (i_rst       ),
      .i_timer_irq (i_timer_irq ),
      // RF Interface
      .o_rf_rreq   (rf_rreq     ), // read request
      .o_rf_wreq   (rf_wreq     ), // write request
      .i_rf_ready  (rf_ready    ), // register file ready
      .o_wreg0     (wreg0       ), 
      .o_wreg1     (wreg1       ),
      .o_wen0      (wen0        ), // write enable to register 0
      .o_wen1      (wen1        ), // write enable to register 1
      .o_wdata0    (wdata0      ), // write data to register 0 (1-bit)
      .o_wdata1    (wdata1      ), // write data to register 1 (1-bit)
      .o_rreg0     (rreg0       ), 
      .o_rreg1     (rreg1       ),
      .i_rdata0    (rdata0      ), // read data 0
      .i_rdata1    (rdata1      ), // read data 1
      // Insctruction bus  
      .o_ibus_adr  (o_ibus_adr  ),
      .o_ibus_cyc  (o_ibus_cyc  ),
      .i_ibus_rdt  (i_ibus_rdt  ),
      .i_ibus_ack  (i_ibus_ack  ),
      // Data bus
      .o_dbus_adr  (o_dbus_adr  ),
      .o_dbus_dat  (o_dbus_dat  ),
      .o_dbus_sel  (o_dbus_sel  ),
      .o_dbus_we   (o_dbus_we   ),
      .o_dbus_cyc  (o_dbus_cyc  ),
      .i_dbus_rdt  (i_dbus_rdt  ),
      .i_dbus_ack  (i_dbus_ack  ),
      // Debug interface
      .i_dbg_halt  (i_dbg_halt  ),
      .i_dbg_reset (i_dbg_reset ),
      .o_dbg_process(o_dbg_process )
    );

    serv_rf_ram_if #(
        .width          (RF_WIDTH       ),
        .csr_regs       (CSR_REGS       )
    ) rf_ram_if (
        // Global control
        .i_clk    (clk      ),
        .i_rst    (i_rst | i_dbg_reset   ),
        // SERV control signals
        .i_rreq   (rf_rreq  ),
        .i_wreq   (rf_wreq  ),
        .o_ready  (rf_ready ),
        .i_wreg0  (wreg0    ),
        .i_wreg1  (wreg1    ),
        .i_wen0   (wen0     ),
        .i_wen1   (wen1     ),
        .i_wdata0 (wdata0   ),
        .i_wdata1 (wdata1   ),
        .i_rreg0  (rreg0    ),
        .i_rreg1  (rreg1    ),
        .o_rdata0 (rdata0   ),
        .o_rdata1 (rdata1   ),
        // RAM side
        .o_waddr  (waddr    ),
        .o_wdata  (wdata    ),
        .o_wen    (wen      ),
        .o_raddr  (raddr    ),
        .o_ren    (ren      ),
        .i_rdata  (rdata    )
   );

   serv_rf_ram #(
      .width    (RF_WIDTH),
      .csr_regs (CSR_REGS)
   ) rf_ram (
      .i_clk   (clk     ),
      .i_rst   (i_rst | i_dbg_reset ),
      .i_waddr (waddr   ),
      .i_wdata (wdata   ),
      .i_wen   (wen     ),
      .i_raddr (raddr   ),
      .i_ren   (ren     ),
      .o_rdata (rdata   )
   );
    
endmodule
