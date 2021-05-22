`default_nettype none
module servant_ram
  #(//Memory parameters
    parameter depth = 256,
    parameter aw    = $clog2(depth),
    parameter RESET_STRATEGY = "",
    parameter memfile = "")
   (input wire          i_wb_clk,
    input wire          i_wb_rst,
    input wire [aw-1:2] i_wb_adr,
    input wire [31:0]   i_wb_dat,
    input wire [3:0]    i_wb_sel,
    input wire          i_wb_we,
    input wire          i_wb_cyc,
    output reg [31:0]   o_wb_rdt,
    output reg          o_wb_ack);

   wire [3:0]           we = {4{i_wb_we & i_wb_cyc}} & i_wb_sel;

   reg [31:0]           mem [0:depth/4-1] /* verilator public */;

   wire [aw-3:0]        addr = i_wb_adr[aw-1:2];

   always @(posedge i_wb_clk)
     if (i_wb_rst & (RESET_STRATEGY != "NONE"))
       o_wb_ack <= 1'b0;
     else
       o_wb_ack <= i_wb_cyc & !o_wb_ack;

   always @(posedge i_wb_clk) begin
      if (we[0]) mem[addr][7:0]   <= i_wb_dat[7:0];
      if (we[1]) mem[addr][15:8]  <= i_wb_dat[15:8];
      if (we[2]) mem[addr][23:16] <= i_wb_dat[23:16];
      if (we[3]) mem[addr][31:24] <= i_wb_dat[31:24];
      o_wb_rdt <= mem[addr];
   end

   initial
     if(|memfile) begin
`ifndef ISE
        $display("Preloading %m from %s", memfile);
`endif
        $readmemh(memfile, mem);
     end

endmodule
