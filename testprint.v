`default_nettype none
module testprint
  (
   input        i_wb_clk,

   input [31:0] i_wb_dat,
   input        i_wb_we,
   input        i_wb_cyc,
   input        i_wb_stb,
   output reg   o_wb_ack = 1'b0);

   always @(posedge i_wb_clk) begin
      if (i_wb_cyc & i_wb_stb) begin
         $write("%c", i_wb_dat[7:0]);
`ifndef VERILATOR
         $fflush();
`endif
      end
      if (i_wb_cyc & i_wb_stb & !o_wb_ack)
        o_wb_ack <= 1'b1;
   end
endmodule
