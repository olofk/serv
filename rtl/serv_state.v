module serv_state
  #(parameter RESET_STRATEGY = "MINI",
    parameter [0:0] WITH_CSR = 1,
    parameter [0:0] ALIGN =0,
    parameter [0:0] MDU = 0,
    parameter       W = 1
  )
  (
   input wire 	     i_clk,
   input wire 	     i_rst,
   //State
   input wire 	     i_new_irq,
   input wire 	     i_alu_cmp,
   output wire 	     o_init,
   output wire	     o_cnt_en,
   output wire 	     o_cnt0to3,
   output wire 	     o_cnt12to15,
   output wire 	     o_cnt16to31,
   output wire 	     o_cnt0,
   output wire 	     o_cnt1,
   output wire 	     o_cnt2,
   output wire 	     o_cnt3,
   output wire 	     o_cnt7,
   output wire 	     o_cnt11,
   output wire 	     o_cnt12,
   output wire 	     o_cnt_done,
   output wire 	     o_bufreg_en,
   output wire 	     o_ctrl_pc_en,
   output reg 	     o_ctrl_jump,
   output wire 	     o_ctrl_trap,
   input wire 	     i_ctrl_misalign,
   input wire 	     i_sh_done,
   output wire [1:0] o_mem_bytecnt,
   input wire 	     i_mem_misalign,
   //Control
   input wire 	     i_bne_or_bge,
   input wire 	     i_cond_branch,
   input wire 	     i_dbus_en,
   input wire 	     i_two_stage_op,
   input wire 	     i_branch_op,
   input wire 	     i_shift_op,
   input wire 	     i_sh_right,
   input wire 	     i_alu_rd_sel1,
   input wire 	     i_rd_alu_en,
   input wire 	     i_e_op,
   input wire 	     i_rd_op,
   //MDU
   input wire 	     i_mdu_op,
   output wire 	     o_mdu_valid,
   //Extension
   input wire 	     i_mdu_ready,
   //External
   output wire 	     o_dbus_cyc,
   input wire 	     i_dbus_ack,
   output wire 	     o_ibus_cyc,
   input wire 	     i_ibus_ack,
   //RF Interface
   output wire 	     o_rf_rreq,
   output wire 	     o_rf_wreq,
   input wire 	     i_rf_ready,
   output wire 	     o_rf_rd_en);

   reg 	init_done;
   wire misalign_trap_sync;

   reg [4:2] o_cnt;
   wire [3:0] cnt_r;

   reg 	     ibus_cyc;
   //Update PC in RUN or TRAP states
   assign o_ctrl_pc_en  = o_cnt_en & !o_init;

   assign o_mem_bytecnt = o_cnt[4:3];

   assign o_cnt0to3   = (o_cnt[4:2] == 3'd0);
   assign o_cnt16to31 = o_cnt[4];
   assign o_cnt0 = (o_cnt[4:2] == 3'd0) & cnt_r[0];
   assign o_cnt1 = (o_cnt[4:2] == 3'd0) & cnt_r[1];
   assign o_cnt2 = (o_cnt[4:2] == 3'd0) & cnt_r[2];
   assign o_cnt3 = (o_cnt[4:2] == 3'd0) & cnt_r[3];
   assign o_cnt11 = (o_cnt[4:2] == 3'd2) & cnt_r[3];

   generate
      if (W == 8) begin : gen_cnt_w_8
	 assign o_cnt12to15 = (o_cnt[4:3] == 2'b01);
	 assign o_cnt7 = o_cnt0 & o_cnt_en;
	 assign o_cnt12 = o_cnt11;
	 assign o_cnt_done = (o_cnt[4:3] == 2'b11) & cnt_r[3];
      end else begin : gen_cnt_w_lt_8
	 assign o_cnt12to15 = (o_cnt[4:2] == 3'b011);
	 assign o_cnt7 = (o_cnt[4:2] == 3'd1) & cnt_r[3];
	 assign o_cnt12 = (o_cnt[4:2] == 3'd3) & cnt_r[0];
	 assign o_cnt_done = (o_cnt[4:2] == 3'b111) & cnt_r[3];
      end
   endgenerate

   //Take branch for jump or branch instructions (opcode == 1x0xx) if
   //a) It's an unconditional branch (opcode[0] == 1)
   //b) It's a conditional branch (opcode[0] == 0) of type beq,blt,bltu (funct3[0] == 0) and ALU compare is true
   //c) It's a conditional branch (opcode[0] == 0) of type bne,bge,bgeu (funct3[0] == 1) and ALU compare is false
   //Only valid during the last cycle of INIT, when the branch condition has
   //been calculated.
   wire      take_branch = i_branch_op & (!i_cond_branch | (i_alu_cmp^i_bne_or_bge));

   wire last_init = o_cnt_done & o_init;

   //valid signal for mdu
   assign o_mdu_valid = MDU & !o_cnt_en & init_done & i_mdu_op;

   //Prepare RF for writes when everything is ready to enter stage two
   // and the first stage didn't cause a misalign exception
   //Left shifts, SLT & Branch ops. First cycle after init
   //Right shift. o_sh_done
   //Mem ops. i_dbus_ack
   //MDU ops. i_mdu_ready
   assign o_rf_wreq = (i_shift_op & (i_sh_right ? (i_sh_done & (last_init | !o_cnt_en & init_done)) : last_init)) |
	   	       i_dbus_ack | (MDU & i_mdu_ready) |
	   	      (i_branch_op & (last_init & !trap_pending)) |
	   	      (i_rd_alu_en & i_alu_rd_sel1 & last_init);

   assign o_dbus_cyc = !o_cnt_en & init_done & i_dbus_en & !i_mem_misalign;

   //Prepare RF for reads when a new instruction is fetched
   // or when stage one caused an exception (rreq implies a write request too)
   assign o_rf_rreq = i_ibus_ack | (trap_pending & last_init);

   assign o_rf_rd_en = i_rd_op & !o_init;

   /*
    bufreg is used during mem, branch, and shift operations

    mem : bufreg is used for dbus address. Shift in data during phase 1.
          Shift out during phase 2 if there was a misalignment exception.

    branch : Shift in during phase 1. Shift out during phase 2

    shift : Shift in during phase 1. Continue shifting between phases (except
            for the first cycle after init). Shift out during phase 2
    */
   
   assign o_bufreg_en = (o_cnt_en & (o_init | ((o_ctrl_trap | i_branch_op) & i_two_stage_op))) | (i_shift_op & init_done & (i_sh_right | i_sh_done));

   assign o_ibus_cyc = ibus_cyc & !i_rst;

   assign o_init = i_two_stage_op & !i_new_irq & !init_done;

   always @(posedge i_clk) begin
      //ibus_cyc changes on three conditions.
      //1. i_rst is asserted. Together with the async gating above, o_ibus_cyc
      //   will be asserted as soon as the reset is released. This is how the
      //   first instruction is fetched
      //2. o_cnt_done and o_ctrl_pc_en are asserted. This means that SERV just
      //   finished updating the PC, is done with the current instruction and
      //   o_ibus_cyc gets asserted to fetch a new instruction
      //3. When i_ibus_ack, a new instruction is fetched and o_ibus_cyc gets
      //   deasserted to finish the transaction
      if (i_ibus_ack | o_cnt_done | i_rst)
	ibus_cyc <= o_ctrl_pc_en | i_rst;

      if (o_cnt_done) begin
	 init_done <= o_init & !init_done;
	 o_ctrl_jump <= o_init & take_branch;
      end

      if (i_rst) begin
	 if (RESET_STRATEGY != "NONE") begin
	    init_done <= 1'b0;
	    o_ctrl_jump <= 1'b0;
	 end
      end
   end

   generate
      /*
       Because SERV is 32-bit bit-serial we need a counter than can count 0-31
       to keep track of which bit we are currently processing. o_cnt and cnt_r
       are used together to create such a counter.
       The top three bits (o_cnt) are implemented as a normal counter, but
       instead of the two LSB, cnt_r is a 4-bit shift register which loops 0-3
       When cnt_r[3] is 1, o_cnt will be increased.

       The counting starts when the core is idle and the i_rf_ready signal
       comes in from the RF module by shifting in the i_rf_ready bit as LSB of
       the shift register. Counting is stopped by using o_cnt_done to block the
       bit that was supposed to be shifted into bit 0 of cnt_r.

       There are two benefit of doing the counter this way
       1. We only need to check four bits instead of five when we want to check
       if the counter is at a certain value. For 4-LUT architectures this means
       we only need one LUT instead of two for each comparison.
       2. We don't need a separate enable signal to turn on and off the counter
       between stages, which saves an extra FF and a unique control signal. We
       just need to check if cnt_r is not zero to see if the counter is
       currently running
       */
      if (W == 1) begin : gen_cnt_w_eq_1
	 reg [3:0] cnt_lsb;
	 always @(posedge i_clk) begin
            o_cnt <= o_cnt + {2'd0,cnt_r[3]};
            cnt_lsb <= {cnt_lsb[2:0],(cnt_lsb[3] & !o_cnt_done) | i_rf_ready};
	    if (i_rst & (RESET_STRATEGY != "NONE")) begin
	       o_cnt   <= 3'd0;
	       cnt_lsb <= 4'b0000;
	    end
	 end
	 assign cnt_r = cnt_lsb;
	 assign o_cnt_en = |cnt_lsb;
      end else if (W == 4) begin : gen_cnt_w_eq_4
	 reg cnt_en;
	 always @(posedge i_clk) begin
            if (i_rf_ready) cnt_en <= 1; else
            if (o_cnt_done) cnt_en <= 0;
            o_cnt <= o_cnt + { 2'd0, cnt_en };
	    if (i_rst & (RESET_STRATEGY != "NONE")) begin
	       o_cnt   <= 3'd0;
	       cnt_en <= 1'b0;
	    end
	 end
	 assign cnt_r = 4'b1111;
	 assign o_cnt_en = cnt_en;
      end else if (W == 8) begin : gen_cnt_w_eq_8
	 reg cnt_en;
	 always @(posedge i_clk) begin
            if (i_rf_ready) cnt_en <= 1; else
            if (o_cnt_done) cnt_en <= 0;
            o_cnt <= o_cnt + { 1'd0, cnt_en, 1'b0};
	    if (i_rst & (RESET_STRATEGY != "NONE")) begin
	       o_cnt   <= 3'd0;
	       cnt_en <= 1'b0;
	    end
	 end
	 assign cnt_r = 4'b1111;
	 assign o_cnt_en = cnt_en;
      end
   endgenerate

   assign o_ctrl_trap = WITH_CSR & (i_e_op | i_new_irq | misalign_trap_sync);

	 //trap_pending is only guaranteed to have correct value during the
	 // last cycle of the init stage
	 wire trap_pending = WITH_CSR & ((take_branch & i_ctrl_misalign & !ALIGN) |
					 (i_dbus_en   & i_mem_misalign));

   generate
      if (WITH_CSR) begin : gen_csr
	 reg 	misalign_trap_sync_r;

	 always @(posedge i_clk) begin
	    if (i_ibus_ack | o_cnt_done | i_rst)
	      misalign_trap_sync_r <= !(i_ibus_ack | i_rst) & ((trap_pending & o_init) | misalign_trap_sync_r);
	 end
	 assign misalign_trap_sync = misalign_trap_sync_r;
      end else begin : gen_no_csr
	 assign misalign_trap_sync = 1'b0;
      end
   endgenerate
endmodule
