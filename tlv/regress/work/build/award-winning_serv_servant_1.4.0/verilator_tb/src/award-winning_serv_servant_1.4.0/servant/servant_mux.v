/*
 mem = 00
 gpio = 01
 timer = 10
 testcon = 11
 */
module servant_mux
  (
   input wire 	      i_clk,
   input wire 	      i_rst,
   input wire [31:0]  i_wb_cpu_adr,
   input wire [31:0]  i_wb_cpu_dat,
   input wire [3:0]   i_wb_cpu_sel,
   input wire 	      i_wb_cpu_we,
   input wire 	      i_wb_cpu_cyc,
   output wire [31:0] o_wb_cpu_rdt,
   output reg 	      o_wb_cpu_ack,

   output wire 	      o_wb_gpio_dat,
   output wire 	      o_wb_gpio_we,
   output wire 	      o_wb_gpio_cyc,
   input wire 	      i_wb_gpio_rdt,

   output wire [31:0] o_wb_timer_dat,
   output wire 	      o_wb_timer_we,
   output wire 	      o_wb_timer_cyc,
   input wire [31:0]  i_wb_timer_rdt);

   parameter sim = 0;

   wire [1:0] 	  s = i_wb_cpu_adr[31:30];

   assign o_wb_cpu_rdt = s[1] ? i_wb_timer_rdt : {31'd0,i_wb_gpio_rdt};

   always @(posedge i_clk) begin
      o_wb_cpu_ack <= 1'b0;
      if (i_wb_cpu_cyc & !o_wb_cpu_ack)
	o_wb_cpu_ack <= 1'b1;
      if (i_rst)
	o_wb_cpu_ack <= 1'b0;
   end

   assign o_wb_gpio_dat = i_wb_cpu_dat[0];
   assign o_wb_gpio_we  = i_wb_cpu_we;
   assign o_wb_gpio_cyc = i_wb_cpu_cyc & !s[1];

   assign o_wb_timer_dat = i_wb_cpu_dat;
   assign o_wb_timer_we  = i_wb_cpu_we;
   assign o_wb_timer_cyc = i_wb_cpu_cyc & s[1];

endmodule
