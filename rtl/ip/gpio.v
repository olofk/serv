module gpio
  (input wire i_wb_clk,
   input wire i_wb_dat,
   input wire i_wb_we,
   input wire i_wb_cyc,
   output reg o_wb_rdt,
   output reg o_gpio);

   always @(posedge i_wb_clk) begin
      o_wb_rdt <= o_gpio;
      if (i_wb_cyc & i_wb_we)
	o_gpio <= i_wb_dat;
   end
   
   
endmodule
