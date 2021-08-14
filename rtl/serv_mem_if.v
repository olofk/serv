`default_nettype none
module serv_mem_if
  #(parameter WITH_CSR = 1,
    parameter MDU = 0)
  (
   input wire 	      i_clk,
   //State
   input wire 	      i_en,
   input wire 	      i_init,
   input wire 	      i_cnt_done,
   input wire [1:0]   i_bytecnt,
   input wire [1:0]   i_lsb,
   output wire 	      o_misalign,
   output wire 	      o_sh_done,
   output wire 	      o_sh_done_r,
   //Control
   input wire         i_mdu_op,
   input wire 	      i_mem_op,
   input wire 	      i_shift_op,
   input wire 	      i_signed,
   input wire 	      i_word,
   input wire 	      i_half,
   //Data
   input wire 	      i_op_b,
   output wire 	      o_rd,
   //External interface
   output wire [31:0] o_wb_dat,
   output wire [3:0]  o_wb_sel,
   input wire [31:0]  i_wb_rdt,
   input wire 	      i_wb_ack);

   reg           signbit;
   reg [31:0] 	 dat;

   /*
    Before a store operation, the data to be written needs to be shifted into
    place. Depending on the address alignment, we need to shift different
    amounts. One formula for calculating this is to say that we shift when
    i_lsb + i_bytecnt < 4. Unfortunately, the synthesis tools don't seem to be
    clever enough so the hideous expression below is used to achieve the same
    thing in a more optimal way.
    */
   wire 	 byte_valid =
		 (!i_lsb[0] & !i_lsb[1])         |
		 (!i_bytecnt[0] & !i_bytecnt[1]) |
		 (!i_bytecnt[1] & !i_lsb[1])     |
		 (!i_bytecnt[1] & !i_lsb[0])     |
		 (!i_bytecnt[0] & !i_lsb[1]);

   wire 	 dat_en = i_shift_op | (i_en & byte_valid);

   wire 	 dat_cur =
		 ((i_lsb == 2'd3) & dat[24]) |
		 ((i_lsb == 2'd2) & dat[16]) |
		 ((i_lsb == 2'd1) & dat[8]) |
		 ((i_lsb == 2'd0) & dat[0]);

   wire dat_valid =
	i_word |
	(i_bytecnt == 2'b00) |
	(i_half & !i_bytecnt[1]);

   wire mem_rd = i_mem_op & (dat_valid ? dat_cur : signbit & i_signed);
   
   generate
     if(MDU) begin
       wire mdu_rd = i_mdu_op & (dat_valid ? dat_cur : signbit & i_signed);
       assign o_rd = mem_rd | mdu_rd;
     end else begin
       wire mdu_rd = 1'b0;
       assign o_rd = mem_rd;
     end
   endgenerate

   assign o_wb_sel[3] = (i_lsb == 2'b11) | i_word | (i_half & i_lsb[1]);
   assign o_wb_sel[2] = (i_lsb == 2'b10) | i_word;
   assign o_wb_sel[1] = (i_lsb == 2'b01) | i_word | (i_half & !i_lsb[1]);
   assign o_wb_sel[0] = (i_lsb == 2'b00);

   assign o_wb_dat = dat;

   /* The dat register has three different use cases for store, load and
    shift operations.
    store : Data to be written is shifted to the correct position in dat during
            init by dat_en and is presented on the data bus as o_wb_dat
    load  : Data from the bus gets latched into dat during i_wb_ack and is then
            shifted out at the appropriate time to end up in the correct
            position in rd
    shift : Data is shifted in during init. After that, the six LSB are used as
            a downcounter (with bit 5 initially set to 0) that triggers
            o_sh_done and o_sh_done_r when they wrap around to indicate that
            the requested number of shifts have been performed
    */
   wire [5:0] dat_shamt = (i_shift_op & !i_init) ?
	      //Down counter mode
	      dat[5:0]-1 :
	      //Shift reg mode with optional clearing of bit 5
	      {dat[6] & !(i_shift_op & i_cnt_done),dat[5:1]};

   assign o_sh_done = dat_shamt[5];
   assign o_sh_done_r = dat[5];

   always @(posedge i_clk) begin
      if (dat_en | i_wb_ack)
	dat <= i_wb_ack ? i_wb_rdt : {i_op_b, dat[31:7], dat_shamt};

      if (dat_valid)
        signbit <= dat_cur;
   end

   /*
    mem_misalign is checked after the init stage to decide whether to do a data
    bus transaction or go to the trap state. It is only guaranteed to be correct
    at this time
    */
   assign o_misalign = WITH_CSR & ((i_lsb[0] & (i_word | i_half)) | (i_lsb[1] & i_word));

endmodule
