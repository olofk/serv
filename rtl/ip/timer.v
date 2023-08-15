module timer
  #(parameter WIDTH = 16,
    parameter RESET_STRATEGY = "",
    parameter DIVIDER = 0)
  (input wire 	     i_clk,
   input wire 	     i_rst,
   output reg 	     o_irq,
   input wire [31:0] i_wb_dat,
   input wire 	     i_wb_we,
   input wire 	     i_wb_cyc,
   output reg [31:0] o_wb_dat);

   localparam HIGH = WIDTH-1-DIVIDER;

   reg [WIDTH-1:0]   mtime;
   reg [HIGH:0]      mtimecmp;

   wire [HIGH:0]     mtimeslice = mtime[WIDTH-1:DIVIDER];

   always @(mtimeslice) begin
      o_wb_dat = 32'd0;
      o_wb_dat[HIGH:0] = mtimeslice;
   end

   always @(posedge i_clk) begin
      if (i_wb_cyc & i_wb_we)
	mtimecmp <= i_wb_dat[HIGH:0];
      mtime <= mtime + 'd1;
      o_irq <= (mtimeslice >= mtimecmp);
      if (RESET_STRATEGY != "NONE")
	if (i_rst) begin
	   mtime <= 0;
	   mtimecmp <= 0;
	end
   end
endmodule
