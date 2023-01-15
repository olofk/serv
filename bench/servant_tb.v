`default_nettype none
module servant_tb;

   parameter memfile = "";
   parameter memsize = 8192;
   parameter with_csr = 1;

   reg wb_clk = 1'b0;
   reg wb_rst = 1'b1;

   wire q;

   always  #31 wb_clk <= !wb_clk;
   initial #62 wb_rst <= 1'b0;

   vlog_tb_utils vtu();

   uart_decoder #(57600) uart_decoder (q);

   servant_sim
     #(.memfile  (memfile),
       .memsize  (memsize),
       .with_csr (with_csr))
   dut
     (.wb_clk (wb_clk),
      .wb_rst (wb_rst),
      .pc_adr (),
      .pc_vld (),
      .q      (q));

endmodule
