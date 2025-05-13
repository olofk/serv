module serv_bufreg2
  #(parameter W = 1,
    //Internally calculated. Do not touch
    parameter B=W-1)
  (
   input wire	      i_clk,
   //State
   input wire	      i_en,
   input wire	      i_init,
   input wire	      i_cnt7,
   input wire	      i_cnt_done,
   input wire	      i_sh_right,
   input wire [1:0]   i_lsb,
   input wire [1:0]   i_bytecnt,
   output wire	      o_sh_done,
   //Control
   input wire	      i_op_b_sel,
   input wire	      i_shift_op,
   //Data
   input wire [B:0]   i_rs2,
   input wire [B:0]   i_imm,
   output wire [B:0]  o_op_b,
   output wire [B:0]  o_q,
   //External
   output wire [31:0] o_dat,
   input wire	      i_load,
   input wire [31:0]  i_dat);

   // High and low data words form a 32-bit word
   reg [7:0] 	 dhi;
   reg [23:0] 	 dlo;

   /*
    Before a store operation, the data to be written needs to be shifted into
    place. Depending on the address alignment, we need to shift different
    amounts. One formula for calculating this is to say that we shift when
    i_lsb + i_bytecnt < 4. Unfortunately, the synthesis tools don't seem to be
    clever enough so the hideous expression below is used to achieve the same
    thing in a more optimal way.
    */
   wire byte_valid
     = (!i_lsb[0] & !i_lsb[1])         |
       (!i_bytecnt[0] & !i_bytecnt[1]) |
       (!i_bytecnt[1] & !i_lsb[1])     |
       (!i_bytecnt[1] & !i_lsb[0])     |
       (!i_bytecnt[0] & !i_lsb[1]);

   assign o_op_b = i_op_b_sel ? i_rs2 : i_imm;

   wire 	 shift_en = i_shift_op ? (i_en & i_init & (i_bytecnt == 2'b00)) : (i_en & byte_valid);

   wire		 cnt_en = (i_shift_op & (!i_init | (i_cnt_done & i_sh_right)));

   /* The dat register has three different use cases for store, load and
    shift operations.
    store : Data to be written is shifted to the correct position in dat during
            init by shift_en and is presented on the data bus as o_wb_dat
    load  : Data from the bus gets latched into dat during i_wb_ack and is then
            shifted out at the appropriate time to end up in the correct
            position in rd
    shift : Data is shifted in during init. After that, the six LSB are used as
            a downcounter (with bit 5 initially set to 0) that trigger
            o_sh_done when they wrap around to indicate that
            the requested number of shifts have been performed
    */

   wire [7:0]	 cnt_next;
   wire [7:0]	 sh_next;
   generate
      if (W == 1) begin : gen_cnt_w_eq_1
	 assign cnt_next = {o_op_b, dhi[7], dhi[5:0]-6'd1};
	 assign sh_next = {o_op_b, dhi[7:W]};
      end else if (W == 4) begin : gen_cnt_w_eq_4
	 assign cnt_next = {o_op_b[3:2], dhi[5:0]-6'd4};
	 assign sh_next = {o_op_b, dhi[7:W]};
      end else if (W == 8) begin : gen_cnt_w_eq_8
	 assign cnt_next = {o_op_b[7:6], dhi[5:0]-6'd8};
	 assign sh_next = o_op_b;
      end
   endgenerate

   wire [7:0] dat_shamt = cnt_en ?
	      //Down counter mode
	      cnt_next :
	      //Shift reg mode
	      sh_next;

   assign o_sh_done = dat_shamt[5];

   assign o_q =
	       ({W{(i_lsb == 2'd3)}} & o_dat[W+23:24]) |
	       ({W{(i_lsb == 2'd2)}} & o_dat[W+15:16]) |
	       ({W{(i_lsb == 2'd1)}} & o_dat[W+7:8])   |
	       ({W{(i_lsb == 2'd0)}} & o_dat[W-1:0]);

   assign o_dat = {dhi,dlo};

   always @(posedge i_clk) begin
      if (shift_en | cnt_en | i_load)
	dhi <= i_load ? i_dat[31:24] : dat_shamt & {2'b11, !(i_shift_op & i_cnt7 & !cnt_en), 5'b11111};
      if (shift_en | i_load)
	dlo <= i_load ? i_dat[23:0] : {dhi[B:0], dlo[23:W]};
   end

endmodule
