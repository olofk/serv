`default_nettype none
module serv_csr
  #(parameter RESET_STRATEGY = "MINI")
  (
   input wire 	    i_clk,
   input wire 	    i_rst,
   //State
   input wire 	    i_init,
   input wire 	    i_en,
   input wire 	    i_cnt0to3,
   input wire 	    i_cnt3,
   input wire 	    i_cnt7,
   input wire 	    i_cnt_done,
   input wire 	    i_mem_op,
   input wire 	    i_mtip,
   input wire 	    i_trap,
   output reg 	    o_new_irq,
   //Control
   input wire 	    i_e_op,
   input wire 	    i_ebreak,
   input wire 	    i_mem_cmd,
   input wire 	    i_mstatus_en,
   input wire 	    i_mie_en,
   input wire 	    i_mcause_en,
   input wire [1:0] i_csr_source,
   input wire 	    i_mret,
   input wire 	    i_csr_d_sel,
   //Data
   input wire 	    i_rf_csr_out,
   output wire 	    o_csr_in,
   input wire 	    i_csr_imm,
   input wire 	    i_rs1,
   output wire 	    o_q);

   localparam [1:0]
     CSR_SOURCE_CSR = 2'b00,
     CSR_SOURCE_EXT = 2'b01,
     CSR_SOURCE_SET = 2'b10,
     CSR_SOURCE_CLR = 2'b11;

   reg 		    mstatus_mie;
   reg 		    mstatus_mpie;
   reg 		    mie_mtie;

   reg 		mcause31;
   reg [3:0] 	mcause3_0;
   wire 	mcause;

   wire 	csr_in;
   wire 	csr_out;

   reg 		timer_irq_r;

   wire 	d = i_csr_d_sel ? i_csr_imm : i_rs1;

   assign csr_in = (i_csr_source == CSR_SOURCE_EXT) ? d :
		   (i_csr_source == CSR_SOURCE_SET) ? csr_out | d :
		   (i_csr_source == CSR_SOURCE_CLR) ? csr_out & ~d :
		   (i_csr_source == CSR_SOURCE_CSR) ? csr_out :
		   1'bx;

   assign csr_out = (i_mstatus_en & mstatus_mie & i_cnt3) |
		    i_rf_csr_out |
		    (i_mcause_en & i_en & mcause);

   assign o_q = csr_out;

   wire 	timer_irq = i_mtip & mstatus_mie & mie_mtie;

   assign mcause = i_cnt0to3 ? mcause3_0[0] : //[3:0]
		   i_cnt_done ? mcause31 //[31]
		   : 1'b0;

   assign o_csr_in = csr_in;

   always @(posedge i_clk) begin
      if (!i_init & i_cnt_done) begin
	 timer_irq_r <= timer_irq;
	 o_new_irq   <= timer_irq & !timer_irq_r;
      end

      if (i_mie_en & i_cnt7)
	mie_mtie <= csr_in;

      /*
       The mie bit in mstatus gets updated under three conditions

       When a trap is taken, the bit is cleared
       During an mret instruction, the bit is restored from mpie
       During a mstatus CSR access instruction it's assigned when
        bit 3 gets updated

       These conditions are all mutually exclusibe
       */
      if ((i_trap & i_cnt_done) | i_mstatus_en & i_cnt3 | i_mret)
	mstatus_mie <= !i_trap & (i_mret ?  mstatus_mpie : csr_in);

      /*
       Note: To save resources mstatus_mpie (mstatus bit 7) is not
       readable or writable from sw
       */
      if (i_trap & i_cnt_done)
	mstatus_mpie <= mstatus_mie;

      /*
       The four lowest bits in mcause hold the exception code

       These bits get updated under three conditions

       During an mcause CSR access function, they are assigned when
       bits 0 to 3 gets updated

       During an external interrupt the exception code is set to
       7, since SERV only support timer interrupts

       During an exception, the exception code is assigned to indicate
       if it was caused by an ebreak instruction (3),
       ecall instruction (11), misaligned load (4), misaligned store (6)
       or misaligned jump (0)

       The expressions below are derived from the following truth table
       irq  => 0111 (timer=7)
       e_op => x011 (ebreak=3, ecall=11)
       mem  => 01x0 (store=6, load=4)
       ctrl => 0000 (jump=0)
       */
      if (i_mcause_en & i_en & i_cnt0to3 | (i_trap & i_cnt_done)) begin
	 mcause3_0[3] <= (i_e_op & !i_ebreak) | (!i_trap & csr_in);
	 mcause3_0[2] <= o_new_irq | i_mem_op | (!i_trap & mcause3_0[3]);
	 mcause3_0[1] <= o_new_irq | i_e_op | (i_mem_op & i_mem_cmd) | (!i_trap & mcause3_0[2]);
	 mcause3_0[0] <= o_new_irq | i_e_op | (!i_trap & mcause3_0[1]);
      end
      if (i_mcause_en & i_cnt_done | i_trap)
	mcause31 <= i_trap ? o_new_irq : csr_in;
      if (i_rst)
	if (RESET_STRATEGY != "NONE") begin
	   o_new_irq <= 1'b0;
	   mie_mtie <= 1'b0;
	end
   end

endmodule
