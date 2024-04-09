`default_nettype none
module servant_ecp5_evn_clock_gen
  (
   input  i_clk,
   input  i_rst,
   output o_clk,
   output o_rst);

   wire   locked;

   reg [1:0] rst_reg;
   always @(posedge o_clk)
     if (i_rst)
       rst_reg <= 2'b11;
     else
       rst_reg <= {!locked, rst_reg[1]};

   assign o_rst = rst_reg[0];

   ecp5_evn_pll pll
     (.clki   (i_clk),
      .clko   (o_clk),
      .locked (locked));

endmodule
