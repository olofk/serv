/*
 * Copyright (c) 2014, 2016 Olof Kindgren <olof.kindgren@gmail.com>
 * All rights reserved.
 *
 * Redistribution and use in source and non-source forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in non-source form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *
 * THIS WORK IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * WORK, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

module wb_ram_tb;

   localparam MEMORY_SIZE = 1024;

   vlog_tb_utils vlog_tb_utils0();
   vlog_tap_generator #("wb_ram.tap", 1) vtg();


   reg	   wb_clk = 1'b1;
   reg	   wb_rst = 1'b1;

   always #5 wb_clk <= ~wb_clk;
   initial  #100 wb_rst <= 1'b0;

   wire    done;

   wire [31:0] wb_adr;
   wire [31:0] wb_dat;
   wire [3:0]  wb_sel;
   wire        wb_we;
   wire        wb_cyc;
   wire        wb_stb;
   wire [2:0]  wb_cti;
   wire [1:0]  wb_bte;
   wire [31:0] wb_rdt;
   wire        wb_ack;

   wb_bfm_transactor
     #(.MEM_HIGH (MEMORY_SIZE-1),
       .AUTORUN (0),
       .VERBOSE (0))
   master
     (.wb_clk_i (wb_clk),
      .wb_rst_i (wb_rst),
      .wb_adr_o (wb_adr),
      .wb_dat_o (wb_dat),
      .wb_sel_o (wb_sel),
      .wb_we_o  (wb_we ),
      .wb_cyc_o (wb_cyc),
      .wb_stb_o (wb_stb),
      .wb_cti_o (wb_cti),
      .wb_bte_o (wb_bte),
      .wb_dat_i (wb_rdt),
      .wb_ack_i (wb_ack),
      .wb_err_i (1'b0),
      .wb_rty_i (1'b0),
      //Test Control
      .done     (done));

   wb_ram
     #(.depth (MEMORY_SIZE))
   dut
     (// Wishbone interface
      .wb_clk_i (wb_clk),
      .wb_rst_i (wb_rst),
      .wb_adr_i (wb_adr[$clog2(MEMORY_SIZE)-1:0]),
      .wb_stb_i (wb_stb),
      .wb_cyc_i (wb_cyc),
      .wb_cti_i (wb_cti),
      .wb_bte_i (wb_bte),
      .wb_we_i  (wb_we) ,
      .wb_sel_i (wb_sel),
      .wb_dat_i (wb_dat),
      .wb_dat_o (wb_rdt),
      .wb_ack_o (wb_ack),
      .wb_err_o ());

   integer 	 TRANSACTIONS;
   integer 	 SUBTRANSACTIONS;
   integer 	 SEED;

   initial begin
      //Grab CLI parameters
      if($value$plusargs("transactions=%d", TRANSACTIONS))
	master.set_transactions(TRANSACTIONS);
      if($value$plusargs("subtransactions=%d", SUBTRANSACTIONS))
	master.set_subtransactions(SUBTRANSACTIONS);
      if($value$plusargs("seed=%d", SEED))
	master.SEED = SEED;

      master.display_settings;
      master.run;
      master.display_stats;
   end

   always @(posedge done) begin
      vtg.ok("All tests complete");
      $display("All tests complete");
      $finish;
   end

endmodule
