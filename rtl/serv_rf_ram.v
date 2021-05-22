module serv_rf_ram
  #(parameter width=0,
    parameter csr_regs=4,
    parameter depth=32*(32+csr_regs)/width)
   (input wire i_clk,
    input wire [$clog2(depth)-1:0] i_waddr,
    input wire [width-1:0]         i_wdata,
    input wire                     i_wen,
    input wire [$clog2(depth)-1:0] i_raddr,
    output reg [width-1:0]         o_rdata);

   reg [width-1:0]                 memory [0:depth-1];

   always @(posedge i_clk) begin
      if (i_wen)
        memory[i_waddr] <= i_wdata;
      o_rdata <= memory[i_raddr];
   end

`ifdef SERV_CLEAR_RAM
   integer i;
   initial
     for (i=0;i<depth;i=i+1)
       memory[i] = {width{1'd0}};
`endif
endmodule
