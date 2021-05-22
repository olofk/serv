`default_nettype none
module servant_orangecrab
(
 input wire  clk,
 input wire btn,
 output wire r,
 output wire g,
 output wire b,
 output wire tx
);

   parameter memfile = "zephyr_hello.hex";
   parameter memsize = 8192;

   wire      wb_clk;
   wire      pll_locked;
    EHXPLLL #(
        .CLKI_DIV(6),
        .CLKFB_DIV(4),
        .CLKOP_DIV(15),
        .CLKOS_DIV(8),
        .CLKOS2_DIV(8),
        .CLKOS3_DIV(8),
        .CLKOP_ENABLE("ENABLED"),
        .CLKOS_ENABLE("DISABLED"),
        .CLKOS2_ENABLE("DISABLED"),
        .CLKOS3_ENABLE("DISABLED"),
        .CLKOP_CPHASE(0),
        .CLKOS_CPHASE(0),
        .CLKOS2_CPHASE(0),
        .CLKOS3_CPHASE(0),
        .CLKOP_FPHASE(0),
        .CLKOS_FPHASE(0),
        .CLKOS2_FPHASE(0),
        .CLKOS3_FPHASE(0),
        .FEEDBK_PATH("CLKOP"),
        .CLKOP_TRIM_POL("RISING"),
        .CLKOP_TRIM_DELAY(0),
        .CLKOS_TRIM_POL("RISING"),
        .CLKOS_TRIM_DELAY(0),
        .OUTDIVIDER_MUXA("DIVA"),
        .OUTDIVIDER_MUXB("DIVB"),
        .OUTDIVIDER_MUXC("DIVC"),
        .OUTDIVIDER_MUXD("DIVD"),
        .PLL_LOCK_MODE(0),
        .PLL_LOCK_DELAY(200),
        .STDBY_ENABLE("DISABLED"),
        .REFIN_RESET("DISABLED"),
        .SYNC_ENABLE("DISABLED"),
        .INT_LOCK_STICKY("ENABLED"),
        .DPHASE_SOURCE("DISABLED"),
        .PLLRST_ENA("DISABLED"),
        .INTFB_WAKE("DISABLED")
    ) uPLL (
        .CLKI(clk),         // ref input
        .CLKFB(wb_clk),     // ext fb input
        .PHASESEL1(0),      // msbit phs adj select
        .PHASESEL0(0),      // lsbit phs adj select
        .PHASEDIR(0),       // phs adj dir
        .PHASESTEP(0),      // phs adj step
        .PHASELOADREG(0),   // load phs adj
        .STDBY(0),          // power down pll
        .PLLWAKESYNC(0),    // int/ext fb switching @ wakeup
        .RST(0),            // pll reset
        .ENCLKOP(1),        // primary output enable
        .ENCLKOS(0),        // secondary output enable
        .ENCLKOS2(0),       // secondary output enable
        .ENCLKOS3(0),       // secondary output enable
        .CLKOP(wb_clk),     // primary output
        .CLKOS(),           // secondary output
        .CLKOS2(),          // secondary output
        .CLKOS3(),          // secondary output
        .LOCK(pll_locked),  // lock indicator
        .INTLOCK(),         // internal lock indictor
        .REFCLK(),          // output of ref select mux
        .CLKINTFB()         // internal fb
    );

   reg wb_rst;
   always @(posedge wb_clk)
       wb_rst <= ~pll_locked;

   wire q;
   servant
     #(.memfile (memfile),
       .memsize (memsize))
   servant
     (.wb_clk (wb_clk),
      .wb_rst (wb_rst),
      .q      (q));

   assign r = q;
   assign g = q;
   assign b = q;
   assign tx = q;
endmodule
