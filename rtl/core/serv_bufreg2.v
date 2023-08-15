module serv_bufreg2
  (
   input wire 	      i_clk,
   input wire         i_rst,
   //State
   input wire 	      i_en,
   input wire 	      i_init,
   input wire 	      i_cnt_done,
   input wire [1:0]   i_lsb,
   input wire 	      i_byte_valid,
   output wire 	      o_sh_done,
   output wire 	      o_sh_done_r,
   //Control
   input wire 	      i_op_b_sel,
   input wire 	      i_shift_op,
   //Data
   input wire 	      i_rs2,
   input wire 	      i_imm,
   output wire 	      o_op_b,
   output wire 	      o_q,
   //External
   output wire [31:0] o_dat,
   input wire 	      i_load,
   input wire [31:0]  i_dat
);

   reg [31:0] 	 dat;

   assign o_op_b = i_op_b_sel ? i_rs2 : i_imm;

   wire 	 dat_en = i_shift_op | (i_en & i_byte_valid);

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

   assign o_q =
	       ((i_lsb == 2'd3) & dat[24]) |
	       ((i_lsb == 2'd2) & dat[16]) |
	       ((i_lsb == 2'd1) & dat[8]) |
	       ((i_lsb == 2'd0) & dat[0]);

   assign o_dat = dat;

   always @(posedge i_clk) begin
      if (i_rst) dat <= 32'd0;
      else if (dat_en | i_load)
	       dat <= i_load ? i_dat : {o_op_b, dat[31:7], dat_shamt};
   end

endmodule
