`default_nettype none
module ser_add
  (
   input wire  clk,
   input wire  a,
   input wire  b,
   input wire  clr,
   output wire q,
   output wire o_v);

   reg 	       c_r = 1'b0;

   assign o_v = (a&b | a&c_r | b&c_r);

   assign q   = a ^ b ^ c_r;
   always @(posedge clk)
     c_r <= !clr & o_v;

endmodule
