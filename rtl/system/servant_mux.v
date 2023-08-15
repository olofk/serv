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
   // From CPU
   input wire [31:0]  i_wb_cpu_adr,
   input wire [31:0]  i_wb_cpu_dat,
   input wire [3:0]   i_wb_cpu_sel,
   input wire 	      i_wb_cpu_we,
   input wire 	      i_wb_cpu_cyc,
   output wire [31:0] o_wb_cpu_rdt,
   output reg 	      o_wb_cpu_ack,
   // To data memory (RAM + DBG)
   output wire [31:0] o_wb_mem_adr,
   output wire [31:0] o_wb_mem_dat,
   output wire [3:0]  o_wb_mem_sel,
   output wire 	      o_wb_mem_we,
   output wire 	      o_wb_mem_cyc,
   input wire [31:0]  i_wb_mem_rdt,
   // To GPIO
   output wire 	      o_wb_gpio_dat,
   output wire 	      o_wb_gpio_we,
   output wire 	      o_wb_gpio_cyc,
   input wire 	      i_wb_gpio_rdt,
   // To timer
   output wire [31:0] o_wb_timer_dat,
   output wire 	      o_wb_timer_we,
   output wire 	      o_wb_timer_cyc,
   input wire [31:0]  i_wb_timer_rdt,
   // To SPI programmer
   output wire [31:0] o_wb_flash_adr,
   output wire [31:0] o_wb_flash_dat,
   output wire [3:0]  o_wb_flash_sel,
   output wire 	      o_wb_flash_we,
   output wire 	      o_wb_flash_cyc,
   input wire [31:0]  i_wb_flash_rdt
);
        
   wire [2:0] 	  s = i_wb_cpu_adr[31:29];

   assign o_wb_cpu_rdt = (s == 3'b100) ? {31'd0,i_wb_gpio_rdt} :
                         (s == 3'b101) ? i_wb_timer_rdt: 
			             (s == 3'b110) ? i_wb_flash_rdt: 
			             i_wb_mem_rdt;
			 
   always @(posedge i_clk) begin
      
      if (i_rst) o_wb_cpu_ack <= 1'b0;
      else o_wb_cpu_ack <= i_wb_cpu_cyc & !o_wb_cpu_ack;
      
//      o_wb_cpu_ack <= 1'b0;
//      if (i_wb_cpu_cyc & !o_wb_cpu_ack)
//	o_wb_cpu_ack <= 1'b1;
//      if (i_rst)
//	o_wb_cpu_ack <= 1'b0;
   end

   assign o_wb_mem_adr = i_wb_cpu_adr;
   assign o_wb_mem_dat = i_wb_cpu_dat;
   assign o_wb_mem_sel = i_wb_cpu_sel;
   assign o_wb_mem_we  = i_wb_cpu_we;
   assign o_wb_mem_cyc = i_wb_cpu_cyc & ((~s[2]) | (s == 3'b111));

   assign o_wb_gpio_dat = i_wb_cpu_dat[0];
   assign o_wb_gpio_we  = i_wb_cpu_we;
   assign o_wb_gpio_cyc = i_wb_cpu_cyc & (s == 3'b100);

   assign o_wb_timer_dat = i_wb_cpu_dat;
   assign o_wb_timer_we  = i_wb_cpu_we;
   assign o_wb_timer_cyc = i_wb_cpu_cyc & (s == 3'b101);
   
   assign o_wb_flash_adr = i_wb_cpu_adr;
   assign o_wb_flash_dat = i_wb_cpu_dat;
   assign o_wb_flash_sel = i_wb_cpu_sel;
   assign o_wb_flash_we  = i_wb_cpu_we;
   assign o_wb_flash_cyc = i_wb_cpu_cyc & (s == 3'b110);
   
endmodule
