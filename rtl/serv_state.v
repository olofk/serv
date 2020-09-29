module serv_state
  (
   input wire 	     i_clk,
   input wire 	     i_rst,
   input wire 	     i_new_irq,
   output wire 	     o_trap_taken,
   output reg 	     o_pending_irq,
   input wire 	     i_dbus_ack,
   input wire 	     i_ibus_ack,
   output wire 	     o_rf_rreq,
   output wire 	     o_rf_wreq,
   input wire 	     i_rf_ready,
   output wire 	     o_rf_rd_en,
   input wire 	     i_cond_branch,
   input wire 	     i_bne_or_bge,
   input wire 	     i_alu_cmp,
   input wire 	     i_branch_op,
   input wire 	     i_mem_op,
   input wire 	     i_shift_op,
   input wire 	     i_slt_op,
   input wire 	     i_e_op,
   input wire 	     i_rd_op,
   output reg 	     o_init,
   output reg 	     o_cnt_en,
   output wire 	     o_cnt0,
   output wire 	     o_cnt0to3,
   output wire 	     o_cnt12to31,
   output wire 	     o_cnt1,
   output wire 	     o_cnt2,
   output wire 	     o_cnt3,
   output wire 	     o_cnt7,
   output wire 	     o_ctrl_pc_en,
   output reg 	     o_ctrl_jump,
   output wire 	     o_ctrl_trap,
   input wire 	     i_ctrl_misalign,
   output wire 	     o_alu_shamt_en,
   input wire 	     i_alu_sh_done,
   output wire 	     o_dbus_cyc,
   output wire [1:0] o_mem_bytecnt,
   input wire 	     i_mem_misalign,
   output reg 	     o_cnt_done,
   output wire 	     o_bufreg_hold);

   parameter [0:0] WITH_CSR = 1;

   wire 	     cnt4;

   reg 	stage_two_req;

   reg [4:2] o_cnt;
   reg [3:0] o_cnt_r;

   //Update PC in RUN or TRAP states
   assign o_ctrl_pc_en  = o_cnt_en & !o_init;


   assign o_mem_bytecnt = o_cnt[4:3];

   assign o_cnt0to3   = (o_cnt[4:2] == 3'd0);
   assign o_cnt12to31 = (o_cnt[4] | (o_cnt[3:2] == 2'b11));
   assign o_cnt0 = (o_cnt[4:2] == 3'd0) & o_cnt_r[0];
   assign o_cnt1 = (o_cnt[4:2] == 3'd0) & o_cnt_r[1];
   assign o_cnt2 = (o_cnt[4:2] == 3'd0) & o_cnt_r[2];
   assign o_cnt3 = (o_cnt[4:2] == 3'd0) & o_cnt_r[3];
   assign cnt4   = (o_cnt[4:2] == 3'd1) & o_cnt_r[0];
   assign o_cnt7 = (o_cnt[4:2] == 3'd1) & o_cnt_r[3];
   
   assign o_alu_shamt_en = (o_cnt0to3 | cnt4) & o_init;

   //Take branch for jump or branch instructions (opcode == 1x0xx) if
   //a) It's an unconditional branch (opcode[0] == 1)
   //b) It's a conditional branch (opcode[0] == 0) of type beq,blt,bltu (funct3[0] == 0) and ALU compare is true
   //c) It's a conditional branch (opcode[0] == 0) of type bne,bge,bgeu (funct3[0] == 1) and ALU compare is false
   //Only valid during the last cycle of INIT, when the branch condition has
   //been calculated.
   wire      take_branch = i_branch_op & (!i_cond_branch | (i_alu_cmp^i_bne_or_bge));

   //slt*, branch/jump, shift, load/store
   wire two_stage_op = i_slt_op | i_mem_op | i_branch_op | i_shift_op;

   reg 	stage_two_pending;

   assign o_dbus_cyc = !o_cnt_en & stage_two_pending & i_mem_op & !i_mem_misalign;

   wire trap_pending = WITH_CSR & ((o_ctrl_jump & i_ctrl_misalign) | i_mem_misalign);

   //Prepare RF for reads when a new instruction is fetched
   // or when stage one caused an exception (rreq implies a write request too)
   assign o_rf_rreq = i_ibus_ack | (stage_two_req & trap_pending);

   //Prepare RF for writes when everything is ready to enter stage two
   assign o_rf_wreq = ((i_shift_op & i_alu_sh_done & stage_two_pending) | (i_mem_op & i_dbus_ack) | (stage_two_req & (i_slt_op | i_branch_op))) & !trap_pending;

   assign o_rf_rd_en = i_rd_op & o_cnt_en & !o_init;

   //Shift operations require bufreg to hold for one cycle between INIT and RUN before shifting
   assign o_bufreg_hold = !o_cnt_en & (stage_two_req | ~i_shift_op);

   always @(posedge i_clk) begin
      if (o_cnt_done)
	o_ctrl_jump <= o_init & take_branch;

      if (o_cnt_en)
	stage_two_pending <= o_init;

      o_cnt_done <= (o_cnt[4:2] == 3'b111) & o_cnt_r[2];

      //Need a strobe for the first cycle in the IDLE state after INIT
      stage_two_req <= o_cnt_done & o_init;

      if (i_rf_ready & !stage_two_pending)
	o_init <= two_stage_op & !o_pending_irq;

      if (o_cnt_done)
	o_init <= 1'b0;

      if (i_rf_ready)
	o_cnt_en <= 1'b1;

      if (o_cnt_done)
        o_cnt_en <= 1'b0;

      o_cnt <= o_cnt + {2'd0,o_cnt_r[3]};
      if (o_cnt_en)
	o_cnt_r <= {o_cnt_r[2:0],o_cnt_r[3]};

      if (i_rst) begin
	 o_cnt   <= 3'd0;
	 stage_two_pending <= 1'b0;
	 o_ctrl_jump <= 1'b0;
	 o_cnt_r <= 4'b0001;
      end
   end

   generate
      if (WITH_CSR) begin
   reg 	irq_sync;
   reg 	misalign_trap_sync;

   assign o_ctrl_trap = i_e_op | o_pending_irq | misalign_trap_sync;
   assign o_trap_taken = i_ibus_ack & o_ctrl_trap;

   always @(posedge i_clk) begin
      if (i_ibus_ack)
	irq_sync <= 1'b0;
      if (i_new_irq)
	irq_sync <= 1'b1;

      if (i_ibus_ack)
	o_pending_irq <= irq_sync;

      if (stage_two_req)
	misalign_trap_sync <= trap_pending;
      if (i_ibus_ack)
	misalign_trap_sync <= 1'b0;
   end // always @ (posedge i_clk)
      end else begin
	 always @(*)
	   o_pending_irq = 1'b0;
      end
   endgenerate
endmodule
