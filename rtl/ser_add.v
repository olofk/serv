module ser_add
  (
   input      clk,
   input      a,
   input      b,
   input      clear,
   output reg q = 1'b0);

   reg    carry = 1'b0;
   wire   c = carry & ~clear;
   
   always @(posedge clk) begin
      q     <= a ^ b ^ c;
      carry <= a&b | a&c | b&c;
   end

endmodule
