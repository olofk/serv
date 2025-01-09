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
   parameter sim = 1'b0;
   parameter RESET_STRATEGY = "NONE";
   parameter WITH_CSR = 1;
   localparam regs = 32+WITH_CSR*4;

   localparam rf_width = 8;

   wire [31:0] 	wb_mem_adr;
   wire [31:0] 	wb_mem_dat;
   wire [3:0] 	wb_mem_sel;
   wire 	wb_mem_we;
   wire 	wb_mem_stb;
   wire [31:0] 	wb_mem_rdt;
   wire 	wb_mem_ack;

   wire [6+WITH_CSR:0] rf_waddr;
   wire [rf_width-1:0] rf_wdata;
   wire 	       rf_wen;
   wire [6+WITH_CSR:0] rf_raddr;
   wire [rf_width-1:0] rf_rdata;
   wire		       rf_ren;

   wire [$clog2(memsize)-1:0] sram_waddr;
   wire [rf_width-1:0] sram_wdata;
   wire 	       sram_wen;
   wire [$clog2(memsize)-1:0] sram_raddr;
   wire [rf_width-1:0] sram_rdata;
   wire		       sram_ren;

   serving_ram
     #(.memfile (memfile),
       .depth   (memsize))
   ram
     (// Wishbone interface
      .i_clk (i_clk),
      .i_waddr  (sram_waddr),
      .i_wdata  (sram_wdata),
      .i_wen    (sram_wen),
      .i_raddr  (sram_raddr),
      .o_rdata  (sram_rdata)/*,
      .i_ren    (rf_ren)*/);

   servile_rf_mem_if
     #(.depth   (memsize),
       .rf_regs (regs))
   rf_mem_if
     (// Wishbone interface
      .i_clk (i_clk),
      .i_rst (i_rst),

      .i_waddr  (rf_waddr),
      .i_wdata  (rf_wdata),
      .i_wen    (rf_wen),
      .i_raddr  (rf_raddr),
      .o_rdata  (rf_rdata),
      .i_ren    (rf_ren),

      .o_sram_waddr (sram_waddr),
      .o_sram_wdata (sram_wdata),
      .o_sram_wen   (sram_wen),
      .o_sram_raddr (sram_raddr),
      .i_sram_rdata (sram_rdata),
      .o_sram_ren   (sram_ren),

      .i_wb_adr (wb_mem_adr[$clog2(memsize)-1:2]),
      .i_wb_stb (wb_mem_stb),
      .i_wb_we  (wb_mem_we) ,
      .i_wb_sel (wb_mem_sel),
      .i_wb_dat (wb_mem_dat),
      .o_wb_rdt (wb_mem_rdt),
      .o_wb_ack (wb_mem_ack));

   servile
     #(.reset_pc (32'h0000_0000),
       .reset_strategy (RESET_STRATEGY),
       .rf_width (rf_width),
       .sim (sim),
       .with_csr (WITH_CSR))
   servile
     (
      .i_clk       (i_clk),
      .i_rst       (i_rst),
      .i_timer_irq (i_timer_irq),
      //Memory interface
      .o_wb_mem_adr   (wb_mem_adr),
      .o_wb_mem_dat   (wb_mem_dat),
      .o_wb_mem_sel   (wb_mem_sel),
      .o_wb_mem_we    (wb_mem_we),
      .o_wb_mem_stb   (wb_mem_stb),
      .i_wb_mem_rdt   (wb_mem_rdt),
      .i_wb_mem_ack   (wb_mem_ack),

      //Extension interface
      .o_wb_ext_adr   (o_wb_adr),
      .o_wb_ext_dat   (o_wb_dat),
      .o_wb_ext_sel   (o_wb_sel),
      .o_wb_ext_we    (o_wb_we),
      .o_wb_ext_stb   (o_wb_stb),
      .i_wb_ext_rdt   (i_wb_rdt),
      .i_wb_ext_ack   (i_wb_ack),

      //RF IF
      .o_rf_waddr  (rf_waddr),
      .o_rf_wdata  (rf_wdata),
      .o_rf_wen    (rf_wen),
      .o_rf_raddr  (rf_raddr),
      .o_rf_ren    (rf_ren),
      .i_rf_rdata  (rf_rdata));


endmodule
