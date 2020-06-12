`default_nettype none
module serv_immdec
  (
   input wire 	     i_clk,
   //Input   
   input wire 	     i_cnt_en,
   input wire [31:2] i_wb_rdt,
   input wire 	     i_wb_en,
   input wire 	     i_cnt_done,
   input wire [3:0]  i_ctrl,
   output wire 	     o_imm);

   reg 	      signbit;

   reg [8:0]  imm19_12_20;
   reg 	      imm7;
   reg [5:0]  imm30_25;
   reg [4:0]  imm24_20;
   reg [4:0]  imm11_7;


   assign o_imm = i_cnt_done ? signbit : i_ctrl[0] ? imm11_7[0] : imm24_20[0];

   always @(posedge i_clk) begin
      if (i_wb_en) begin
	 signbit     <= i_wb_rdt[31];
	 imm19_12_20 <= {i_wb_rdt[19:12],i_wb_rdt[20]};
	 imm7        <= i_wb_rdt[7];
	 imm30_25    <= i_wb_rdt[30:25];
	 imm24_20    <= i_wb_rdt[24:20];
	 imm11_7     <= i_wb_rdt[11:7];
      end
      if (i_cnt_en) begin
	 imm19_12_20 <= {i_ctrl[3] ? signbit : imm24_20[0], imm19_12_20[8:1]};
	 imm7        <= signbit;
	 imm30_25    <= {i_ctrl[2] ? imm7 : i_ctrl[1] ? signbit : imm19_12_20[0], imm30_25[5:1]};
	 imm24_20    <= {imm30_25[0], imm24_20[4:1]};
	 imm11_7     <= {imm30_25[0], imm11_7[4:1]};
      end
   end   
endmodule
