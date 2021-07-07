/*
 mem = 00
 gpio = 01
 timer = 10
 testcon = 11
 */
module servant_mux
  (
   input wire         i_clk,
   input wire         i_rst,
   input wire [31:0]  i_wb_cpu_adr,
   input wire [31:0]  i_wb_cpu_dat,
   input wire [3:0]   i_wb_cpu_sel,
   input wire         i_wb_cpu_we,
   input wire         i_wb_cpu_cyc,
   output wire [31:0] o_wb_cpu_rdt,
   output reg         o_wb_cpu_ack,

   output wire [31:0] o_wb_mem_adr,
   output wire [31:0] o_wb_mem_dat,
   output wire [3:0]  o_wb_mem_sel,
   output wire        o_wb_mem_we,
   output wire        o_wb_mem_cyc,
   input wire [31:0]  i_wb_mem_rdt,

   output wire        o_wb_gpio_dat,
   output wire        o_wb_gpio_we,
   output wire        o_wb_gpio_cyc,
   input wire         i_wb_gpio_rdt,

   output wire [31:0] o_wb_timer_dat,
   output wire        o_wb_timer_we,
   output wire        o_wb_timer_cyc,
   input wire [31:0]  i_wb_timer_rdt);

   parameter sim = 0;

   wire [1:0]     s = i_wb_cpu_adr[31:30];

   assign o_wb_cpu_rdt = s[1] ? i_wb_timer_rdt :
                         s[0] ? {31'd0,i_wb_gpio_rdt} : i_wb_mem_rdt;
   always @(posedge i_clk) begin
      o_wb_cpu_ack <= 1'b0;
      if (i_wb_cpu_cyc & !o_wb_cpu_ack)
        o_wb_cpu_ack <= 1'b1;
      if (i_rst)
        o_wb_cpu_ack <= 1'b0;
   end

   assign o_wb_mem_adr = i_wb_cpu_adr;
   assign o_wb_mem_dat = i_wb_cpu_dat;
   assign o_wb_mem_sel = i_wb_cpu_sel;
   assign o_wb_mem_we  = i_wb_cpu_we;
   assign o_wb_mem_cyc = i_wb_cpu_cyc & (s == 2'b00);

   assign o_wb_gpio_dat = i_wb_cpu_dat[0];
   assign o_wb_gpio_we  = i_wb_cpu_we;
   assign o_wb_gpio_cyc = i_wb_cpu_cyc & (s == 2'b01);

   assign o_wb_timer_dat = i_wb_cpu_dat;
   assign o_wb_timer_we  = i_wb_cpu_we;
   assign o_wb_timer_cyc = i_wb_cpu_cyc & s[1];

   generate
      if (sim) begin
         wire sig_en = (i_wb_cpu_adr[31:28] == 4'h8) & i_wb_cpu_cyc & o_wb_cpu_ack;
         wire halt_en = (i_wb_cpu_adr[31:28] == 4'h9) & i_wb_cpu_cyc & o_wb_cpu_ack;

         reg [1023:0] signature_file;
         integer      f = 0;

         initial
       /* verilator lint_off WIDTH */
           if ($value$plusargs("signature=%s", signature_file)) begin
              $display("Writing signature to %0s", signature_file);
              f = $fopen(signature_file, "w");
           end
       /* verilator lint_on WIDTH */

         always @(posedge i_clk)
            if (sig_en & (f != 0))
              $fwrite(f, "%c", i_wb_cpu_dat[7:0]);
            else if(halt_en) begin
               $display("Test complete");
               $finish;
            end
      end
   endgenerate
endmodule
