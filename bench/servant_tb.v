`default_nettype none
module servant_tb;

   parameter memfile = "";

   reg wb_clk = 1'b0;
   reg wb_rst = 1'b1;

   reg q_r = 1'b0;
   wire q;

   always  #31 wb_clk <= !wb_clk;
   initial #62 wb_rst <= 1'b0;

   vlog_tb_utils vtu();

   servant #(memfile) dut(wb_clk, wb_rst, q);

   always @(posedge wb_clk)
     if (q != q_r) begin
	$display("%0t : q is %s", $time, q ? "ON" : "OFF");
	q_r <= q;
     end

endmodule
