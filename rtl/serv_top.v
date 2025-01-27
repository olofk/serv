`default_nettype none

module serv_top
  #(parameter	    WITH_CSR = 1,
    parameter	    W = 1,
    parameter	    B = W-1,
    parameter	    PRE_REGISTER = 1,
    parameter	    RESET_STRATEGY = "MINI",
    parameter	    RESET_PC = 32'd0,
    parameter [0:0] DEBUG = 1'b0,
    parameter [0:0] MDU = 1'b0,
    parameter [0:0] EI = 1'b0,
    parameter [0:0] COMPRESSED=0,
    parameter [0:0] ALIGN = COMPRESSED)
   (
   input wire 		      clk,
   input wire 		      i_rst,
   input wire 		      i_timer_irq,
   input wire		      i_external_irq,
`ifdef RISCV_FORMAL
   output wire 		      rvfi_valid,
   output wire [63:0] 	      rvfi_order,
   output wire [31:0] 	      rvfi_insn,
   output wire 		      rvfi_trap,
   output wire 		      rvfi_halt,
   output wire 		      rvfi_intr,
   output wire [1:0] 	      rvfi_mode,
   output wire [1:0] 	      rvfi_ixl,
   output wire [4:0] 	      rvfi_rs1_addr,
   output wire [4:0] 	      rvfi_rs2_addr,
   output wire [31:0] 	      rvfi_rs1_rdata,
   output wire [31:0] 	      rvfi_rs2_rdata,
   output wire [4:0] 	      rvfi_rd_addr,
   output wire [31:0] 	      rvfi_rd_wdata,
   output wire [31:0] 	      rvfi_pc_rdata,
   output wire [31:0] 	      rvfi_pc_wdata,
   output wire [31:0] 	      rvfi_mem_addr,
   output wire [3:0] 	      rvfi_mem_rmask,
   output wire [3:0] 	      rvfi_mem_wmask,
   output wire [31:0] 	      rvfi_mem_rdata,
   output wire [31:0] 	      rvfi_mem_wdata,
`endif
   //RF Interface
   output wire 		      o_rf_rreq,
   output wire 		      o_rf_wreq,
   input wire 		      i_rf_ready,
   output wire [4+WITH_CSR:0] o_wreg0,
   output wire [4+WITH_CSR:0] o_wreg1,
   output wire 		      o_wen0,
   output wire 		      o_wen1,
   output wire [B:0] o_wdata0,
   output wire [B:0] o_wdata1,
   output wire [4+WITH_CSR:0] o_rreg0,
   output wire [4+WITH_CSR:0] o_rreg1,
   input wire  [B:0] i_rdata0,
   input wire  [B:0] i_rdata1,

   output wire [31:0] 	      o_ibus_adr,
   output wire 		      o_ibus_cyc,
   input wire [31:0] 	      i_ibus_rdt,
   input wire 		      i_ibus_ack,
   output wire [31:0] 	      o_dbus_adr,
   output wire [31:0] 	      o_dbus_dat,
   output wire [3:0] 	      o_dbus_sel,
   output wire 		      o_dbus_we ,
   output wire 		      o_dbus_cyc,
   input wire [31:0] 	      i_dbus_rdt,
   input wire 		      i_dbus_ack,
   //Extension
   output wire [ 2:0] o_ext_funct3,
   input  wire        i_ext_ready,
   input wire  [31:0] i_ext_rd,
   output wire [31:0] o_ext_rs1,
   output wire [31:0] o_ext_rs2,

   // Sleep functionality
   output wire		      o_sleep_req,
   output wire		      o_wakeup_req,

   //MDU
   output wire        o_mdu_valid);

   wire [4:0]    rd_addr;
   wire [4:0]    rs1_addr;
   wire [4:0]    rs2_addr;

   wire [3:0] 	 immdec_ctrl;
   wire [3:0] 	immdec_en;

   wire          sh_right;
   wire 	 bne_or_bge;
   wire 	 cond_branch;
   wire 	 two_stage_op;
   wire 	 e_op;
   wire 	 ebreak;
   wire    wfi;
   wire 	 branch_op;
   wire 	 shift_op;
   wire 	 rd_op;
   wire   mdu_op;

   wire 	 rd_alu_en;
   wire 	 rd_csr_en;
   wire 	 rd_mem_en;
   wire [B:0]    ctrl_rd;
   wire [B:0]    alu_rd;
   wire [B:0]    mem_rd;
   wire [B:0]    csr_rd;
   wire 	 mtval_pc;

   wire          ctrl_pc_en;
   wire          jump;
   wire          jal_or_jalr;
   wire          utype;
   wire 	 mret;
   wire [B:0]    imm;
   wire 	 trap;
   wire 	 pc_rel;
   wire          iscomp;

   wire          init;
   wire          cnt_en;
   wire 	 cnt0to3;
   wire 	 cnt12to31;
   wire          cnt0;
   wire          cnt1;
   wire          cnt2;
   wire          cnt3;
   wire          cnt7;
   wire          cnt11;
   wire          cnt12;

   wire 	 cnt_done;

   wire 	 bufreg_en;
   wire          bufreg_sh_signed;
   wire 	 bufreg_rs1_en;
   wire 	 bufreg_imm_en;
   wire 	 bufreg_clr_lsb;
   wire [B:0]    bufreg_q;
   wire [B:0]    bufreg2_q;
   wire [31:0] dbus_rdt;
   wire        dbus_ack;

   wire          alu_sub;
   wire [1:0] 	 alu_bool_op;
   wire          alu_cmp_eq;
   wire          alu_cmp_sig;
   wire          alu_cmp;
   wire [2:0]    alu_rd_sel;

   wire [B:0]    rs1;
   wire [B:0]    rs2;
   wire          rd_en;

   wire [B:0]    op_b;
   wire          op_b_sel;

   wire          mem_signed;
   wire          mem_word;
   wire          mem_half;
   wire [1:0] 	 mem_bytecnt;
   wire 	 sh_done;

   wire 	 mem_misalign;

   wire [B:0]    bad_pc;

   wire 	 csr_mstatus_en;
   wire 	 csr_mie_en;
   wire 	 csr_mcause_en;
   wire [1:0]	 csr_source;
   wire	[B:0]	 csr_imm;
   wire 	 csr_d_sel;
   wire 	 csr_en;
   wire [1:0] 	 csr_addr;
   wire [B:0]    csr_pc;
   wire 	 csr_imm_en;
   wire [B:0]    csr_in;
   wire [B:0]    rf_csr_out;
   wire 	 dbus_en;

   wire 	 new_irq;

   wire [1:0]   lsb;

   wire [31:0] i_wb_rdt;

   wire [31:0] wb_ibus_adr;
   wire        wb_ibus_cyc;
   wire [31:0] wb_ibus_rdt;
   wire        wb_ibus_ack;

   wire	       mie_meie;
   wire	       mie_mtie;

   generate
      if (ALIGN) begin : gen_align
         serv_aligner  align
           (
            .clk(clk),
            .rst(i_rst),
            // serv_rf_top
            .i_ibus_adr(wb_ibus_adr),
            .i_ibus_cyc(wb_ibus_cyc),
            .o_ibus_rdt(wb_ibus_rdt),
            .o_ibus_ack(wb_ibus_ack),
            // servant_arbiter
            .o_wb_ibus_adr(o_ibus_adr),
            .o_wb_ibus_cyc(o_ibus_cyc),
            .i_wb_ibus_rdt(i_ibus_rdt),
            .i_wb_ibus_ack(i_ibus_ack));
      end else begin : gen_no_align
         assign  o_ibus_adr  = wb_ibus_adr;
         assign  o_ibus_cyc  = wb_ibus_cyc;
         assign  wb_ibus_rdt = i_ibus_rdt;
         assign  wb_ibus_ack = i_ibus_ack;
        end
   endgenerate

   generate
      if (COMPRESSED) begin : gen_compressed
         serv_compdec compdec
           (
            .i_clk(clk),
            .i_instr(wb_ibus_rdt),
            .i_ack(wb_ibus_ack),
            .o_instr(i_wb_rdt),
            .o_iscomp(iscomp));
      end else begin : gen_no_compressed
         assign i_wb_rdt =  wb_ibus_rdt;
         assign iscomp   =  1'b0;
      end
   endgenerate

   serv_sleep sleep
     (
      .i_clk            (clk),
      .i_rst            (i_rst),
      .i_timer_irq      (i_timer_irq),
      .i_external_irq   (i_external_irq),
      .i_cnt0           (cnt0),
      .i_wfi            (wfi),
      .i_init           (init),
      .o_sleep_req      (o_sleep_req),
      .o_wakeup_req     (o_wakeup_req),
      .i_meie           (mie_meie),
      .i_mtie           (mie_mtie));

   serv_state
     #(.RESET_STRATEGY (RESET_STRATEGY),
       .WITH_CSR (WITH_CSR[0:0]),
       .MDU(MDU),
       .ALIGN(ALIGN),
       .W(W))
   state
     (
      .i_clk (clk),
      .i_rst          (i_rst),
      //State
      .i_new_irq      (new_irq),
      .i_alu_cmp      (alu_cmp),
      .o_init         (init),
      .o_cnt_en       (cnt_en),
      .o_cnt0to3      (cnt0to3),
      .o_cnt12to31    (cnt12to31),
      .o_cnt0         (cnt0),
      .o_cnt1         (cnt1),
      .o_cnt2         (cnt2),
      .o_cnt3         (cnt3),
      .o_cnt7         (cnt7),
      .o_cnt11        (cnt11),
      .o_cnt12        (cnt12),
      .o_cnt_done     (cnt_done),
      .o_bufreg_en    (bufreg_en),
      .o_ctrl_pc_en   (ctrl_pc_en),
      .o_ctrl_jump    (jump),
      .o_ctrl_trap    (trap),
      .i_ctrl_misalign(lsb[1]),
      .i_sh_done      (sh_done),
      .o_mem_bytecnt  (mem_bytecnt),
      .i_mem_misalign (mem_misalign),
      //Control
      .i_bne_or_bge   (bne_or_bge),
      .i_cond_branch  (cond_branch),
      .i_dbus_en      (dbus_en),
      .i_two_stage_op (two_stage_op),
      .i_branch_op    (branch_op),
      .i_shift_op     (shift_op),
      .i_sh_right     (sh_right),
      .i_alu_rd_sel1  (alu_rd_sel[1]),
      .i_rd_alu_en    (rd_alu_en),
      .i_e_op         (e_op),
      .i_rd_op        (rd_op),
      //MDU
      .i_mdu_op       (mdu_op),
      .o_mdu_valid    (o_mdu_valid),
      //Extension
      .i_mdu_ready    (i_ext_ready),
      //External
      .o_dbus_cyc     (o_dbus_cyc),
      .i_dbus_ack     (i_dbus_ack),
      .o_ibus_cyc     (wb_ibus_cyc),
      .i_ibus_ack     (wb_ibus_ack),
      //RF Interface
      .o_rf_rreq      (o_rf_rreq),
      .o_rf_wreq      (o_rf_wreq),
      .i_rf_ready     (i_rf_ready),
      .o_rf_rd_en     (rd_en));

   serv_decode
     #(.PRE_REGISTER (PRE_REGISTER),
       .MDU(MDU))
   decode
     (
      .clk (clk),
      //Input
      .i_wb_rdt           (i_wb_rdt[31:2]),
      .i_wb_en            (wb_ibus_ack),
      //To state
      .o_bne_or_bge       (bne_or_bge),
      .o_cond_branch      (cond_branch),
      .o_dbus_en          (dbus_en),
      .o_e_op             (e_op),
      .o_ebreak           (ebreak),
      .o_wfi              (wfi),
      .o_branch_op        (branch_op),
      .o_shift_op         (shift_op),
      .o_rd_op            (rd_op),
      .o_sh_right         (sh_right),
      .o_mdu_op           (mdu_op),
      .o_two_stage_op     (two_stage_op),
      //Extension
      .o_ext_funct3       (o_ext_funct3),

      //To bufreg
      .o_bufreg_rs1_en    (bufreg_rs1_en),
      .o_bufreg_imm_en    (bufreg_imm_en),
      .o_bufreg_clr_lsb   (bufreg_clr_lsb),
      .o_bufreg_sh_signed (bufreg_sh_signed),
      //To bufreg2
      .o_op_b_source      (op_b_sel),
      //To ctrl
      .o_ctrl_jal_or_jalr (jal_or_jalr),
      .o_ctrl_utype       (utype),
      .o_ctrl_pc_rel      (pc_rel),
      .o_ctrl_mret        (mret),
      //To alu
      .o_alu_sub          (alu_sub),
      .o_alu_bool_op      (alu_bool_op),
      .o_alu_cmp_eq       (alu_cmp_eq),
      .o_alu_cmp_sig      (alu_cmp_sig),
      .o_alu_rd_sel       (alu_rd_sel),
      //To mem IF
      .o_mem_cmd          (o_dbus_we),
      .o_mem_signed       (mem_signed),
      .o_mem_word         (mem_word),
      .o_mem_half         (mem_half),
      //To CSR
      .o_csr_en           (csr_en),
      .o_csr_addr         (csr_addr),
      .o_csr_mstatus_en   (csr_mstatus_en),
      .o_csr_mie_en       (csr_mie_en),
      .o_csr_mcause_en    (csr_mcause_en),
      .o_csr_source       (csr_source),
      .o_csr_d_sel        (csr_d_sel),
      .o_csr_imm_en       (csr_imm_en),
      .o_mtval_pc         (mtval_pc      ),
      //To top
      .o_immdec_ctrl      (immdec_ctrl),
      .o_immdec_en        (immdec_en),
      //To RF IF
      .o_rd_mem_en        (rd_mem_en),
      .o_rd_csr_en        (rd_csr_en),
      .o_rd_alu_en        (rd_alu_en));

   serv_immdec #(.W (W)) immdec
     (
      .i_clk        (clk),
      //State
      .i_cnt_en     (cnt_en),
      .i_cnt_done   (cnt_done),
      //Control
      .i_immdec_en        (immdec_en),
      .i_csr_imm_en (csr_imm_en),
      .i_ctrl       (immdec_ctrl),
      .o_rd_addr    (rd_addr),
      .o_rs1_addr   (rs1_addr),
      .o_rs2_addr   (rs2_addr),
      //Data
      .o_csr_imm    (csr_imm),
      .o_imm        (imm),
      //External
      .i_wb_en      (wb_ibus_ack),
      .i_wb_rdt     (i_wb_rdt[31:7]));

   serv_bufreg
      #(.MDU(MDU),
	.W(W))
   bufreg
     (
      .i_clk    (clk),
      //State
      .i_cnt0   (cnt0),
      .i_cnt1   (cnt1),
      .i_cnt_done (cnt_done),
      .i_en     (bufreg_en),
      .i_init   (init),
      .i_mdu_op (mdu_op),
      .o_lsb    (lsb),
      //Control
      .i_sh_signed (bufreg_sh_signed),
      .i_rs1_en    (bufreg_rs1_en),
      .i_imm_en    (bufreg_imm_en),
      .i_clr_lsb   (bufreg_clr_lsb),
      .i_shift_op   (shift_op),
      .i_right_shift_op (sh_right),
      .i_shamt (o_dbus_dat[26:24]),
      //Data
      .i_rs1    (rs1),
      .i_imm    (imm),
      .o_q      (bufreg_q),
      //External
      .o_dbus_adr (o_dbus_adr),
      .o_ext_rs1  (o_ext_rs1));

   serv_bufreg2 #(.W(W)) bufreg2
     (
      .i_clk        (clk),
      //State
      .i_en         (cnt_en),
      .i_init       (init),
      .i_cnt7       (cnt7),
      .i_cnt_done   (cnt_done),
      .i_sh_right   (sh_right),
      .i_lsb        (lsb),
      .i_bytecnt    (mem_bytecnt),
      .o_sh_done    (sh_done),
      //Control
      .i_op_b_sel   (op_b_sel),
      .i_shift_op   (shift_op),
      //Data
      .i_rs2        (rs2),
      .i_imm        (imm),
      .o_op_b       (op_b),
      .o_q          (bufreg2_q),
      //External
      .o_dat        (o_dbus_dat),
      .i_load       (dbus_ack),
      .i_dat        (dbus_rdt));

   serv_ctrl
     #(.RESET_PC (RESET_PC),
       .RESET_STRATEGY (RESET_STRATEGY),
       .WITH_CSR (WITH_CSR),
       .W (W))
   ctrl
     (
      .clk        (clk),
      .i_rst      (i_rst),
      //State
      .i_pc_en    (ctrl_pc_en),
      .i_cnt12to31 (cnt12to31),
      .i_cnt0     (cnt0),
      .i_cnt1     (cnt1),
      .i_cnt2     (cnt2),
      //Control
      .i_jump     (jump),
      .i_jal_or_jalr (jal_or_jalr),
      .i_utype    (utype),
      .i_pc_rel   (pc_rel),
      .i_trap     (trap | mret),
      .i_iscomp    (iscomp),
      //Data
      .i_imm      (imm),
      .i_buf      (bufreg_q),
      .i_csr_pc   (csr_pc),
      .o_rd       (ctrl_rd),
      .o_bad_pc   (bad_pc),
      //External
      .o_ibus_adr (wb_ibus_adr));

   serv_alu #(.W (W)) alu
     (
      .clk        (clk),
      //State
      .i_en       (cnt_en),
      .i_cnt0     (cnt0),
      .o_cmp      (alu_cmp),
      //Control
      .i_sub      (alu_sub),
      .i_bool_op  (alu_bool_op),
      .i_cmp_eq   (alu_cmp_eq),
      .i_cmp_sig  (alu_cmp_sig),
      .i_rd_sel   (alu_rd_sel),
      //Data
      .i_rs1      (rs1),
      .i_op_b     (op_b),
      .i_buf      (bufreg_q),
      .o_rd       (alu_rd));

   serv_rf_if
     #(.WITH_CSR (WITH_CSR), .W(W))
   rf_if
     (//RF interface
      .i_cnt_en    (cnt_en),
      .o_wreg0     (o_wreg0),
      .o_wreg1     (o_wreg1),
      .o_wen0      (o_wen0),
      .o_wen1      (o_wen1),
      .o_wdata0    (o_wdata0),
      .o_wdata1    (o_wdata1),
      .o_rreg0     (o_rreg0),
      .o_rreg1     (o_rreg1),
      .i_rdata0    (i_rdata0),
      .i_rdata1    (i_rdata1),

      //Trap interface
      .i_trap      (trap),
      .i_mret      (mret),
      .i_mepc      (wb_ibus_adr[B:0]),
      .i_mtval_pc  (mtval_pc),
      .i_bufreg_q  (bufreg_q),
      .i_bad_pc    (bad_pc),
      .o_csr_pc    (csr_pc),
      //CSR write port
      .i_csr_en    (csr_en),
      .i_csr_addr  (csr_addr),
      .i_csr       (csr_in),
      //RD write port
      .i_rd_wen    (rd_en),
      .i_rd_waddr  (rd_addr),
      .i_ctrl_rd   (ctrl_rd),
      .i_alu_rd    (alu_rd),
      .i_rd_alu_en (rd_alu_en),
      .i_csr_rd    (csr_rd),
      .i_rd_csr_en (rd_csr_en),
      .i_mem_rd    (mem_rd),
      .i_rd_mem_en (rd_mem_en),

      //RS1 read port
      .i_rs1_raddr (rs1_addr),
      .o_rs1       (rs1),
      //RS2 read port
      .i_rs2_raddr (rs2_addr),
      .o_rs2       (rs2),

      //CSR read port
      .o_csr       (rf_csr_out));

   serv_mem_if
     #(.WITH_CSR (WITH_CSR[0:0]),
       .W (W))
   mem_if
     (
      .i_clk        (clk),
      //State
      .i_bytecnt    (mem_bytecnt),
      .i_lsb        (lsb),
      .o_misalign   (mem_misalign),
      //Control
      .i_mdu_op     (mdu_op),
      .i_signed     (mem_signed),
      .i_word       (mem_word),
      .i_half       (mem_half),
      //Data
      .i_bufreg2_q  (bufreg2_q),
      .o_rd         (mem_rd),
      //External interface
      .o_wb_sel     (o_dbus_sel));

   generate
      if (|WITH_CSR) begin : gen_csr
	 serv_csr
	   #(.RESET_STRATEGY (RESET_STRATEGY),
	     .W(W))
	 csr
	   (
	    .i_clk        (clk),
	    .i_rst        (i_rst),
	    //State
	    .i_trig_irq   (wb_ibus_ack),
	    .i_en         (cnt_en),
	    .i_cnt0to3    (cnt0to3),
	    .i_cnt3       (cnt3),
	    .i_cnt7       (cnt7),
	    .i_cnt11      (cnt11),
	    .i_cnt12      (cnt12),
	    .i_cnt_done   (cnt_done),
	    .i_mem_op     (!mtval_pc),
	    .i_mtip       (i_timer_irq),
	    .i_meip       (i_external_irq),
	    .i_trap       (trap),
	    .o_new_irq    (new_irq),
	    //Control
	    .i_e_op       (e_op),
	    .i_ebreak     (ebreak),
	    .i_mem_cmd    (o_dbus_we),
	    .i_mstatus_en (csr_mstatus_en),
	    .i_mie_en     (csr_mie_en    ),
	    .i_mcause_en  (csr_mcause_en ),
	    .i_csr_source (csr_source),
	    .i_mret       (mret),
	    .i_csr_d_sel  (csr_d_sel),
	    //Data
	    .i_rf_csr_out (rf_csr_out),
	    .o_csr_in     (csr_in),
	    .i_csr_imm    (csr_imm),
	    .i_rs1        (rs1),
	    .o_q          (csr_rd),
	    .o_meie (mie_meie),
	    .o_mtie (mie_mtie));
      end else begin : gen_no_csr
	 assign csr_in = {W{1'b0}};
	 assign csr_rd = {W{1'b0}};
	 assign new_irq = 1'b0;
      end
   endgenerate

   generate
      if (DEBUG) begin : gen_debug
	 serv_debug #(.W (W), .RESET_PC (RESET_PC)) debug
	   (
`ifdef RISCV_FORMAL
	    .rvfi_valid     (rvfi_valid    ),
	    .rvfi_order     (rvfi_order    ),
	    .rvfi_insn      (rvfi_insn     ),
	    .rvfi_trap      (rvfi_trap     ),
	    .rvfi_halt      (rvfi_halt     ),
	    .rvfi_intr      (rvfi_intr     ),
	    .rvfi_mode      (rvfi_mode     ),
	    .rvfi_ixl       (rvfi_ixl      ),
	    .rvfi_rs1_addr  (rvfi_rs1_addr ),
	    .rvfi_rs2_addr  (rvfi_rs2_addr ),
	    .rvfi_rs1_rdata (rvfi_rs1_rdata),
	    .rvfi_rs2_rdata (rvfi_rs2_rdata),
	    .rvfi_rd_addr   (rvfi_rd_addr  ),
	    .rvfi_rd_wdata  (rvfi_rd_wdata ),
	    .rvfi_pc_rdata  (rvfi_pc_rdata ),
	    .rvfi_pc_wdata  (rvfi_pc_wdata ),
	    .rvfi_mem_addr  (rvfi_mem_addr ),
	    .rvfi_mem_rmask (rvfi_mem_rmask),
	    .rvfi_mem_wmask (rvfi_mem_wmask),
	    .rvfi_mem_rdata (rvfi_mem_rdata),
	    .rvfi_mem_wdata (rvfi_mem_wdata),
	    .i_dbus_adr     (o_dbus_adr),
	    .i_dbus_dat     (o_dbus_dat),
	    .i_dbus_sel     (o_dbus_sel),
	    .i_dbus_we      (o_dbus_we ),
	    .i_dbus_rdt     (i_dbus_rdt),
	    .i_dbus_ack     (i_dbus_ack),
	    .i_ctrl_pc_en   (ctrl_pc_en),
	    .rs1            (rs1),
	    .rs2            (rs2),
	    .rs1_addr       (rs1_addr),
	    .rs2_addr       (rs2_addr),
	    .immdec_en      (immdec_en),
	    .rd_en          (rd_en),
	    .trap           (trap),
	    .i_rf_ready     (i_rf_ready),
	    .i_ibus_cyc     (o_ibus_cyc),
	    .two_stage_op   (two_stage_op),
	    .init           (init),
	    .i_ibus_adr     (o_ibus_adr),
`endif
	    .i_clk            (clk),
	    .i_rst            (i_rst),
	    .i_ibus_rdt       (i_ibus_rdt),
	    .i_ibus_ack       (i_ibus_ack),
	    .i_rd_addr        (rd_addr       ),
	    .i_cnt_en         (cnt_en        ),
	    .i_csr_in         (csr_in        ),
	    .i_csr_mstatus_en (csr_mstatus_en),
	    .i_csr_mie_en     (csr_mie_en    ),
	    .i_csr_mcause_en  (csr_mcause_en ),
	    .i_csr_en         (csr_en        ),
	    .i_csr_addr       (csr_addr),
	    .i_wen0           (o_wen0),
	    .i_wdata0         (o_wdata0),
	    .i_cnt_done       (cnt_done));
      end
   endgenerate


generate
  if (MDU) begin: gen_mdu
    assign dbus_rdt = i_ext_ready ? i_ext_rd:i_dbus_rdt;
    assign dbus_ack = i_dbus_ack | i_ext_ready;
  end else begin : gen_no_mdu
    assign dbus_rdt = i_dbus_rdt;
    assign dbus_ack = i_dbus_ack;
  end
  assign o_ext_rs2 = o_dbus_dat;
endgenerate

endmodule
`default_nettype wire
