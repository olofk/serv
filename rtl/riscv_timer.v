`default_nettype none
module riscv_timer
  (input 	 i_clk,
   output reg 	     o_irq = 1'b0,
   input [31:0]      i_wb_adr,
   input [31:0]      i_wb_dat,
   input [3:0] 	     i_wb_sel,
   input 	     i_wb_we,
   input 	     i_wb_cyc,
   input 	     i_wb_stb,
   output reg [31:0] o_wb_dat,
   output reg 	     o_wb_ack = 1'b0);

   reg [63:0] 	 mtime = 64'd0;
   reg [63:0]  mtimecmp = 64'd0;

   localparam [1:0]
     REG_MTIMELO    = 2'd0,
     REG_MTIMEHI    = 2'd1,
     REG_MTIMECMPLO = 2'd2,
     REG_MTIMECMPHI = 2'd3;

   always @(i_wb_adr)
     case (i_wb_adr[3:2])
       REG_MTIMELO    : o_wb_dat = mtime[31:0];
       REG_MTIMEHI    : o_wb_dat = mtime[63:32];
       REG_MTIMECMPLO : o_wb_dat = mtimecmp[31:0];
       REG_MTIMECMPHI : o_wb_dat = mtimecmp[63:32];
     endcase

   always @(posedge i_clk) begin
      o_wb_ack <= 1'b0;
      if (i_wb_cyc & i_wb_stb) begin
	 o_wb_ack <= !o_wb_ack;
	 if (i_wb_we & (i_wb_adr[3:2] == REG_MTIMECMPLO))
	   mtimecmp[31:0] <= i_wb_dat;
	 if (i_wb_we & (i_wb_adr[3:2] == REG_MTIMECMPHI))
	   mtimecmp[63:32] <= i_wb_dat;
      end
      mtime <= mtime + 64'd1;
      o_irq <= (mtime >= mtimecmp);
   end
endmodule
