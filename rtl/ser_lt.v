`default_nettype none
module ser_lt
  (
   input      i_clk,
   input      i_a,
   input      i_b,
   input      i_clr,
   output reg o_q);

   reg        lt_r = 1'b0;

   wire       lt = (~i_a & i_b) | ((i_a == i_b) & lt_r);
   always @(posedge i_clk) begin
      lt_r <= lt & ~i_clr;
      if (~i_clr)
        o_q <= lt;
   end

endmodule
