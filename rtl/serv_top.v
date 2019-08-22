`default_nettype none

module serv_top
  (
   input wire 	      clk,
   input wire 	      i_rst,
   input wire 	      i_timer_irq,
`ifdef RISCV_FORMAL
   output reg 	      rvfi_valid = 1'b0,
   output reg [63:0]  rvfi_order = 64'd0,
   output reg [31:0]  rvfi_insn = 32'd0,
   output reg 	      rvfi_trap = 1'b0,
   output reg 	      rvfi_halt = 1'b0,
   output reg 	      rvfi_intr = 1'b0,
   output reg [1:0]   rvfi_mode = 2'b11,
   output reg [1:0]   rvfi_ixl = 2'b01,
   output reg [4:0]   rvfi_rs1_addr,
   output reg [4:0]   rvfi_rs2_addr,
   output reg [31:0]  rvfi_rs1_rdata,
   output reg [31:0]  rvfi_rs2_rdata,
   output reg [4:0]   rvfi_rd_addr,
   output reg [31:0]  rvfi_rd_wdata,
   output reg [31:0]  rvfi_pc_rdata,
   output reg [31:0]  rvfi_pc_wdata,
   output reg [31:0]  rvfi_mem_addr,
   output reg [3:0]   rvfi_mem_rmask,
   output reg [3:0]   rvfi_mem_wmask,
   output reg [31:0]  rvfi_mem_rdata,
   output reg [31:0]  rvfi_mem_wdata,
`endif
   output wire [31:0] o_ibus_adr,
   output wire 	      o_ibus_cyc,
   input wire [31:0]  i_ibus_rdt,
   input wire 	      i_ibus_ack,
   output wire [31:0] o_dbus_adr,
   output wire [31:0] o_dbus_dat,
   output wire [3:0]  o_dbus_sel,
   output wire 	      o_dbus_we ,
   output wire 	      o_dbus_cyc,
   input wire [31:0]  i_dbus_rdt,
   input wire 	      i_dbus_ack);

`include "serv_params.vh"

   wire [4:0]    rd_addr;
   wire [4:0]    rs1_addr;
   wire [4:0]    rs2_addr;

   wire 	 rd_alu_en;
   wire 	 rd_mem_en;
   wire          ctrl_rd;
   wire          alu_rd;
   wire          mem_rd;
   wire          csr_rd;
   wire          rd;

   wire          ctrl_pc_en;
   wire          jump;
   wire          jalr;
   wire          jal_or_jalr;
   wire          utype;
   wire 	 mret;
   wire          imm;
   wire 	 trap;
   wire 	 pc_rel;

   wire [4:0] 	 cnt;
   wire [3:0] 	 cnt_r;

   wire 	 cnt_done;
   wire [2:0]    funct3;

   wire 	 bufreg_hold;
   wire 	 bufreg_rs1_en;
   wire 	 bufreg_imm_en;
   wire 	 bufreg_loop;
   wire 	 bufreg_q;

   wire          alu_en;
   wire          alu_init;
   wire          alu_sub;
   wire [1:0] 	 alu_bool_op;
   wire          alu_cmp_eq;
   wire          alu_cmp_uns;
   wire          alu_cmp;
   wire          alu_shamt_en;
   wire          alu_sh_signed;
   wire          alu_sh_right;
   wire 	 alu_sh_done;
   wire [1:0]    alu_rd_sel;

   wire 	 rf_ready;
   wire          rs1;
   wire          rs2;
   wire 	 rs_en;
   wire          rd_en;

   wire          op_b_source;
   wire          op_b;

   wire          mem_en;

   wire          mem_cmd;
   wire [1:0] 	 mem_bytecnt;

   wire          mem_init;
   wire 	 mem_misalign;

   wire 	 bad_pc;

   wire 	 csr_mstatus_en;
   wire 	 csr_mie_en;
   wire 	 csr_mcause_en;
   wire [1:0]	 csr_source;
   wire 	 csr_imm;
   wire 	 csr_d_sel;
   wire 	 csr_en;
   wire [1:0] 	 csr_addr;

   wire [3:0] 	 mcause;

   parameter RESET_PC = 32'd8;

   wire 	 new_irq;

   serv_decode decode
     (
      .clk (clk),
      .i_rst          (i_rst),
      .i_new_irq      (new_irq),
      .i_wb_rdt       (i_ibus_rdt),
      .i_wb_en        (o_ibus_cyc & i_ibus_ack),
      .i_rf_ready     (rf_ready | i_dbus_ack),
      .o_cnt          (cnt),
      .o_cnt_r        (cnt_r),
      .o_cnt_done     (cnt_done),
      .o_bufreg_hold  (bufreg_hold),
      .o_bufreg_rs1_en (bufreg_rs1_en),
      .o_bufreg_imm_en (bufreg_imm_en),
      .o_bufreg_loop   (bufreg_loop),
      .o_ctrl_pc_en   (ctrl_pc_en),
      .o_ctrl_jump    (jump),
      .o_ctrl_jalr    (jalr),
      .o_ctrl_jal_or_jalr    (jal_or_jalr),
      .o_ctrl_utype   (utype),
      .o_ctrl_pc_rel  (pc_rel),
      .o_ctrl_trap    (trap),
      .o_ctrl_mret    (mret),
      .i_ctrl_misalign(lsb[1]),
      .o_funct3       (funct3),
      .o_alu_en       (alu_en),
      .o_alu_init     (alu_init),
      .o_alu_sub      (alu_sub),
      .o_alu_bool_op  (alu_bool_op),
      .o_alu_cmp_eq   (alu_cmp_eq),
      .o_alu_cmp_uns  (alu_cmp_uns),
      .i_alu_cmp      (alu_cmp),
      .o_alu_shamt_en (alu_shamt_en),
      .o_alu_sh_signed (alu_sh_signed),
      .o_alu_sh_right (alu_sh_right),
      .i_alu_sh_done  (alu_sh_done),
      .o_alu_rd_sel   (alu_rd_sel),
      .o_rf_rs_en     (rs_en),
      .o_rf_rd_en     (rd_en),
      .o_rf_rd_addr   (rd_addr),
      .o_rf_rs1_addr  (rs1_addr),
      .o_rf_rs2_addr  (rs2_addr),
      .o_mem_en       (mem_en),
      .o_mem_cmd      (mem_cmd),
      .o_mem_init     (mem_init),
      .o_mem_bytecnt  (mem_bytecnt),
      .i_mem_misalign (mem_misalign),
      .o_csr_en          (csr_en),
      .o_csr_addr        (csr_addr),
      .o_csr_mstatus_en  (csr_mstatus_en),
      .o_csr_mie_en      (csr_mie_en),
      .o_csr_mcause_en   (csr_mcause_en),
      .o_csr_source   (csr_source),
      .o_csr_mcause   (mcause),
      .o_csr_imm      (csr_imm),
      .o_csr_d_sel    (csr_d_sel),
      .o_imm          (imm),
      .o_op_b_source  (op_b_source),
      .o_rd_alu_en    (rd_alu_en),
      .o_rd_mem_en    (rd_mem_en));

   wire [1:0] 	 lsb;
   wire [31:0] 	 bufreg_out;
   assign o_dbus_adr = {bufreg_out[31:2], 2'b00};

   serv_bufreg bufreg
     (
      .i_clk    (clk),
      .i_rst    (i_rst),
      .i_cnt    (cnt[4:2]),
      .i_cnt_r  (cnt_r[1:0]),
      .i_en     (!(bufreg_hold | o_dbus_cyc)),
      .i_clr    (!(mem_en | (jal_or_jalr & alu_init))), //FIXME
      .i_loop   (bufreg_loop),
      .i_rs1    (rs1),
      .i_rs1_en (bufreg_rs1_en),
      .i_imm    (imm),
      .i_imm_en (bufreg_imm_en),
      .o_lsb    (lsb),
      .o_reg    (bufreg_out),
      .o_q      (bufreg_q));

   serv_ctrl
     #(.RESET_PC (RESET_PC))
   ctrl
     (
      .clk        (clk),
      .i_rst      (i_rst),
      //State
      .i_pc_en    (ctrl_pc_en),
      .i_cnt      (cnt[4:2]),
      .i_cnt_r    (cnt_r[2:1]),
      .i_cnt_done (cnt_done),
      //Control
      .i_jump     (jump),
      .i_jal_or_jalr (jal_or_jalr),
      .i_utype    (utype),
      .i_pc_rel   (pc_rel),
      .i_trap     (trap | mret),
      //Data
      .i_imm      (imm),
      .i_buf      (bufreg_q),
      .i_csr_pc   (csr_rd),
      .o_rd       (ctrl_rd),
      .o_bad_pc   (bad_pc),
      //External
      .o_ibus_adr (o_ibus_adr),
      .o_ibus_cyc (o_ibus_cyc),
      .i_ibus_ack (i_ibus_ack));

   assign rd = (ctrl_rd ) |
	       (rd_alu_en  & alu_rd ) |
	       (csr_rd ) |
	       (rd_mem_en  & mem_rd);

   assign op_b = (op_b_source == OP_B_SOURCE_IMM) ? imm : rs2;

   serv_alu alu
     (
      .clk        (clk),
      .i_rst      (i_rst),
      .i_en       (alu_en),
      .i_rs1      (rs1),
      .i_op_b     (op_b),
      .i_buf      (bufreg_q),
      .i_init     (alu_init),
      .i_cnt_done (cnt_done),
      .i_sub      (alu_sub),
      .i_bool_op  (alu_bool_op),
      .i_cmp_eq   (alu_cmp_eq),
      .i_cmp_uns  (alu_cmp_uns),
      .o_cmp      (alu_cmp),
      .i_shamt_en (alu_shamt_en),
      .i_sh_right (alu_sh_right),
      .i_sh_signed (alu_sh_signed),
      .o_sh_done  (alu_sh_done),
      .i_rd_sel   (alu_rd_sel),
      .o_rd       (alu_rd));
/*
   serv_regfile regfile
     (
      .i_clk      (clk),
      .i_rst      (i_rst),
      .i_go       (i_ibus_ack),
      .o_ready    (rf_ready),
      .i_rd_en    (rd_en),
      .i_rd_addr  (rd_addr),
      .i_rd       (rd),
      .i_rs1_addr (rs1_addr),
      .i_rs2_addr (rs2_addr),
      .o_rs1      (rs1),
      .o_rs2      (rs2));
*/
   wire 	 csr_in;
   wire 	 rf_csr_out;

   serv_mpram regfile
     (
      .i_clk       (clk),
      .i_rst       (i_rst),
      //Trap interface
      .i_trap      (trap),
      .i_mepc      (o_ibus_adr[0]),
      .i_mtval     (mem_misalign ? bufreg_q : bad_pc),
      //CSR write port
      .i_csr_en    (csr_en),
      .i_csr_addr  (csr_addr),
      .i_csr       (csr_in),
      //RD write port
      .i_rd_wen    (rd_en & (|rd_addr)),
      .i_rd_waddr  (rd_addr),
      .i_rd        (rd),

      .i_rreq      (i_ibus_ack),
      .o_rgnt      (rf_ready),
      //RS1 read port
      .i_rs1_raddr (rs1_addr),
      .o_rs1       (rs1),
      //RS2 read port
      .i_rs2_raddr (rs2_addr),
      .o_rs2       (rs2),
      //CSR read port
      .o_csr       (rf_csr_out));

   serv_mem_if mem_if
     (
      .i_clk    (clk),
      .i_rst    (i_rst),
      .i_en     (mem_en),
      .i_init   (mem_init),
      .i_cnt_done (cnt_done),
      .i_cmd    (mem_cmd),
      .i_bytecnt (mem_bytecnt),
      .i_funct3 (funct3),
      .i_rs2    (rs2),
      .o_rd     (mem_rd),
      .i_lsb      (lsb),
      .o_misalign (mem_misalign),
      //External interface
      .o_wb_dat   (o_dbus_dat),
      .o_wb_sel   (o_dbus_sel),
      .o_wb_we    (o_dbus_we ),
      .o_wb_cyc   (o_dbus_cyc),
      .i_wb_rdt   (i_dbus_rdt),
      .i_wb_ack   (i_dbus_ack));

   serv_csr csr
     (
      .i_clk        (clk),
      .i_cnt        (cnt[4:2]),
      .i_cnt_r      (cnt_r[3:2]),
      .i_rf_csr_out (rf_csr_out),
      .o_csr_in     (csr_in),
      .i_mtip       (i_timer_irq),
      .o_new_irq    (new_irq),
      .i_mstatus_en (csr_mstatus_en),
      .i_mie_en     (csr_mie_en    ),
      .i_mcause_en  (csr_mcause_en ),
      .i_csr_source (csr_source),
      .i_trap       (trap),
      .i_mcause     (mcause),
      .i_d          (csr_d_sel ? csr_imm : rs1),
      .o_q          (csr_rd));

`ifdef RISCV_FORMAL
   reg [31:0] 	 pc = RESET_PC;

   always @(posedge clk) begin
      rvfi_valid <= cnt_done & ctrl_pc_en & !i_rst;
      rvfi_order <= rvfi_order + {63'd0,rvfi_valid};
      if (o_ibus_cyc & i_ibus_ack)
	rvfi_insn <= i_ibus_rdt;
      if (rd_en)
        rvfi_rd_wdata <= {rd,rvfi_rd_wdata[31:1]};
      if (cnt_done & ctrl_pc_en) begin
         rvfi_pc_rdata <= pc;
	 if (!rd_en)
	   rvfi_rd_addr <= 5'd0;
	 if (!rd_en | !(|rd_addr))
	   rvfi_rd_wdata <= 32'd0;
      end
      rvfi_trap <= trap;
      if (rvfi_valid) begin
         rvfi_trap <= 1'b0;
         pc <= rvfi_pc_wdata;
      end

      rvfi_halt <= 1'b0;
      rvfi_intr <= 1'b0;
      rvfi_mode <= 2'd3;
      rvfi_ixl = 2'd1;
      if (rf_ready) begin
	 rvfi_rs1_addr <= rs1_addr;
         rvfi_rs2_addr <= rs2_addr;
	 rvfi_rd_addr  <= rd_addr;
      end
      if (rs_en) begin
         rvfi_rs1_rdata <= {rs1,rvfi_rs1_rdata[31:1]};
         rvfi_rs2_rdata <= {rs2,rvfi_rs2_rdata[31:1]};
      end

      if (i_dbus_ack) begin
         rvfi_mem_addr <= o_dbus_adr;
         rvfi_mem_rmask <= o_dbus_we ? 4'b0000 : o_dbus_sel;
         rvfi_mem_wmask <= o_dbus_we ? o_dbus_sel : 4'b0000;
         rvfi_mem_rdata <= i_dbus_rdt;
         rvfi_mem_wdata <= o_dbus_dat;
      end
      if (i_ibus_ack) begin
         rvfi_mem_rmask <= 4'b0000;
         rvfi_mem_wmask <= 4'b0000;
      end
   end
   /* verilator lint_off COMBDLY */
   always @(o_ibus_adr)
     rvfi_pc_wdata <= o_ibus_adr;
   /* verilator lint_on COMBDLY */

`endif

endmodule
