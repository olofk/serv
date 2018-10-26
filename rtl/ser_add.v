module ser_add
  (
   input  clk,
   input  a,
   input  b,
   input  clr,
   output q);

   reg    c = 1'b0;
   
   assign q   = a ^ b ^ c;
   always @(posedge clk)
     c <= !clr & (a&b | a&c | b&c);

endmodule
