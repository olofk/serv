`default_nettype none
module service_go_board
  (input wire  i_clk,
   output wire o_led1,
   output wire o_led2 = 1'b0,
   output wire o_led3 = 1'b0,
   output wire o_led4 = 1'b0);

   parameter memfile = "blinky.hex";
   parameter memsize = 512;

   // Assert reset for 64 clock cycles. Use the 7th bit as the reset signal.
   reg [6:0]      rst_count;
   wire           rst_r = !rst_count[6];

   always @(posedge i_clk) begin
    if (rst_r == 1) begin
      rst_count <= rst_count + 1;
    end
   end

   servant
     #(.memfile (memfile),
       .memsize (memsize))
   servant
     (.wb_clk (i_clk),
      .wb_rst (rst_r),
      .q      (o_led1));

endmodule
