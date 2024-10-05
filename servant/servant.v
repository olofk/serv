`default_nettype none
module servant
(
 input wire  wb_clk,
 input wire  wb_rst,
 output wire q);

   parameter memfile = "zephyr_hello.hex";
   parameter memsize = 8192;
   parameter reset_strategy = "MINI";
   parameter width = 1;
   parameter sim = 0;
   parameter with_csr = 1;
   parameter [0:0] compress = 0;
   parameter [0:0] align = compress;


`ifdef MDU
   localparam [0:0] with_mdu = 1'b1;
`else
   localparam [0:0] with_mdu = 1'b0;
`endif

   localparam	   aw = $clog2(memsize);
   localparam	   csr_regs = with_csr*4;

   localparam	   rf_width = width * 2;
   localparam	   rf_l2d   = $clog2((32+csr_regs)*32/rf_width);

   wire 	timer_irq;


   wire [31:0] 	wb_mem_adr;
   wire [31:0] 	wb_mem_dat;
   wire [3:0] 	wb_mem_sel;
   wire 	wb_mem_we;
   wire 	wb_mem_stb;
   wire [31:0] 	wb_mem_rdt;
   wire 	wb_mem_ack;

   wire 	wb_gpio_dat;
   wire 	wb_gpio_we;
   wire 	wb_gpio_stb;
   wire 	wb_gpio_rdt;

   wire [31:0] 	wb_timer_dat;
   wire 	wb_timer_we;
   wire 	wb_timer_stb;
   wire [31:0] 	wb_timer_rdt;

   wire [31:0]	   wb_ext_adr;
   wire [31:0]	   wb_ext_dat;
   wire [3:0]	   wb_ext_sel;
   wire		   wb_ext_we;
   wire		   wb_ext_stb;
   wire [31:0]	   wb_ext_rdt;
   wire		   wb_ext_ack;

   wire [rf_l2d-1:0]   rf_waddr;
   wire [rf_width-1:0] rf_wdata;
   wire		       rf_wen;
   wire [rf_l2d-1:0]   rf_raddr;
   wire		       rf_ren;
   wire [rf_width-1:0] rf_rdata;

   servant_mux servant_mux
     (
      .i_clk (wb_clk),
      .i_rst (wb_rst & (reset_strategy != "NONE")),
      .i_wb_cpu_adr (wb_ext_adr),
      .i_wb_cpu_dat (wb_ext_dat),
      .i_wb_cpu_sel (wb_ext_sel),
      .i_wb_cpu_we  (wb_ext_we),
      .i_wb_cpu_cyc (wb_ext_stb),
      .o_wb_cpu_rdt (wb_ext_rdt),
      .o_wb_cpu_ack (wb_ext_ack),

      .o_wb_gpio_dat (wb_gpio_dat),
      .o_wb_gpio_we  (wb_gpio_we),
      .o_wb_gpio_cyc (wb_gpio_stb),
      .i_wb_gpio_rdt (wb_gpio_rdt),

      .o_wb_timer_dat (wb_timer_dat),
      .o_wb_timer_we  (wb_timer_we),
      .o_wb_timer_cyc (wb_timer_stb),
      .i_wb_timer_rdt (wb_timer_rdt));

   servant_ram
     #(.memfile (memfile),
       .depth (memsize),
       .RESET_STRATEGY (reset_strategy))
   ram
     (// Wishbone interface
      .i_wb_clk (wb_clk),
      .i_wb_rst (wb_rst),
      .i_wb_adr (wb_mem_adr[$clog2(memsize)-1:2]),
      .i_wb_cyc (wb_mem_stb),
      .i_wb_we  (wb_mem_we) ,
      .i_wb_sel (wb_mem_sel),
      .i_wb_dat (wb_mem_dat),
      .o_wb_rdt (wb_mem_rdt),
      .o_wb_ack (wb_mem_ack));

   servant_timer
     #(.RESET_STRATEGY (reset_strategy),
       .WIDTH (32))
   timer
     (.i_clk    (wb_clk),
      .i_rst    (wb_rst),
      .o_irq    (timer_irq),
      .i_wb_cyc (wb_timer_stb),
      .i_wb_we  (wb_timer_we) ,
      .i_wb_dat (wb_timer_dat),
      .o_wb_dat (wb_timer_rdt));

   servant_gpio gpio
     (.i_wb_clk (wb_clk),
      .i_wb_dat (wb_gpio_dat),
      .i_wb_we  (wb_gpio_we),
      .i_wb_cyc (wb_gpio_stb),
      .o_wb_rdt (wb_gpio_rdt),
      .o_gpio   (q));

   serv_rf_ram
     #(.width (rf_width),
       .csr_regs (csr_regs))
   rf_ram
     (.i_clk    (wb_clk),
      .i_waddr  (rf_waddr),
      .i_wdata  (rf_wdata),
      .i_wen    (rf_wen),
      .i_raddr  (rf_raddr),
      .i_ren    (rf_ren),
      .o_rdata  (rf_rdata));

   servile
     #(.width    (width),
       .sim      (sim[0]),
       .with_c   (compress[0]),
       .with_csr (with_csr[0]),
       .with_mdu (with_mdu))
   cpu
     (
      .i_clk        (wb_clk),
      .i_rst        (wb_rst),
      .i_timer_irq  (timer_irq),

      .o_wb_mem_adr   (wb_mem_adr),
      .o_wb_mem_dat   (wb_mem_dat),
      .o_wb_mem_sel   (wb_mem_sel),
      .o_wb_mem_we    (wb_mem_we),
      .o_wb_mem_stb   (wb_mem_stb),
      .i_wb_mem_rdt   (wb_mem_rdt),
      .i_wb_mem_ack   (wb_mem_ack),

      .o_wb_ext_adr   (wb_ext_adr),
      .o_wb_ext_dat   (wb_ext_dat),
      .o_wb_ext_sel   (wb_ext_sel),
      .o_wb_ext_we    (wb_ext_we),
      .o_wb_ext_stb   (wb_ext_stb),
      .i_wb_ext_rdt   (wb_ext_rdt),
      .i_wb_ext_ack   (wb_ext_ack),

      .o_rf_waddr  (rf_waddr),
      .o_rf_wdata  (rf_wdata),
      .o_rf_wen    (rf_wen),
      .o_rf_raddr  (rf_raddr),
      .o_rf_ren    (rf_ren),
      .i_rf_rdata  (rf_rdata));

endmodule
