/* serving.v : Top-level for the serving SoC
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
module serving
  (
   input wire 	      i_clk,
   input wire 	      i_rst,
   input wire 	      i_timer_irq,

   output wire [31:0] o_wb_adr,
   output wire [31:0] o_wb_dat,
   output wire [3:0]  o_wb_sel,
   output wire 	      o_wb_we ,
   output wire 	      o_wb_stb,
   input wire [31:0]  i_wb_rdt,
   input wire 	      i_wb_ack);

   parameter memfile = "";
   parameter memsize = 8192;
   parameter WITH_CSR = 1;
   localparam regs = 32+WITH_CSR*4;

   localparam rf_width = 8;

   localparam aw = $clog2(memsize);

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

   wire [31:0] 	wb_mem_adr;
   wire [31:0] 	wb_mem_dat;
   wire [3:0] 	wb_mem_sel;
   wire 	wb_mem_we;
   wire 	wb_mem_stb;
   wire [31:0] 	wb_mem_rdt;
   wire 	wb_mem_ack;

   wire [6+WITH_CSR:0] waddr;
   wire [rf_width-1:0] wdata;
   wire 	       wen;
   wire [6+WITH_CSR:0] raddr;
   wire [rf_width-1:0] rdata;


   wire [aw-1:0] rf_waddr = ~{{aw-2-5-WITH_CSR{1'b0}},waddr};
   wire [aw-1:0] rf_raddr = ~{{aw-2-5-WITH_CSR{1'b0}},raddr};

   serving_arbiter arbiter
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

      .o_wb_mem_adr (wb_mem_adr),
      .o_wb_mem_dat (wb_mem_dat),
      .o_wb_mem_sel (wb_mem_sel),
      .o_wb_mem_we  (wb_mem_we ),
      .o_wb_mem_stb (wb_mem_stb),
      .i_wb_mem_rdt (wb_mem_rdt),
      .i_wb_mem_ack (wb_mem_ack));

   serving_mux mux
     (.i_clk        (i_clk),
      .i_rst        (i_rst),

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

      .o_wb_ext_adr (o_wb_adr),
      .o_wb_ext_dat (o_wb_dat),
      .o_wb_ext_sel (o_wb_sel),
      .o_wb_ext_we  (o_wb_we),
      .o_wb_ext_stb (o_wb_stb),
      .i_wb_ext_rdt (i_wb_rdt),
      .i_wb_ext_ack (i_wb_ack));

   serving_ram
     #(.memfile (memfile),
       .depth   (memsize))
   ram
     (// Wishbone interface
      .i_clk (i_clk),
      .i_waddr  (rf_waddr),
      .i_wdata  (wdata),
      .i_wen    (wen),
      .i_raddr  (rf_raddr),
      .o_rdata  (rdata),
      .i_wb_adr (wb_mem_adr[$clog2(memsize)-1:2]),
      .i_wb_stb (wb_mem_stb),
      .i_wb_we  (wb_mem_we) ,
      .i_wb_sel (wb_mem_sel),
      .i_wb_dat (wb_mem_dat),
      .o_wb_rdt (wb_mem_rdt),
      .o_wb_ack (wb_mem_ack));

   localparam RF_L2W = $clog2(rf_width);

   wire 		   rf_wreq;
   wire 		   rf_rreq;
   wire [$clog2(regs)-1:0] wreg0;
   wire [$clog2(regs)-1:0] wreg1;
   wire 		   wen0;
   wire 		   wen1;
   wire 		   wdata0;
   wire 		   wdata1;
   wire [$clog2(regs)-1:0] rreg0;
   wire [$clog2(regs)-1:0] rreg1;
   wire 		   rf_ready;
   wire 		   rdata0;
   wire 		   rdata1;


   serv_rf_ram_if
     #(.width    (rf_width),
       .csr_regs (WITH_CSR*4))
   rf_ram_if
     (.i_clk    (i_clk),
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
      .o_waddr  (waddr),
      .o_wdata  (wdata),
      .o_wen    (wen),
      .o_raddr  (raddr),
      .i_rdata  (rdata));

   serv_top
     #(.RESET_PC (32'h0000_0000),
       .WITH_CSR (WITH_CSR))
   cpu
     (
      .clk         (i_clk),
      .i_rst       (i_rst),
      .i_timer_irq (i_timer_irq),
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
      .i_dbus_ack  (wb_dbus_ack));

endmodule
