`default_nettype none
module serv_mem_if
  #(
    parameter [0:0] WITH_CSR = 1,
    parameter	    W = 1,
    parameter	    B = W-1
  )
  (
   input wire 	     i_clk,
   //State
   input wire [1:0]  i_bytecnt,
   input wire [1:0]  i_lsb,
   output wire 	     o_byte_valid,
   output wire 	     o_misalign,
   //Control
   input wire 	     i_signed,
   input wire 	     i_word,
   input wire 	     i_half,
   //MDU
   input wire 	     i_mdu_op,
   //Data
   input wire [B:0] i_bufreg2_q,
   output wire [B:0] o_rd,
   //External interface
   output wire [3:0] o_wb_sel);

   reg signbit;

   /*
    Before a store operation, the data to be written needs to be shifted into
    place. Depending on the address alignment, we need to shift different
    amounts. One formula for calculating this is to say that we shift when
    i_lsb + i_bytecnt < 4. Unfortunately, the synthesis tools don't seem to be
    clever enough so the hideous expression below is used to achieve the same
    thing in a more optimal way.
    */
   assign o_byte_valid
     = (!i_lsb[0] & !i_lsb[1])         |
       (!i_bytecnt[0] & !i_bytecnt[1]) |
       (!i_bytecnt[1] & !i_lsb[1])     |
       (!i_bytecnt[1] & !i_lsb[0])     |
       (!i_bytecnt[0] & !i_lsb[1]);

   wire dat_valid =
	i_mdu_op |
	i_word |
	(i_bytecnt == 2'b00) |
	(i_half & !i_bytecnt[1]);

   assign o_rd = dat_valid ? i_bufreg2_q : {W{i_signed & signbit}};

   assign o_wb_sel[3] = (i_lsb == 2'b11) | i_word | (i_half & i_lsb[1]);
   assign o_wb_sel[2] = (i_lsb == 2'b10) | i_word;
   assign o_wb_sel[1] = (i_lsb == 2'b01) | i_word | (i_half & !i_lsb[1]);
   assign o_wb_sel[0] = (i_lsb == 2'b00);

   always @(posedge i_clk) begin
      if (dat_valid)
        signbit <= i_bufreg2_q[B];
   end

   /*
    mem_misalign is checked after the init stage to decide whether to do a data
    bus transaction or go to the trap state. It is only guaranteed to be correct
    at this time
    */
   assign o_misalign = WITH_CSR & ((i_lsb[0] & (i_word | i_half)) | (i_lsb[1] & i_word));

endmodule
