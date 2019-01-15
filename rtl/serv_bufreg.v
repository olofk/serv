module serv_bufreg
  (
   input wire 	      i_clk,
   input wire 	      i_rst,
   input wire [4:0]   i_cnt,
   input wire [3:0]   i_cnt_r,
   input wire 	      i_en,
   input wire 	      i_clr,
   input wire 	      i_rs1,
   input wire 	      i_rs1_en,
   input wire 	      i_imm,
   input wire 	      i_imm_en,
   output reg [1:0]   o_lsb,
   output wire [31:0] o_reg,
   output wire 	      o_q);

   wire 	      c, q;
   reg 		      c_r;
   reg [31:0] 	      data;

   assign {c,q} = (i_rs1 & i_rs1_en) + (i_imm & i_imm_en) + c_r;

   always @(posedge i_clk) begin
      c_r <= c & !i_clr;

      if (i_rst)
	data <= 32'd0;
      else if (i_en)
	data <= {q, data[31:1]};

      if ((i_cnt[4:2] == 3'd0) & i_cnt_r[0] & i_en)
	o_lsb[0] <= q;
      if ((i_cnt[4:2] == 3'd0) & i_cnt_r[1] & i_en)
	o_lsb[1] <= q;
   end

   assign o_q = data[0];
   assign o_reg = data;

endmodule
