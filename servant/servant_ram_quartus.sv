`default_nettype none
module servant_ram
  #(//Memory parameters
    parameter depth = 256,
    parameter aw    = $clog2(depth),
    parameter RESET_STRATEGY = "",
    parameter memfile = "")
   (input wire 		i_wb_clk,
    input wire 		i_wb_rst,
    input wire [aw-1:2] i_wb_adr,
    input wire [31:0] 	i_wb_dat,
    input wire [3:0] 	i_wb_sel,
    input wire 		i_wb_we,
    input wire 		i_wb_cyc,
    output reg [31:0] 	o_wb_rdt,
    output reg 		o_wb_ack);

   wire 		we = i_wb_we & i_wb_cyc;

   logic [3:0][7:0] 	mem[0:depth/4-1];

   wire [aw-3:0] 	addr = i_wb_adr[aw-1:2];

   always @(posedge i_wb_clk)
     if (i_wb_rst & (RESET_STRATEGY != "NONE"))
       o_wb_ack <= 1'b0;
     else
       o_wb_ack <= i_wb_cyc & !o_wb_ack;

   always_ff @(posedge i_wb_clk) begin
      if(we) begin
	 if(i_wb_sel[0]) mem[addr][0] <= i_wb_dat[7:0];
	 if(i_wb_sel[1]) mem[addr][1] <= i_wb_dat[15:8];
	 if(i_wb_sel[2]) mem[addr][2] <= i_wb_dat[23:16];
	 if(i_wb_sel[3]) mem[addr][3] <= i_wb_dat[31:24];
      end
      o_wb_rdt <= mem[addr];
   end

   initial
     if(|memfile) begin
	$display("Preloading %m from %s", memfile);
	$readmemh(memfile, mem);
     end

endmodule
