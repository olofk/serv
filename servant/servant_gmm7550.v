`timescale 1ns / 1ps

module servant_gmm7550(
                       input wire  ser_clk,
                       output wire led_green,
                       output wire led_red_n,
                       output wire uart_tx);

   // parameter memfile = "zephyr_hello.hex";
   parameter memfile = "blinky.hex";
   parameter memsize = 8192;

   wire      clk270, clk180, clk90, clk0, usr_ref_out;
   wire      usr_pll_lock_stdy, usr_pll_lock;

   wire      usr_rstn;
   reg[4:0]  rst;

   wire      sys_clk;
   wire      sys_rst;
   wire      sys_rst_n;
   wire      q;

   assign led_red_n = 1'b1;
   assign led_green = q;
   assign uart_tx   = q;

   CC_PLL #(
            .REF_CLK("100.0"),   // reference input in MHz
            .OUT_CLK("32.0"),    // pll output frequency in MHz
            .PERF_MD("SPEED"),   // LOWPOWER, ECONOMY, SPEED
            .LOCK_REQ(1),        // Lock status required before PLL output enable
            .LOW_JITTER(1),      // 0: disable, 1: enable low jitter mode
            .CI_FILTER_CONST(2), // optional CI filter constant
            .CP_FILTER_CONST(4)  // optional CP filter constant
            ) pll_inst (
                        .CLK_REF(ser_clk), .CLK_FEEDBACK(1'b0), .USR_CLK_REF(1'b0),
                        .USR_LOCKED_STDY_RST(1'b0), .USR_PLL_LOCKED_STDY(usr_pll_lock_stdy), .USR_PLL_LOCKED(usr_pll_lock),
                        .CLK270(clk270), .CLK180(clk180), .CLK90(clk90), .CLK0(clk0), .CLK_REF_OUT(usr_ref_out)
                        );

   assign sys_clk = clk0;

   CC_USR_RSTN usr_rst_inst
     (.USR_RSTN(usr_rstn));

   always @(posedge sys_clk or negedge usr_rstn)
     begin
        if (!usr_rstn) begin
           rst <= 5'b01111;
        end else begin
          if (usr_pll_lock) begin
            if (!rst[4]) begin
              rst <= rst - 1;
            end else begin
              rst <= rst;
            end
          end else begin
            rst <= 5'b01111;
          end
        end
     end

   assign sys_rst = !rst[4];
   assign sys_rst_n = rst[4];

   servant
     #(.memfile (memfile),
       .memsize (memsize))
   servant
     (.wb_clk (sys_clk),
      .wb_rst (sys_rst),
      .q      (q));

endmodule
