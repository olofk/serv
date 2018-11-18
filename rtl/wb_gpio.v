module wb_gpio
  (
   input wire i_wb_clk,
   input wire i_wb_dat,
   input wire i_wb_cyc,
   output reg o_wb_ack = 1'b0,
   output reg o_gpio = 1'b0);
   
   always @(posedge i_wb_clk)
     if (i_wb_cyc) begin
	o_wb_ack <= ~o_wb_ack;
	o_gpio <= i_wb_dat;
     end
endmodule
