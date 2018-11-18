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

module wb_ram
 #(//Wishbone parameters
   parameter dw = 32,
   //Memory parameters
   parameter depth = 256,
   parameter aw    = $clog2(depth),
   parameter memfile = "")
  (input 	   wb_clk_i,
   input 	   wb_rst_i,

   input [aw-1:0]  wb_adr_i,
   input [dw-1:0]  wb_dat_i,
   input [3:0] 	   wb_sel_i,
   input 	   wb_we_i,
   input [1:0] 	   wb_bte_i,
   input [2:0] 	   wb_cti_i,
   input 	   wb_cyc_i,
   input 	   wb_stb_i,

   output reg 	   wb_ack_o = 1'b0,
   output 	   wb_err_o,
   output [dw-1:0] wb_dat_o);

   wire [31:0]     wb_rdt;
   reg [31:0]      wb_rdt_r;
   
   always@(posedge wb_clk_i) begin
      //Ack generation
      wb_ack_o <= wb_cyc_i & wb_stb_i & !wb_ack_o;

      if (wb_cyc_i & wb_stb_i)
        wb_rdt_r <= wb_rdt;
      if (wb_rst_i)
        wb_ack_o <= 1'b0;
   end

   assign wb_dat_o = (wb_cyc_i & wb_stb_i) ? wb_rdt : wb_rdt_r;

   wire ram_we = wb_we_i & wb_cyc_i & wb_stb_i & wb_ack_o;

   //TODO:ck for burst address errors
   assign wb_err_o =  1'b0;

   wb_ram_generic
     #(.depth(depth/4),
       .memfile (memfile))
   ram0
     (.clk (wb_clk_i),
      .we  ({4{ram_we}} & wb_sel_i),
      .din (wb_dat_i),
      .waddr(wb_adr_i[aw-1:2]),
      .raddr (wb_adr_i[aw-1:2]),
      .dout (wb_rdt));

endmodule
