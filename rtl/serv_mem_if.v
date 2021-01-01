`default_nettype none
module serv_mem_if
  #(parameter WITH_CSR = 1)
  (
   input wire 	      i_clk,
   //State
   input wire 	      i_en,
   input wire [1:0]   i_bytecnt,
   input wire [1:0]   i_lsb,
   output wire 	      o_misalign,
   //Control
   input wire 	      i_mem_op,
   input wire 	      i_signed,
   input wire 	      i_word,
   input wire 	      i_half,
   //Data
   input wire 	      i_rs2,
   output wire 	      o_rd,
   //External interface
   output wire [31:0] o_wb_dat,
   output wire [3:0]  o_wb_sel,
   input wire [31:0]  i_wb_rdt,
   input wire 	      i_wb_ack);

   reg           signbit;
   reg [31:0] 	 dat;

   wire [2:0] 	 tmp = {1'b0,i_bytecnt}+{1'b0,i_lsb};

   wire 	 dat_en = i_en & !tmp[2];

   wire 	 dat_cur =
		 ((i_lsb == 2'd3) & dat[24]) |
		 ((i_lsb == 2'd2) & dat[16]) |
		 ((i_lsb == 2'd1) & dat[8]) |
		 ((i_lsb == 2'd0) & dat[0]);

   wire dat_valid =
	i_word |
	(i_bytecnt == 2'b00) |
	(i_half & !i_bytecnt[1]);

   assign o_rd = i_mem_op & (dat_valid ? dat_cur : signbit & i_signed);

   assign o_wb_sel[3] = (i_lsb == 2'b11) | i_word | (i_half & i_lsb[1]);
   assign o_wb_sel[2] = (i_lsb == 2'b10) | i_word;
   assign o_wb_sel[1] = (i_lsb == 2'b01) | i_word | (i_half & !i_lsb[1]);
   assign o_wb_sel[0] = (i_lsb == 2'b00);

   assign o_wb_dat = dat;

   always @(posedge i_clk) begin
      if (dat_en)
	dat <= {i_rs2, dat[31:1]};

      if (i_wb_ack)
	dat <= i_wb_rdt;

      if (dat_valid)
        signbit <= dat_cur;
   end
   generate
      if (WITH_CSR) begin
	 reg 		 misalign;
	 always @(posedge i_clk)
	   misalign <= (i_lsb[0] & (i_word | i_half)) | (i_lsb[1] & i_word);
	 assign o_misalign = misalign & i_mem_op;
      end else begin
	 assign o_misalign = 1'b0;
      end
   endgenerate

endmodule
