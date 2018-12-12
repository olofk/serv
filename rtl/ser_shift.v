`default_nettype none
module ser_shift
  (
   input wire 	    i_clk,
   input wire 	    i_rst,
   input wire 	    i_load,
   input wire [4:0] i_shamt,
   input wire 	    i_signed,
   input wire 	    i_right,
   input wire 	    i_d,
   output wire 	    o_q);

   wire [31:0] 	    shiftreg;

   reg 		    signbit = 1'b0;
   reg 		    wrapped = 1'b0;
   reg [4:0] 	    cnt = 5'd0;

   shift_reg #(.LEN (32)) sh_reg
     (.clk (i_clk),
      .i_rst (i_rst),
      .i_en (i_load),
      .i_d  (i_d),
      .o_q  (shiftreg[0]),
      .o_par (shiftreg[31:1]));

   always @(posedge i_clk) begin
      cnt <= cnt + 5'd1;
      if (cnt == 31) begin
         signbit <= shiftreg[cnt];
         wrapped <= 1'b1;
      end
      if (i_load) begin
         cnt <= i_shamt;
         wrapped <= 1'b0;
      end


   end

   wire shiftreg_valid = (i_shamt == 0) | (wrapped^i_right);
   assign o_q = shiftreg_valid ? shiftreg[cnt] : signbit & i_signed;

endmodule
