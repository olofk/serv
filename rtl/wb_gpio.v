module wb_gpio
  (
   input wire i_wb_clk,
   input wire i_wb_dat,
   input wire i_wb_cyc,
   output reg o_gpio);

   always @(posedge i_wb_clk)
     if (i_wb_cyc)
       o_gpio <= i_wb_dat;
endmodule
