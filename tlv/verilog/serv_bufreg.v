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

`include "serv_bufreg_gen.v" //_\TLV
   // clr_lsb: bit 0 = i_cnt0 & i_clr_lsb, upper bits 0 (explicit full width).
   assign L0_clr_lsb_a0[B:0] = {{B{1'b0}}, i_cnt0 & i_clr_lsb};
   // Carry/sum adder: {c,q} = rs1 + imm(masked) + c_r.
   assign L0_carry_and_sum_a0[W:0] =
        {1'b0,(i_rs1 & {W{i_rs1_en}})}
      + {1'b0,(i_imm & {W{i_imm_en}} & ~L0_clr_lsb_a0)}
      + L0_c_r_a0;
   assign L0_c_a0 = L0_carry_and_sum_a0[W];
   assign L0_q_a0[B:0] = L0_carry_and_sum_a0[B:0];
   // Carry register: clear carry before loading new data, so only bit 0 holds
   // the registered (c & i_en); upper bits are 0.
   assign L0_cr_in_a0 = L0_c_a0 & i_en;
   assign L0_c_r_a0[B:0] = {{B{1'b0}}, L0_cr_in_a1};

   // W=1 datapath: lsb output is data[1:0]; q output is data[0] & i_en.
   assign L0_lsb_w_eq_1_a0[1:0] = L0_data_a1[1:0];
   assign L0_qq_w_eq_1_a0 = L0_data_a1[0] & i_en;

   // W=4 shift amount (combinational).
   assign L0_shift_amount_a0[2:0] = !i_shift_op ? 3'd3 :
      i_right_shift_op ? (3'd3 + {1'b0, i_shamt[1:0]}) :
      {1'b0, ~i_shamt[1:0]};

   // W=4 lsb register: capture q[1:0] when i_en & i_cnt0.
   // $carry_and_sum[1:0] == q[1:0] for W=4 (lower 2 bits of the adder).
   assign L0_lsb_a0[1:0] = (i_en & i_cnt0) ? L0_carry_and_sum_a0[1:0] : L0_lsb_a1[1:0];

   // W=4 data_tail register: data[B:1] masked by ~cnt_done, gated by i_en.
   // Fixed indices [3:1] equal data[B:1] for W=4 (B=3); produce valid Verilog for W=1.
   assign L0_data_tail_a0[2:0] = i_en ? (L0_data_a1[3:1] & {3{~i_cnt_done}}) : L0_data_tail_a1[2:0];

   // W=4 mux inputs. Fixed index 6 == W+B-1 for W=4; $muxdata is 10 bits (2*W+B-1 for W=4).
   assign L0_muxdata_a0[9:0] = {L0_data_a1[6:0], L0_data_tail_a1};
   // Right-shift extracts bits [pos+B:pos] into [B:0]; equivalent to [pos+:W].
   // (TLV does not support [{expr}+:W] subscript syntax.)
   // The shift yields 10 bits (muxdata's width); we only want the low W. An
   // explicit (W)'(...) size cast tells the lint pass the truncation is
   // intentional (no WIDTHTRUNC) without materializing a wider signal whose
   // upper bits would then lint as UNUSEDSIGNAL.
   // (Do not begin a comment line with the word "verilator" -- it is parsed as a
   // lint pragma; see BADVLTPRAGMA.)
   assign L0_muxout_a0[B:0] = (W)'(L0_muxdata_a0 >> {1'b0, L0_shift_amount_a0});
   assign L0_qq_w_eq_4_a0[B:0] = i_en ? L0_muxout_a0 : {W{1'b0}};

   // W=1 next-state for data: separate enables for data[31:2] and data[1:0].
   // Uses $q[0] (always 1 bit) so concatenation widths are valid for all W.
   assign L0_data_w1_a0[31:0] =
      {i_en ? {i_init ? L0_q_a0[0] : i_sh_signed & L0_data_a1[31], L0_data_a1[31:3]} : L0_data_a1[31:2],
       (i_init ? (i_cnt0 | i_cnt1) : i_en) ? {i_init ? L0_q_a0[0] : L0_data_a1[2], L0_data_a1[1]} : L0_data_a1[1:0]};

   // W=4 next-state for data: single i_en gate, shift right by W, parameter-width fill.
   assign L0_data_w4_a0[31:0] =
      i_en ? {i_init ? L0_q_a0[B:0] : {W{i_sh_signed & L0_data_a1[31]}}, L0_data_a1[31:W]} :
      L0_data_a1;

   // Main data register: ternary selects the W-appropriate next-state.
   // Dead path is eliminated by synthesis/opt before FEV.
   assign L0_data_a0[31:0] = (W == 1) ? L0_data_w1_a0 : L0_data_w4_a0;

   // Output selection.
   assign L0_o_lsb_a0[1:0] = (MDU & i_mdu_op) ? 2'b00 : ((W == 1) ? L0_lsb_w_eq_1_a0 : L0_lsb_a1);
   assign L0_o_q_a0[B:0] = (W == 1) ? {{B{1'b0}}, L0_qq_w_eq_1_a0} : L0_qq_w_eq_4_a0;

   // Bridge outputs to \SV ports.
   assign o_lsb = L0_o_lsb_a0;
   assign o_q = L0_o_q_a0;
   assign o_dbus_adr = {L0_data_a1[31:2], 2'b00};
   assign o_ext_rs1 = L0_data_a1;
   endmodule


// Undefine macros defined by SandPiper (in "serv_bufreg_gen.v").
`undef BOGUS_USE
