`default_nettype none
module testhalt
  (
   input wire 	     i_wb_clk,
   input wire [31:0] i_wb_dat,
   input wire 	     i_wb_we,
   input wire 	     i_wb_cyc,
   input wire 	     i_wb_stb,
   output reg 	     o_wb_ack = 1'b0);

   always @(posedge i_wb_clk) begin
`ifndef SYNTHESIS
      if (i_wb_cyc & i_wb_stb) begin
         $display("Test complete");
	 $finish;
      end
`endif
      if (i_wb_cyc & i_wb_stb & !o_wb_ack)
        o_wb_ack <= 1'b1;
   end
endmodule
