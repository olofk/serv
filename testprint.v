`default_nettype none
module testprint
  (
   input wire        i_wb_clk,
   input wire [31:0] i_wb_dat,
   input wire        i_wb_we,
   input wire        i_wb_cyc,
   input wire        i_wb_stb,
   output reg   o_wb_ack = 1'b0);

   wire 	wb_en;

   wire [7:0]	ch;
   assign ch = i_wb_dat[7:0];

   assign wb_en = i_wb_cyc & i_wb_stb;
`ifndef SYNTHESIS
   //synthesis translate_off
   reg [1023:0] signature_file;
   integer 	f = 0;

   initial
     if ($value$plusargs("signature=%s", signature_file)) begin
	$display("Writing signature to %0s", signature_file);
	f = $fopen(signature_file, "w");
     end
   //synthesis translate_on
`endif
   always @(posedge i_wb_clk) begin
      o_wb_ack <= 1'b0;
`ifndef SYNTHESIS
   //synthesis translate_off
      if (wb_en & o_wb_ack) begin
	 if (f)
	   $fwrite(f, "%c", i_wb_dat[7:0]);
         $write("%c", i_wb_dat[7:0]);
`ifndef VERILATOR
         $fflush();
`endif
      end
   //synthesis translate_on
`endif
      if (wb_en & !o_wb_ack)
        o_wb_ack <= 1'b1;
   end
endmodule
