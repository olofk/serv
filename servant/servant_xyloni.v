`default_nettype none
module servant_xyloni
(
 input wire  i_clk,
 input wire  i_pll_locked,
 input wire  i_rst,
 output wire o_uart_tx,
 output wire l2,
 output wire l3,
 output wire l4,
 output wire q);

   assign l4 = i_pll_locked;
   assign l3 = i_rst;

   parameter memfile = "zephyr_hello.hex";
   parameter memsize = 8192;

   wire      wb_clk;
   wire      wb_rst;

reg [3:0] rstreg = 4'b1111;

always @(posedge i_clk) begin
    if (i_pll_locked) rstreg <= {rstreg[2:0],~i_rst};
    else rstreg <= 4'b1111;
end

   assign o_uart_tx = q;
   assign wb_clk = i_clk;
   assign wb_rst = i_rst;

   reg [27:0] cnt = 28'd0;
   always @(posedge i_clk) cnt <= cnt + 28'd1;

   assign l2 = cnt[21];
     
   servant
     #(.memfile (memfile),
       .memsize (memsize))
   servant
     (.wb_clk (wb_clk),
      .wb_rst (wb_rst),
      .q      (q));

endmodule
