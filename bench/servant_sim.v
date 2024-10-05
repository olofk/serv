`default_nettype none
module servant_sim
  (input wire	      wb_clk,
   input wire	      wb_rst,
   output wire [31:0] pc_adr,
   output wire	      pc_vld,
   output wire	      q);

   parameter memfile = "";
   parameter memsize = 8192;
   parameter width = 1;
   parameter with_csr = 1;
   parameter compressed = 0;
   parameter align = compressed;

   reg [1023:0] firmware_file;
   initial
     if ($value$plusargs("firmware=%s", firmware_file)) begin
	$display("Loading RAM from %0s", firmware_file);
	$readmemh(firmware_file, dut.ram.mem);
     end

   servant
     #(.memfile  (memfile),
       .memsize  (memsize),
       .width    (width),
       .sim      (1),
       .with_csr (with_csr),
       .compress (compressed[0:0]),
       .align    (align[0:0]))
   dut(wb_clk, wb_rst, q);

   assign pc_adr = dut.wb_mem_adr;
   assign pc_vld = dut.wb_mem_ack;

endmodule
