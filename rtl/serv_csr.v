`default_nettype none
module serv_csr
  (
   input       i_clk,
   input       i_en,
   input [2:0] i_csr_sel,
   input [1:0] i_csr_source,
   input       i_trap,
   input       i_pc,
   input       i_mtval,
   input       i_load_misaligned,
   input       i_store_misaligned,
   input       i_d,
   output      o_q);

`include "serv_params.vh"
   /*
    mtvec RW
    mepc  RW
    mstatus RWSC
    mcause R
    mip CWi
    mie SCWi
    */

   reg [31:0] 	mtvec = 32'h0;
   reg [31:0] 	mepc  = 32'h0;
   reg [31:0] 	mtval = 32'h0;
   reg [31:0] 	mcause = 32'h0;

   wire 	mtvec_en  = i_en & (i_csr_sel == CSR_SEL_MTVEC);
   wire 	mepc_en   = i_en & (i_trap | (i_csr_sel == CSR_SEL_MEPC));
   wire 	mcause_en = i_en & (i_csr_sel == CSR_SEL_MCAUSE);
   wire 	mtval_en  = i_en & (i_trap | (i_csr_sel == CSR_SEL_MTVAL));

   wire 	csr_in;
   wire 	csr_out;

   assign csr_in = (i_csr_source == CSR_SOURCE_EXT) ? i_d :
		   (i_csr_source == CSR_SOURCE_SET) ? csr_out | i_d :
		   (i_csr_source == CSR_SOURCE_CLR) ? csr_out & ~i_d :
		   (i_csr_source == CSR_SOURCE_CSR) ? csr_out :
		   1'bx;

   assign csr_out = (i_csr_sel == CSR_SEL_MTVEC)  ? mtvec[0]  :
		    (i_csr_sel == CSR_SEL_MEPC)   ? mepc[0]   :
		    (i_csr_sel == CSR_SEL_MCAUSE) ? mcause[0] :
		    (i_csr_sel == CSR_SEL_MTVAL)  ? mtval[0]  :
		    1'bx;

   assign o_q = csr_out;

   always @(posedge i_clk) begin
      if (i_load_misaligned)
	mcause[3:0] <= 4'd4;
      if (i_store_misaligned)
	mcause[3:0] <= 4'd6;

      if (mtvec_en)
	mtvec <= {csr_in, mtvec[31:1]};

      if (mepc_en)
	mepc <= {i_trap ? i_pc : csr_in, mepc[31:1]};

      if (mcause_en)
	mcause <= {csr_in, mcause[31:1]};

      if (mtval_en)
	mtval <= {i_trap ? i_mtval : csr_in, mtval[31:1]};
   end

endmodule
