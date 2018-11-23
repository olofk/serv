`default_nettype none
module riscv_timer
  (input wire 	     i_clk,
   input wire 	      i_rst,
   output reg 	      o_irq = 1'b0,
   input wire [31:0]  i_wb_dat,
   input wire 	      i_wb_we,
   input wire 	      i_wb_cyc,
   output wire [31:0] o_wb_dat);

   reg [15:0] 	     mtime;
   reg [15:0] 	     mtimecmp;

   assign o_wb_dat = mtime;

   always @(posedge i_clk) begin
      if (i_wb_cyc & i_wb_we)
	mtimecmp <= i_wb_dat;
      mtime <= mtime + 32'd1;
      o_irq <= (mtime >= mtimecmp);
      if (i_rst) begin
	 mtime <= 16'd0;
	 mtimecmp <= 16'd0;
      end
   end
endmodule
