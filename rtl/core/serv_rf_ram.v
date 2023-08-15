module serv_rf_ram #(
    parameter width     = 8,
    parameter csr_regs  = 4,
    parameter depth     = 32*32/width
)
(
    input  wire                      i_clk,
    input  wire                      i_rst,
    input  wire [$clog2(depth)-1:0]  i_waddr, // 16 GPRs + 7 CSRs
    input  wire [width-1:0] 	     i_wdata,
    input  wire 			         i_wen,
    input  wire [$clog2(depth)-1:0]  i_raddr, // 16 GPRs + 7 CSRs
    input  wire			             i_ren,
    output wire [width-1:0] 	     o_rdata
);
   
       
   reg [width-1:0] memory [0:depth-1];
   reg [width-1:0] rdata ;
   
//   wire [$clog2(depth)-1:0] half_waddr = {1'b0, i_waddr[$clog2(depth)], i_waddr[$clog2(depth)-2:0]};
//   wire [$clog2(depth)-1:0] half_raddr = {1'b0, i_raddr[$clog2(depth)], i_raddr[$clog2(depth)-2:0]};
   /*
   
   hex |ram  |csr 
   addr|addr |name
   ----|-----|----------
   340 |16   |mscrath
   341 |17   |mepc
   343 |18   |mtval
   305 |19   |mtvec
   xxx |20   |reserved
   7b1 |21   |dpc
   7b2 |22   |dscratch0
   xxx |22-31|reserved
   
   */
   
   integer i;
   initial begin
    for (i = 0; i < depth; i = i + 1)
        memory[i] = 0;
   end
   
   always @(posedge i_clk) begin
      if (i_wen) memory[i_waddr] <= i_wdata;
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
   
endmodule
