module servant_qf
  (
   input wire  i_rst_n,
   output wire o_uart_tx);

   reg 	       rst_r;

   wire        i_clk;
   wire        i_rst;
   wire        clk;
//   wire        rst;

//   parameter memfile = "zephyr_hello.hex";
   parameter memfile = "blinky.hex";
   parameter memsize = 2048;

   qlal4s3b_cell_macro u_qlal4s3b_cell_macro
     (
      .Sys_Clk0     (i_clk),
      .Sys_Clk0_Rst (i_rst),
      .Sys_Clk1     (),
      .Sys_Clk1_Rst ());

   gclkbuff u_gclkbuff_clock0 (.A(i_clk), .Z(clk));
//   gclkbuff u_gclkbuff_reset0 (.A(i_rst), .Z(rst));

   wire        o_uart_tx = q;

   reg 	       rst;

   always @(posedge clk)
     rst <= !i_rst_n;

   servant
     #(.memfile (memfile),
       .memsize (memsize))
   servant
     (.wb_clk (clk),
      .wb_rst (rst),
      .q      (q));

endmodule
