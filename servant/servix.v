`default_nettype none
module servix
(
 input wire  i_clk,
`ifdef WITH_RESET
 input wire  i_rst_n,
`endif
 output wire q);

   parameter frequency = 32;
   parameter memfile = "zephyr_hello.hex";
   parameter memsize = 8192;
   parameter PLL = "NONE";

   wire      wb_clk;
   wire      wb_rst;

   servix_clock_gen
     #(.frequency (frequency))
   clock_gen
     (.i_clk (i_clk),
`ifdef WITH_RESET
      .i_rst (!i_rst_n),
`else
      .i_rst (1'b0),
`endif
      .o_clk (wb_clk),
      .o_rst (wb_rst));

   servant
     #(.memfile (memfile),
       .memsize (memsize))
   servant
     (.wb_clk (wb_clk),
      .wb_rst (wb_rst),
      .q      (q));

endmodule
