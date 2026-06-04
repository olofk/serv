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

      wire [B:0]	      q;
      reg [31:0]	      data;

      // Clock for TLV-inferred flops (SandPiper uses a clock named `clk`).
      wire		      clk = i_clk;

      generate
         if (W == 1) begin : gen_w_eq_1
   	 always @(posedge i_clk) begin
   	    if (i_en)
   	      data[31:2] <= {i_init ? q : {W{data[31] & i_sh_signed}}, data[31:3]};

   	    if (i_init ? (i_cnt0 | i_cnt1) : i_en)
   	      data[1:0] <= {i_init ? q : data[2], data[1]};
   	 end
   	 assign o_lsb = (MDU & i_mdu_op) ? 2'b00 : data[1:0];
   	 assign o_q = data[0] & {W{i_en}};
         end else if (W == 4) begin : gen_lsb_w_4
   	 reg [1:0] lsb;
   	 reg [W-2:0] data_tail;

   	 wire [2:0] shift_amount
   	   = !i_shift_op ? 3'd3 :
   	     i_right_shift_op ? (3'd3+{1'b0,i_shamt[1:0]}) :
   	     ({1'b0,~i_shamt[1:0]});

   	 always @(posedge i_clk) begin
               if (i_en)
                 if (i_cnt0) lsb <= q[1:0];
   	    if (i_en)
                 data <= {i_init ? q : {W{i_sh_signed & data[31]}}, data[31:W]};
   	    if (i_en)
   	      data_tail <= data[B:1] & {B{~i_cnt_done}};
   	 end

   	 wire [2*W+B-2:0] muxdata = {data[W+B-1:0],data_tail};
   	 wire [B:0]	  muxout = muxdata[{1'b0,shift_amount}+:W];

   	 assign o_lsb = (MDU & i_mdu_op) ? 2'b00 : lsb;
   	 assign o_q = i_en ? muxout : {W{1'b0}};
         end
      endgenerate


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
   // Bridge q back to \SV (still consumed by the generate blocks).
   *q = $q;
   // Combinational outputs derived from the data register (still \SV).
   *o_dbus_adr = {*data[31:2], 2'b00};
   *o_ext_rs1 = *data;
\SV
   endmodule
