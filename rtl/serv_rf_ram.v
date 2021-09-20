module serv_rf_ram
  #(parameter width=0,
    parameter csr_regs=4,
    parameter depth=32*(32+csr_regs)/width)
   (input wire i_clk,
    input wire [$clog2(depth)-1:0] i_waddr,
    input wire [width-1:0] 	   i_wdata,
    input wire 			   i_wen,
    input wire [$clog2(depth)-1:0] i_raddr,
    output wire [width-1:0] 	   o_rdata);

   reg [width-1:0] 		   memory [0:depth-1];
   reg [width-1:0] 		   rdata ;

   always @(posedge i_clk) begin
      if (i_wen)
	memory[i_waddr] <= i_wdata;
      rdata <= memory[i_raddr];
   end

   /* Reads from reg x0 needs to return 0
    Check that the part of the read address corresponding to the register
    is zero and gate the output
    width LSB of reg index $clog2(width)
    2     4                1
    4     3                2
    8     2                3
    16    1                4
    32    0                5
    */
   reg regzero;

   always @(posedge i_clk)
     regzero <= !(|i_raddr[$clog2(depth)-1:5-$clog2(width)]);

   assign o_rdata = rdata & ~{width{regzero}};

`ifdef SERV_CLEAR_RAM
   integer i;
   initial
     for (i=0;i<depth;i=i+1)
       memory[i] = {width{1'd0}};
`endif
endmodule
