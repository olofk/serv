module ser_eq
  (
   input  clk,
   input  a,
   input  b,
   input  clr,
   output q);

   reg    eq = 1'b1;
   
   assign q   = eq & (a == b);
   always @(posedge clk)
     eq <= q | clr;

endmodule
