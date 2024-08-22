/*
 * servile.v : Top-level for Servile, the SERV convenience wrapper
 *
 * SPDX-FileCopyrightText: 2024 Olof Kindgren <olof.kindgren@gmail.com>
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none
module servile
  #(
    parameter	    width = 1,
    parameter	    reset_pc = 32'h00000000,
    parameter	    reset_strategy = "MINI",
    parameter	    rf_width = 2*width,
    parameter [0:0] sim = 1'b0,
    parameter [0:0] debug = 1'b0,
    parameter [0:0] with_c = 1'b0,
    parameter [0:0] with_csr = 1'b0,
    parameter [0:0] with_mdu = 1'b0,
    //Internally calculated. Do not touch
    parameter	    B = width-1,
    parameter	    regs = 32+with_csr*4,
    parameter	    rf_l2d = $clog2(regs*32/rf_width))
  (
   input wire		      i_clk,
   input wire		      i_rst,
   input wire		      i_timer_irq,

   //Memory (WB) interface
   output wire [31:0]	      o_wb_mem_adr,
   output wire [31:0]	      o_wb_mem_dat,
   output wire [3:0]	      o_wb_mem_sel,
   output wire		      o_wb_mem_we ,
   output wire		      o_wb_mem_stb,
   input wire [31:0]	      i_wb_mem_rdt,
   input wire		      i_wb_mem_ack,

   //Extension (WB) interface
   output wire [31:0]	      o_wb_ext_adr,
   output wire [31:0]	      o_wb_ext_dat,
   output wire [3:0]	      o_wb_ext_sel,
   output wire		      o_wb_ext_we ,
   output wire		      o_wb_ext_stb,
   input wire [31:0]	      i_wb_ext_rdt,
   input wire		      i_wb_ext_ack,

   //RF (SRAM) interface
   output wire [rf_l2d-1:0]   o_rf_waddr,
   output wire [rf_width-1:0] o_rf_wdata,
   output wire		      o_rf_wen,
   output wire [rf_l2d-1:0]   o_rf_raddr,
   input wire [rf_width-1:0]  i_rf_rdata,
   output wire		      o_rf_ren);



   wire [31:0] 	wb_ibus_adr;
   wire 	wb_ibus_stb;
   wire [31:0] 	wb_ibus_rdt;
   wire 	wb_ibus_ack;

   wire [31:0] 	wb_dbus_adr;
   wire [31:0] 	wb_dbus_dat;
   wire [3:0] 	wb_dbus_sel;
   wire 	wb_dbus_we;
   wire 	wb_dbus_stb;
   wire [31:0] 	wb_dbus_rdt;
   wire 	wb_dbus_ack;

   wire [31:0] 	wb_dmem_adr;
   wire [31:0] 	wb_dmem_dat;
   wire [3:0] 	wb_dmem_sel;
   wire 	wb_dmem_we;
   wire 	wb_dmem_stb;
   wire [31:0] 	wb_dmem_rdt;
   wire 	wb_dmem_ack;

   wire 		   rf_wreq;
   wire 		   rf_rreq;
   wire [$clog2(regs)-1:0] wreg0;
   wire [$clog2(regs)-1:0] wreg1;
   wire 		   wen0;
   wire 		   wen1;
   wire [B:0]		   wdata0;
   wire [B:0]		   wdata1;
   wire [$clog2(regs)-1:0] rreg0;
   wire [$clog2(regs)-1:0] rreg1;
   wire 		   rf_ready;
   wire [B:0]		   rdata0;
   wire [B:0]		   rdata1;

   wire [31:0]		   mdu_rs1;
   wire [31:0]		   mdu_rs2;
   wire [ 2:0]		   mdu_op;
   wire			   mdu_valid;
   wire [31:0]		   mdu_rd;
   wire			   mdu_ready;

   servile_mux
     #(.sim (sim))
   mux
     (.i_clk        (i_clk),
      .i_rst        (i_rst & (reset_strategy != "NONE")),

      .i_wb_cpu_adr (wb_dbus_adr),
      .i_wb_cpu_dat (wb_dbus_dat),
      .i_wb_cpu_sel (wb_dbus_sel),
      .i_wb_cpu_we  (wb_dbus_we),
      .i_wb_cpu_stb (wb_dbus_stb),
      .o_wb_cpu_rdt (wb_dbus_rdt),
      .o_wb_cpu_ack (wb_dbus_ack),

      .o_wb_mem_adr (wb_dmem_adr),
      .o_wb_mem_dat (wb_dmem_dat),
      .o_wb_mem_sel (wb_dmem_sel),
      .o_wb_mem_we  (wb_dmem_we),
      .o_wb_mem_stb (wb_dmem_stb),
      .i_wb_mem_rdt (wb_dmem_rdt),
      .i_wb_mem_ack (wb_dmem_ack),

      .o_wb_ext_adr (o_wb_ext_adr),
      .o_wb_ext_dat (o_wb_ext_dat),
      .o_wb_ext_sel (o_wb_ext_sel),
      .o_wb_ext_we  (o_wb_ext_we),
      .o_wb_ext_stb (o_wb_ext_stb),
      .i_wb_ext_rdt (i_wb_ext_rdt),
      .i_wb_ext_ack (i_wb_ext_ack));

   servile_arbiter arbiter
     (.i_wb_cpu_dbus_adr (wb_dmem_adr),
      .i_wb_cpu_dbus_dat (wb_dmem_dat),
      .i_wb_cpu_dbus_sel (wb_dmem_sel),
      .i_wb_cpu_dbus_we  (wb_dmem_we ),
      .i_wb_cpu_dbus_stb (wb_dmem_stb),
      .o_wb_cpu_dbus_rdt (wb_dmem_rdt),
      .o_wb_cpu_dbus_ack (wb_dmem_ack),

      .i_wb_cpu_ibus_adr (wb_ibus_adr),
      .i_wb_cpu_ibus_stb (wb_ibus_stb),
      .o_wb_cpu_ibus_rdt (wb_ibus_rdt),
      .o_wb_cpu_ibus_ack (wb_ibus_ack),

      .o_wb_mem_adr (o_wb_mem_adr),
      .o_wb_mem_dat (o_wb_mem_dat),
      .o_wb_mem_sel (o_wb_mem_sel),
      .o_wb_mem_we  (o_wb_mem_we ),
      .o_wb_mem_stb (o_wb_mem_stb),
      .i_wb_mem_rdt (i_wb_mem_rdt),
      .i_wb_mem_ack (i_wb_mem_ack));



   serv_rf_ram_if
     #(.width    (rf_width),
       .W        (width),
       .reset_strategy (reset_strategy),
       .csr_regs (with_csr*4))
   rf_ram_if
     (.i_clk    (i_clk),
      .i_rst    (i_rst),
      //RF IF
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
      //SRAM IF
      .o_waddr  (o_rf_waddr),
      .o_wdata  (o_rf_wdata),
      .o_wen    (o_rf_wen),
      .o_raddr  (o_rf_raddr),
      .o_ren    (o_rf_ren),
      .i_rdata  (i_rf_rdata));

   generate
      if (with_mdu) begin : gen_mdu
	 mdu_top mdu_serv
	   (.i_clk       (i_clk),
	    .i_rst       (i_rst),
	    .i_mdu_rs1   (mdu_rs1),
	    .i_mdu_rs2   (mdu_rs2),
	    .i_mdu_op    (mdu_op),
	    .i_mdu_valid (mdu_valid),
	    .o_mdu_ready (mdu_ready),
	    .o_mdu_rd    (mdu_rd));
      end else begin
	 assign mdu_ready = 1'b0;
	 assign mdu_rd = 32'd0;
      end
   endgenerate

   serv_top
     #(
       .WITH_CSR       (with_csr?1:0),
       .W              (width),
       .PRE_REGISTER   (1'b1),
       .RESET_STRATEGY (reset_strategy),
       .RESET_PC       (reset_pc),
       .DEBUG          (debug),
       .MDU            (with_mdu),
       .COMPRESSED     (with_c))
   cpu
     (
      .clk         (i_clk),
      .i_rst       (i_rst),
      .i_timer_irq (i_timer_irq),

`ifdef RISCV_FORMAL
      .rvfi_valid     (),
      .rvfi_order     (),
      .rvfi_insn      (),
      .rvfi_trap      (),
      .rvfi_halt      (),
      .rvfi_intr      (),
      .rvfi_mode      (),
      .rvfi_ixl       (),
      .rvfi_rs1_addr  (),
      .rvfi_rs2_addr  (),
      .rvfi_rs1_rdata (),
      .rvfi_rs2_rdata (),
      .rvfi_rd_addr   (),
      .rvfi_rd_wdata  (),
      .rvfi_pc_rdata  (),
      .rvfi_pc_wdata  (),
      .rvfi_mem_addr  (),
      .rvfi_mem_rmask (),
      .rvfi_mem_wmask (),
      .rvfi_mem_rdata (),
      .rvfi_mem_wdata (),
`endif
      //RF IF
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

      //Instruction bus
      .o_ibus_adr  (wb_ibus_adr),
      .o_ibus_cyc  (wb_ibus_stb),
      .i_ibus_rdt  (wb_ibus_rdt),
      .i_ibus_ack  (wb_ibus_ack),

      //Data bus
      .o_dbus_adr  (wb_dbus_adr),
      .o_dbus_dat  (wb_dbus_dat),
      .o_dbus_sel  (wb_dbus_sel),
      .o_dbus_we   (wb_dbus_we),
      .o_dbus_cyc  (wb_dbus_stb),
      .i_dbus_rdt  (wb_dbus_rdt),
      .i_dbus_ack  (wb_dbus_ack),

      //Extension IF
      .o_ext_rs1    (mdu_rs1),
      .o_ext_rs2    (mdu_rs2),
      .o_ext_funct3 (mdu_op),
      .i_ext_rd     (mdu_rd),
      .i_ext_ready  (mdu_ready),
      //MDU
      .o_mdu_valid  (mdu_valid));

endmodule
`default_nettype wire
