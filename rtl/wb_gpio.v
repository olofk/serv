module wb_gpio
  (
   input wire i_wb_clk,
   input wire i_wb_rst,
   input wire i_wb_dat,
   input wire i_wb_cyc,
   output reg o_wb_ack,
   output reg o_gpio = 1'b1);
   
   always @(posedge i_wb_clk) begin
      o_wb_ack <= 1'b0;
      if (i_wb_cyc) begin
	 if (!o_wb_ack)
	   o_wb_ack <= 1'b1;
	 o_gpio <= i_wb_dat;
      end
      if (i_wb_rst)
	o_wb_ack <= 1'b0;
   end
endmodule
