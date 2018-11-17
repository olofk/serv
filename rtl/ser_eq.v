`default_nettype none
module ser_eq
  (
   input wire clk,
   input wire a,
   input wire b,
   input wire clr,
   output reg o_q);

   reg    eq = 1'b1;

   wire   q   = eq & (a == b);
   always @(posedge clk) begin
      eq <= q | clr;
      if (!clr)
        o_q <= q;
   end

endmodule
