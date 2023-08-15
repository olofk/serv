module serv_rf_if
(
   //RF Interface
   input  wire 		 i_cnt_en,
   input  wire       i_cnt_11to31,
   output wire [5:0] o_wreg0,
   output wire [5:0] o_wreg1,
   output wire 		 o_wen0,
   output wire 		 o_wen1,
   output wire 		 o_wdata0,
   output wire 		 o_wdata1,
   output wire [5:0] o_rreg0,
   output wire [5:0] o_rreg1,
   input  wire 		 i_rdata0,
   input  wire 		 i_rdata1,

   //Trap interface
   input  wire 		 i_trap,
   input  wire       i_ebreak,
   input  wire       i_dbg_process,
   input  wire       i_halt,
   input  wire 		 i_mret,
   input  wire       i_dret,
   input  wire 		 i_mepc,
   input  wire       i_pcnext,
   input  wire 		 i_mtval_pc,
   input  wire 		 i_bufreg_q,
   input  wire 		 i_bad_pc,
   output wire 		 o_csr_pc,
   //CSR interface
   input  wire 		 i_csr_en,
   input  wire [2:0] i_csr_addr,
   input  wire 		 i_csr,
   output wire 		 o_csr,
   //RD write port
   input  wire 		 i_rd_wen,
   input  wire [4:0] i_rd_waddr,
   input  wire 		 i_ctrl_rd,
   input  wire 		 i_alu_rd,
   input  wire 		 i_rd_alu_en,
   input  wire 		 i_csr_rd,
   input  wire 		 i_rd_csr_en,
   input  wire 		 i_mem_rd,
   input  wire 		 i_rd_mem_en,
   //RS1 read port
   input  wire [4:0] i_rs1_raddr,
   output wire 		 o_rs1,
   //RS2 read port
   input  wire [4:0] i_rs2_raddr,
   output wire 		 o_rs2
 );


   /*
    ********** Write side ***********
    */

   wire rd_wen = i_rd_wen & (|i_rd_waddr);
   wire rd = (i_ctrl_rd ) |
			 (i_alu_rd & i_rd_alu_en) |
			 (i_csr_rd & i_rd_csr_en) |
			 (i_mem_rd & i_rd_mem_en);

   wire mtval = i_mtval_pc ? i_bad_pc : i_bufreg_q;

   assign o_wdata0 = i_trap ? mtval  : rd;
   assign o_wdata1 = i_ebreak? i_pcnext:
                     i_trap ? i_mepc : i_csr;

   /* Port 0 handles writes to mtval during traps and rd otherwise
    * Port 1 handles writes to mepc during traps and csr accesses otherwise
    *
    * GPR registers are mapped to address 0-31 (bits 0xxxxx).
    * Following that are four CSR registers
    * mscratch 100000
    * mtvec    100001
    * mepc     100010
    * mtval    100011
    */

//   assign o_wreg0 = i_trap ? {6'b100011} : {1'b0,i_rd_waddr};
//   assign o_wreg1 = i_trap ? {6'b100010} : {3'b010,i_csr_addr};

   assign o_wreg0 = i_trap ? {6'b010010} : // mtval
                             {1'b0,i_rd_waddr};
                             
   assign o_wreg1 = i_ebreak ? {6'b010101} : // dpc
                    i_trap   ? {6'b010001} : // mepc
                             {3'b010,i_csr_addr};
   
   assign o_wen0 = i_cnt_en & (i_trap | rd_wen) & !i_ebreak;
//   assign o_wen1 = i_cnt_en & (i_trap | i_csr_en | i_ebreak) & !i_dbg_process;
   assign o_wen1 = i_cnt_en & (i_trap | i_csr_en | i_ebreak) & !(i_ebreak && i_dbg_process);
//   assign o_wen1 = i_cnt_en & (i_trap | i_csr_en | i_ebreak);
   /*
    ********** Read side ***********
    */

   //0 : RS1
   //1 : RS2 / CSR

   assign o_rreg0 = {1'b0, i_rs1_raddr};

   /*
    The address of the second read port (o_rreg1) can get assigned from four
    different sources

    Normal operations : i_rs2_raddr
    CSR access        : i_csr_addr
    trap              : MTVEC
    mret              : MEPC
    dret              : DPC

    Address 0-31 in the RF are assigned to the GPRs. After that follows the four
    CSRs on addresses 32-35

    32 MSCRATCH
    33 MTVEC
    34 MEPC
    35 MTVAL

    The expression below is an optimized version of this logic
    */
   wire sel_rs2 = !(i_trap | i_mret | i_dret | i_csr_en);
   
//   assign o_rreg1[5]   = ~sel_rs2;
//   assign o_rreg1[4:2] = i_rs2_raddr[4:2] & {3{sel_rs2}};
//   assign o_rreg1[1:0] = {1'b0,i_trap} |
//                         {i_mret,1'b0} |
//                         ({2{i_csr_en}} & i_csr_addr) |
//                         ({2{sel_rs2}} & i_rs2_raddr[1:0]);
//       assign o_rreg1 = {~sel_rs2,
//		                 i_rs2_raddr[4:2] & {3{sel_rs2}}, // [4:2]
//		                 // [1:0]
//		                 {1'b0, i_trap} | // mtvec
//		                 {i_mret,1'b0}  | // mepc
		                 
//		                 ({2{i_csr_en}} & i_csr_addr) | 
//		                 ({2{sel_rs2}} & i_rs2_raddr[1:0])}; // [1:0]
   assign o_rreg1[5]   = 1'b0; // only use 32 registers
   assign o_rreg1[4]   =  ~sel_rs2; // 1 if csr is selected
   assign o_rreg1[3]   =   sel_rs2 & i_rs2_raddr[3]; // select rs2 if not csr, otherwise zero
   assign o_rreg1[2:0] =  {i_dret, i_trap, i_trap | i_mret | i_dret} |
                          ({3{i_csr_en}} & i_csr_addr) |
                          ({3{sel_rs2}} & i_rs2_raddr[2:0]);
   
   assign o_rs1 = i_rdata0;
   assign o_rs2 = i_rdata1;
   assign o_csr = i_rdata1 & i_csr_en;
   assign o_csr_pc = i_ebreak? (i_cnt_en & i_cnt_11to31): i_rdata1;

endmodule
