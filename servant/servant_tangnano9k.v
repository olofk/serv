`default_nettype none
//
// Servant SoC on the Sipeed Tang Nano 9K (Gowin GW1NR-LV9QN88PC6/I5).
//
// Version 0.4.0
//
// The core runs directly off the 27 MHz board oscillator. No PLL.
//
// Consequence for the Zephyr images: their UART is bit-banged and calibrated
// for 32 MHz, so at 27 MHz the line rate scales to 115200 * 27/32 = 97200
// baud. Set the terminal to 97200. blinky.hex is unaffected.
//
// Servant exposes a single output bit, q, driven by its GPIO peripheral.
// blinky.hex toggles it slowly; the Zephyr images bit-bang the UART on it.
// Both are wired out here: q goes to LED0 and to the UART TX pin that the
// on-board BL702 bridges to USB.
//
// Only LED0 (pin 10) is used. LED4 and LED5 sit on pins 15 and 16, which are
// in Bank 3; that bank is locked to 1.8V by the PSRAM, so constraining them
// as LVCMOS33 is rejected outright. Since servant only drives one bit there
// is no reason to touch that bank at all.
//
// The board LED is active low, hence the inversion.
//
module servant_tangnano9k
  #(parameter memfile = "blinky.hex",
    parameter memsize = 8192)
   (input wire  i_clk,     // pin 52, 27 MHz
    input wire  i_rst_n,   // pin 4, button S1, active low
    output wire o_uart_tx, // pin 17, to BL702 USB-UART
    output wire o_led);    // pin 10, active low

   wire        q;

   // Synchronise the button into the clock domain, then hold reset for 32
   // further clocks so the RAM and register file settle before fetch starts.
   reg [1:0]   rst_n_sync = 2'b00;
   reg [5:0]   rst_cnt    = 6'd0;

   always @(posedge i_clk) begin
      rst_n_sync <= {rst_n_sync[0], i_rst_n};

      if (!rst_n_sync[1])
        rst_cnt <= 6'd0;
      else if (!rst_cnt[5])
        rst_cnt <= rst_cnt + 6'd1;
   end

   servant
     #(.memfile (memfile),
       .memsize (memsize))
   servant
     (.wb_clk (i_clk),
      .wb_rst (!rst_cnt[5]),
      .q      (q));

   assign o_uart_tx = q;
   assign o_led     = ~q;

endmodule
`default_nettype wire
