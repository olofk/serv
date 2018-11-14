`default_nettype none
module testprint
  (
   input        i_wb_clk,

   input [31:0] i_wb_dat,
   input        i_wb_we,
   input        i_wb_cyc,
   input        i_wb_stb,
   output reg   o_wb_ack  /* verilator public */ = 1'b0);

   wire 	wb_en /* verilator public */;

   wire [7:0]	ch /* verilator public */;
   assign ch = i_wb_dat[7:0];

   assign wb_en = i_wb_cyc & i_wb_stb;
   reg [1023:0] signature_file;
   integer 	f = 0;

   initial
     if ($value$plusargs("signature=%s", signature_file)) begin
	$display("Writing signature to %0s", signature_file);
	f = $fopen(signature_file, "w");
     end

   always @(posedge i_wb_clk) begin
      o_wb_ack <= 1'b0;
      if (wb_en & o_wb_ack) begin
	 if (f)
	   $fwrite(f, "%c", i_wb_dat[7:0]);
         $write("%c", i_wb_dat[7:0]);
`ifndef VERILATOR
         $fflush();
`endif
      end
      if (wb_en & !o_wb_ack)
        o_wb_ack <= 1'b1;
   end
endmodule
