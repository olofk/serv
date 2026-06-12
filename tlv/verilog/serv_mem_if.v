   /*
    * serv_mem_if.v : SERV memory interface
    *
    * SPDX-FileCopyrightText: 2018 Olof Kindgren <olof@award-winning.me>
    * SPDX-License-Identifier: ISC
    */
   `default_nettype none
   module serv_mem_if
     #(
       parameter [0:0] WITH_CSR = 1,
       parameter       W = 1,
       parameter       B = W-1
     )
     (
      input wire       i_clk,
      //State
      input wire [1:0] i_bytecnt,
      input wire [1:0] i_lsb,
      output wire      o_misalign,
      //Control
      input wire       i_signed,
      input wire       i_word,
      input wire       i_half,
      //MDU
      input wire       i_mdu_op,
      //Data
      input wire [B:0] i_bufreg2_q,
      output wire [B:0] o_rd,
      //External interface
      output wire [3:0] o_wb_sel);

   wire clk = i_clk;

   assign o_rd       = PIPE_o_rd_a0;
   assign o_wb_sel   = PIPE_o_wb_sel_a0;
   assign o_misalign = PIPE_o_misalign_a0;

`include "serv_mem_if_gen.v" //_\TLV
   //_|pipe
      //_@0
         assign PIPE_dat_valid_a0 = i_mdu_op | i_word | (i_bytecnt == 2'b00) | (i_half & !i_bytecnt[1]);
         assign PIPE_signbit_a0[0:0] = PIPE_dat_valid_a0 ? i_bufreg2_q[B:B] : PIPE_signbit_a1;
         assign PIPE_o_rd_a0[B:0] = PIPE_dat_valid_a0 ? i_bufreg2_q : {W{i_signed & PIPE_signbit_a1}};
         assign PIPE_o_wb_sel_a0[3:0] = {(i_lsb == 2'b11) | i_word | (i_half & i_lsb[1]),
                           (i_lsb == 2'b10) | i_word,
                           (i_lsb == 2'b01) | i_word | (i_half & !i_lsb[1]),
                           (i_lsb == 2'b00)};
         assign PIPE_o_misalign_a0 = WITH_CSR & ((i_lsb[0] & (i_word | i_half)) | (i_lsb[1] & i_word));
         `BOGUS_USE(PIPE_o_rd_a0) `BOGUS_USE(PIPE_o_wb_sel_a0) `BOGUS_USE(PIPE_o_misalign_a0)

   endmodule


// Undefine macros defined by SandPiper (in "serv_mem_if_gen.v").
`undef BOGUS_USE
