module serv_bufreg #(
      parameter [0:0] MDU = 0,
      parameter W = 1,
      parameter B = W-1
)(
   input wire 	      i_clk,
   //State
   input wire 	      i_cnt0,
   input wire 	      i_cnt1,
   input wire 	      i_en,
   input wire 	      i_init,
   input wire           i_mdu_op,
   output wire [1:0]    o_lsb,
   //Control
   input wire 	      i_rs1_en,
   input wire 	      i_imm_en,
   input wire 	      i_clr_lsb,
   input wire 	      i_sh_signed,
   //Data
   input wire [B:0] i_rs1,
   input wire [B:0] i_imm,
   output wire [B:0] o_q,
   //External
   output wire [31:0] o_dbus_adr,
   //Extension
   output wire [31:0] o_ext_rs1);

   wire		      c;
   wire [B:0]	      q;
   reg [B:0]	      c_r;
   reg [31:0]	      data;
   wire [B:0]	      clr_lsb;

   assign clr_lsb[0] = i_cnt0 & i_clr_lsb;

   assign {c,q} = {1'b0,(i_rs1 & {W{i_rs1_en}})} + {1'b0,(i_imm & {W{i_imm_en}} & ~clr_lsb)} + c_r;

   always @(posedge i_clk) begin
      //Make sure carry is cleared before loading new data
      c_r    <= {W{1'b0}};
      c_r[0] <= c & i_en;
   end

   reg [1:0] lsb;

   generate
      if (W == 1) begin : gen_w_eq_1
	 always @(posedge i_clk) begin
	    if (i_en)
	      data[31:2] <= {i_init ? q : {W{data[31] & i_sh_signed}}, data[31:3]};

	    if (i_init ? (i_cnt0 | i_cnt1) : i_en)
	      data[1:0] <= {i_init ? q : data[2], data[1]};
	 end
	 always @(*) lsb = data[1:0];
	 assign o_q = data[0] & {W{i_en}};
      end
   endgenerate


   assign o_dbus_adr = {data[31:2], 2'b00};
   assign o_ext_rs1  = data;
   assign o_lsb = (MDU & i_mdu_op) ? 2'b00 : lsb;

endmodule
