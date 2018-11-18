`default_nettype none
module serv_top_tb;

   parameter memfile = "bitbang.hex";

   reg wb_clk = 1'b1;

   reg q_r = 1'b0;
   wire q;

   always #31 wb_clk <= !wb_clk;

   vlog_tb_utils vtu();

   serv_wrapper #(memfile) dut(wb_clk, q);

   always @(posedge wb_clk)
     if (q != q_r) begin
	$display("%0t : q is %s", $time, q ? "ON" : "OFF");
	q_r <= q;
     end

endmodule
