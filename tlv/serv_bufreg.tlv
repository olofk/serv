\m5_TLV_version 1d: tl-x.org
\SV
   /*
    * serv_bufreg.v : SERV buffer register for load/store address and shift data
    *
    * SPDX-FileCopyrightText: 2019 Olof Kindgren <olof@award-winning.me>
    * SPDX-License-Identifier: ISC
    */
   module serv_bufreg #(
         parameter [0:0] MDU = 0,
         parameter W = 1,
         parameter B = W-1
   )(
      input wire 	      i_clk,
      //State
      input wire 	      i_cnt0,
      input wire 	      i_cnt1,
      input wire 	      i_cnt_done,
      input wire 	      i_en,
      input wire 	      i_init,
      input wire           i_mdu_op,
      output wire [1:0]    o_lsb,
      //Control
      input wire 	      i_rs1_en,
      input wire 	      i_imm_en,
      input wire 	      i_clr_lsb,
      input wire 	      i_shift_op,
      input wire 	      i_right_shift_op,
      input wire [2:0]   i_shamt,
      input wire 	      i_sh_signed,
      //Data
      input wire [B:0] i_rs1,
      input wire [B:0] i_imm,
      output wire [B:0] o_q,
      //External
      output wire [31:0] o_dbus_adr,
      //Extension
      output wire [31:0] o_ext_rs1);

      // Clock for TLV-inferred flops (SandPiper uses a clock named `clk`).
      wire		      clk = i_clk;

\TLV
   // clr_lsb: bit 0 = i_cnt0 & i_clr_lsb, upper bits 0 (explicit full width).
   $clr_lsb[B:0] = {{B{1'b0}}, *i_cnt0 & *i_clr_lsb};
   // Carry/sum adder: {c,q} = rs1 + imm(masked) + c_r.
   $carry_and_sum[W:0] =
        {1'b0,(*i_rs1 & {W{*i_rs1_en}})}
      + {1'b0,(*i_imm & {W{*i_imm_en}} & ~$clr_lsb)}
      + $c_r;
   $c = $carry_and_sum[W];
   $q[B:0] = $carry_and_sum[B:0];
   // Carry register: clear carry before loading new data, so only bit 0 holds
   // the registered (c & i_en); upper bits are 0.
   $cr_in = $c & *i_en;
   $c_r[B:0] = {{B{1'b0}}, >>1$cr_in};

   // W=1 datapath: lsb output is data[1:0]; q output is data[0] & i_en.
   $lsb_w_eq_1[1:0] = >>1$data[1:0];
   $qq_w_eq_1 = >>1$data[0] & *i_en;

   // W=4 shift amount (combinational).
   $shift_amount[2:0] = !*i_shift_op ? 3'd3 :
      *i_right_shift_op ? (3'd3 + {1'b0, *i_shamt[1:0]}) :
      {1'b0, ~*i_shamt[1:0]};

   // W=4 lsb register: capture q[1:0] when i_en & i_cnt0.
   // $carry_and_sum[1:0] == q[1:0] for W=4 (lower 2 bits of the adder).
   $lsb[1:0] = (*i_en & *i_cnt0) ? $carry_and_sum[1:0] : >>1$lsb[1:0];

   // W=4 data_tail register: data[B:1] masked by ~cnt_done, gated by i_en.
   // Fixed indices [3:1] equal data[B:1] for W=4 (B=3); produce valid Verilog for W=1.
   $data_tail[2:0] = *i_en ? (>>1$data[3:1] & {3{~*i_cnt_done}}) : >>1$data_tail[2:0];

   // W=4 mux inputs. Fixed index 6 == W+B-1 for W=4; $muxdata is 10 bits (2*W+B-1 for W=4).
   $muxdata[9:0] = {>>1$data[6:0], >>1$data_tail};
   // Right-shift extracts bits [pos+B:pos] into [B:0]; equivalent to [pos+:W].
   // (TLV does not support [{expr}+:W] subscript syntax.)
   // The shift yields 10 bits (muxdata's width); we only want the low W. An
   // explicit (W)'(...) size cast tells the lint pass the truncation is
   // intentional (no WIDTHTRUNC) without materializing a wider signal whose
   // upper bits would then lint as UNUSEDSIGNAL.
   // (Do not begin a comment line with the word "verilator" -- it is parsed as a
   // lint pragma; see BADVLTPRAGMA.)
   $muxout[B:0] = (W)'($muxdata >> {1'b0, $shift_amount});
   $qq_w_eq_4[B:0] = *i_en ? $muxout : {W{1'b0}};

   // W=1 next-state for data: separate enables for data[31:2] and data[1:0].
   // Uses $q[0] (always 1 bit) so concatenation widths are valid for all W.
   $data_w1[31:0] =
      {*i_en ? {*i_init ? $q[0] : *i_sh_signed & >>1$data[31], >>1$data[31:3]} : >>1$data[31:2],
       (*i_init ? (*i_cnt0 | *i_cnt1) : *i_en) ? {*i_init ? $q[0] : >>1$data[2], >>1$data[1]} : >>1$data[1:0]};

   // W=4 next-state for data: single i_en gate, shift right by W, parameter-width fill.
   $data_w4[31:0] =
      *i_en ? {*i_init ? $q[B:0] : {W{*i_sh_signed & >>1$data[31]}}, >>1$data[31:W]} :
      >>1$data;

   // Main data register: ternary selects the W-appropriate next-state.
   // Dead path is eliminated by synthesis/opt before FEV.
   $data[31:0] = (W == 1) ? $data_w1 : $data_w4;

   // Output selection.
   $o_lsb[1:0] = (*MDU & *i_mdu_op) ? 2'b00 : ((W == 1) ? $lsb_w_eq_1 : >>1$lsb);
   $o_q[B:0] = (W == 1) ? {{B{1'b0}}, $qq_w_eq_1} : $qq_w_eq_4;

   // Bridge outputs to \SV ports.
   *o_lsb = $o_lsb;
   *o_q = $o_q;
   *o_dbus_adr = {>>1$data[31:2], 2'b00};
   *o_ext_rs1 = >>1$data;
\SV
   endmodule
