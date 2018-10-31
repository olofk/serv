module ser_add
  (
   input  clk,
   input  a,
   input  b,
   input  clr,
   output q,
   output o_v);

   assign o_v = (a&b | a&c_r | b&c_r);
   
   reg    c_r = 1'b0;
   
   assign q   = a ^ b ^ c_r;
   always @(posedge clk)
     c_r <= !clr & o_v;

endmodule
