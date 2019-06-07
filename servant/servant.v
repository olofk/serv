`default_nettype none
module servant
(
 input wire  wb_clk,
 input wire  wb_rst,
 output wire q);

   parameter memfile = "zephyr_hello.hex";
   parameter memsize = 8192;

   wire 	timer_irq;

   wire [31:0] 	wb_cpu_ibus_adr;
   wire 	wb_cpu_ibus_cyc;
   wire [31:0] 	wb_cpu_ibus_rdt;
   wire 	wb_cpu_ibus_ack;

   wire [31:0] 	wb_cpu_dbus_adr;
   wire [31:0] 	wb_cpu_dbus_dat;
   wire [3:0] 	wb_cpu_dbus_sel;
   wire 	wb_cpu_dbus_we;
   wire 	wb_cpu_dbus_cyc;
   wire [31:0] 	wb_cpu_dbus_rdt;
   wire 	wb_cpu_dbus_ack;

   wire [31:0] 	wb_cpu_adr;
   wire [31:0] 	wb_cpu_dat;
   wire [3:0] 	wb_cpu_sel;
   wire 	wb_cpu_we;
   wire 	wb_cpu_cyc;
   wire [31:0] 	wb_cpu_rdt;
   wire 	wb_cpu_ack;

   wire [31:0] 	wb_mem_adr;
   wire [31:0] 	wb_mem_dat;
   wire [3:0] 	wb_mem_sel;
   wire 	wb_mem_we;
   wire 	wb_mem_cyc;
   wire [31:0] 	wb_mem_rdt;
   wire 	wb_gpio_dat;
   wire 	wb_gpio_cyc;
   wire [31:0] 	wb_timer_dat;
   wire 	wb_timer_we;
   wire 	wb_timer_cyc;
   wire [31:0] 	wb_timer_rdt;

serv_arbiter serv_arbiter
   (
    .i_ibus_active (wb_cpu_ibus_cyc),
    .i_wb_cpu_dbus_adr (wb_cpu_dbus_adr),
    .i_wb_cpu_dbus_dat (wb_cpu_dbus_dat),
    .i_wb_cpu_dbus_sel (wb_cpu_dbus_sel),
    .i_wb_cpu_dbus_we  (wb_cpu_dbus_we ),
    .i_wb_cpu_dbus_cyc (wb_cpu_dbus_cyc),
    .o_wb_cpu_dbus_rdt (wb_cpu_dbus_rdt),
    .o_wb_cpu_dbus_ack (wb_cpu_dbus_ack),

    .i_wb_cpu_ibus_adr (wb_cpu_ibus_adr),
    .i_wb_cpu_ibus_cyc (wb_cpu_ibus_cyc),
    .o_wb_cpu_ibus_rdt (wb_cpu_ibus_rdt),
    .o_wb_cpu_ibus_ack (wb_cpu_ibus_ack),

    .o_wb_cpu_adr (wb_cpu_adr),
    .o_wb_cpu_dat (wb_cpu_dat),
    .o_wb_cpu_sel (wb_cpu_sel),
    .o_wb_cpu_we  (wb_cpu_we ),
    .o_wb_cpu_cyc (wb_cpu_cyc),
    .i_wb_cpu_rdt (wb_cpu_rdt),
    .i_wb_cpu_ack (wb_cpu_ack));


`ifdef VERILATOR
   parameter sim = 1;
`else
   parameter sim = 0;
`endif
   serv_mux #(sim) serv_mux
  (
   .i_clk (wb_clk),
   .i_rst (wb_rst),
   .i_wb_cpu_adr (wb_cpu_adr),
   .i_wb_cpu_dat (wb_cpu_dat),
   .i_wb_cpu_sel (wb_cpu_sel),
   .i_wb_cpu_we  (wb_cpu_we),
   .i_wb_cpu_cyc (wb_cpu_cyc),
   .o_wb_cpu_rdt (wb_cpu_rdt),
   .o_wb_cpu_ack (wb_cpu_ack),

   .o_wb_mem_adr (wb_mem_adr),
   .o_wb_mem_dat (wb_mem_dat),
   .o_wb_mem_sel (wb_mem_sel),
   .o_wb_mem_we  (wb_mem_we),
   .o_wb_mem_cyc (wb_mem_cyc),
   .i_wb_mem_rdt (wb_mem_rdt),

   .o_wb_gpio_dat (wb_gpio_dat),
   .o_wb_gpio_cyc (wb_gpio_cyc),

   .o_wb_timer_dat (wb_timer_dat),
   .o_wb_timer_we  (wb_timer_we),
   .o_wb_timer_cyc (wb_timer_cyc),
   .i_wb_timer_rdt (wb_timer_rdt));

`ifndef SYNTHESIS
//synthesis translate_off
   reg [1023:0] firmware_file;
   initial
     if ($value$plusargs("firmware=%s", firmware_file)) begin
	$display("Loading RAM from %0s", firmware_file);
	$readmemh(firmware_file, ram.ram0.mem);
     end
//synthesis translate_on
`endif

   wb_ram
     #(
`ifdef SYNTHESIS
.memfile (memfile),
`endif
       .depth (memsize))
   ram
     (// Wishbone interface
      .wb_clk_i (wb_clk),
      .wb_adr_i (wb_mem_adr[$clog2(memsize)-1:0]),
      .wb_cyc_i (wb_mem_cyc),
      .wb_we_i  (wb_mem_we) ,
      .wb_sel_i (wb_mem_sel),
      .wb_dat_i (wb_mem_dat),
      .wb_dat_o (wb_mem_rdt));

   riscv_timer riscv_timer
     (.i_clk    (wb_clk),
      .i_rst    (wb_rst),
      .o_irq    (timer_irq),
      .i_wb_cyc (wb_timer_cyc),
      .i_wb_we  (wb_timer_we) ,
      .i_wb_dat (wb_timer_dat),
      .o_wb_dat (wb_timer_rdt));

   wb_gpio gpio
     (.i_wb_clk (wb_clk),
      .i_wb_dat (wb_gpio_dat),
      .i_wb_cyc (wb_gpio_cyc),
      .o_gpio   (q));

   serv_top
     #(.RESET_PC (32'h0000_0000))
   cpu
     (
      .clk      (wb_clk),
      .i_rst    (wb_rst),
      .i_timer_irq  (timer_irq),
`ifdef RISCV_FORMAL
      .rvfi_valid     (),
      .rvfi_order     (),
      .rvfi_insn      (),
      .rvfi_trap      (),
      .rvfi_halt      (),
      .rvfi_intr      (),
      .rvfi_mode      (),
      .rvfi_rs1_addr  (),
      .rvfi_rs2_addr  (),
      .rvfi_rs1_rdata (),
      .rvfi_rs2_rdata (),
      .rvfi_rd_addr   (),
      .rvfi_rd_wdata  (),
      .rvfi_pc_rdata  (),
      .rvfi_pc_wdata  (),
      .rvfi_mem_addr  (),
      .rvfi_mem_rmask (),
      .rvfi_mem_wmask (),
      .rvfi_mem_rdata (),
      .rvfi_mem_wdata (),
`endif

      .o_ibus_adr   (wb_cpu_ibus_adr),
      .o_ibus_cyc   (wb_cpu_ibus_cyc),
      .i_ibus_rdt   (wb_cpu_ibus_rdt),
      .i_ibus_ack   (wb_cpu_ibus_ack),

      .o_dbus_adr   (wb_cpu_dbus_adr),
      .o_dbus_dat   (wb_cpu_dbus_dat),
      .o_dbus_sel   (wb_cpu_dbus_sel),
      .o_dbus_we    (wb_cpu_dbus_we),
      .o_dbus_cyc   (wb_cpu_dbus_cyc),
      .i_dbus_rdt   (wb_cpu_dbus_rdt),
      .i_dbus_ack   (wb_cpu_dbus_ack));

endmodule
