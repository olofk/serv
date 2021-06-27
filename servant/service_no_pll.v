`default_nettype none
module service
  (input wire  i_clk,
   output wire q);

   parameter memfile = "zephyr_hello.hex";
   parameter memsize = 7168;

   // Pull reset high for 64 clock cycles. Use the 7th bit as the reset signal.
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
      .q      (q));

endmodule
