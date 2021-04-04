`default_nettype none
module servde1_soc_revF_clock_gen
  (input wire i_clk,
   input wire i_rst,
   output wire o_clk,
   output wire o_rst);

   wire        locked;
   reg [9:0]   r;

   assign o_rst = r[9];

   always @(posedge o_clk)
     if (locked)
       r <= {r[8:0],1'b0};
     else
       r <= 10'b1111111111;

   wire [5:0] 	  clk;

   assign 	  o_clk = clk[0];

   altpll
     #(.operation_mode         ("NORMAL"),
       .clk0_divide_by         (25),
       .clk0_multiply_by       (8),
       .inclk0_input_frequency (20000))
   pll
     (.areset       (i_rst),
      .inclk        ({1'b0, i_clk}),
      .clk          (clk),
      .locked       (locked));

endmodule
