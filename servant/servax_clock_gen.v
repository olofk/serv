`default_nettype none
module servax_clock_gen
  (input wire  i_clk,
   output wire o_clk,
   output reg  o_rst);

   wire   locked;
   reg 	  locked_r;    


    DCM_SP #(
      .CLKFX_DIVIDE(25),   // Can be any integer from 1 to 32
      .CLKFX_MULTIPLY(8), // Can be any integer from 2 to 32
      .CLKIN_PERIOD(20.0)  //50Mhz
    ) 
    DCM_SP_inst (
      .CLKFX(o_clk),   // DCM CLK synthesis out (M/D)
      .CLKFX180(), // 180 degree CLK synthesis out
      .LOCKED(locked), // DCM LOCK status output
      .STATUS(), // 8-bit DCM status bits output
      .CLKFB(),   // DCM clock feedback
      .CLKIN(i_clk),   // Clock input
      .RST(1'b0)        // DCM asynchronous reset input
   );

   always @(posedge o_clk) begin
      locked_r <= locked;
      o_rst  <= !locked_r;
   end

endmodule