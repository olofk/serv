module shift_reg
  (
   input            clk,
   input            i_en,
   input            i_d,
   output           o_q,
   output [LEN-2:0] o_par);

   parameter LEN = 0;
   parameter INIT = 0;

   reg [LEN-1:0] data = INIT;
   assign o_q = data[0];
   assign o_par = data[LEN-1:1];
   always @(posedge clk)
     if (i_en)
       data <= {i_d, data[LEN-1:1]};
endmodule
