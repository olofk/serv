`default_nettype none
module serv_top_tb;

   parameter firmware = "firmware.hex";

   reg wb_clk = 1'b1;
   reg wb_rst = 1'b1;

   always #5 wb_clk <= !wb_clk;
   initial #100 wb_rst = 1'b0;

   vlog_tb_utils vtu();

   serv_wrapper #(firmware) dut(wb_clk, wb_rst);

endmodule
