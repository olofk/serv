\TLV_version 1d: tl-x.org
\SV
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

\TLV
   |pipe
      @0
         $dat_valid = i_mdu_op | i_word | (i_bytecnt == 2'b00) | (i_half & !i_bytecnt[1]);
         $signbit[0:0] = $dat_valid ? i_bufreg2_q[B:B] : >>1$signbit;
         $o_rd[B:0] = $dat_valid ? i_bufreg2_q : {W{i_signed & >>1$signbit}};
         $o_wb_sel[3:0] = {(i_lsb == 2'b11) | i_word | (i_half & i_lsb[1]),
                           (i_lsb == 2'b10) | i_word,
                           (i_lsb == 2'b01) | i_word | (i_half & !i_lsb[1]),
                           (i_lsb == 2'b00)};
         $o_misalign = WITH_CSR & ((i_lsb[0] & (i_word | i_half)) | (i_lsb[1] & i_word));
         `BOGUS_USE($o_rd) `BOGUS_USE($o_wb_sel) `BOGUS_USE($o_misalign)

\SV
   endmodule
