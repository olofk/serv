`default_nettype none
module serv_csr
  (
   input wire 	    i_clk,
   input wire 	    i_en,
   input wire [2:0] i_csr_sel,
   input wire [1:0] i_csr_source,
   input wire 	    i_trap,
   input wire 	    i_pc,
   input wire 	    i_mtval,
   input wire [3:0] i_mcause,
   input wire 	    i_d,
   output wire 	    o_q);

`include "serv_params.vh"
   /*
    304 mie SCWi
    305 mtvec RW
    340 mscratch
    341 mepc  RW
    300 mstatus RWSC
    342 mcause R
    343 mtval
    344 mip CWi
    */

   reg [31:0] 	mtvec    = 32'h0;
   reg [31:0] 	mscratch = 32'h0;
   reg [31:0] 	mepc     = 32'h0;
   reg [31:0] 	mcause   = 32'h0;
   reg [31:0] 	mtval    = 32'h0;

   wire 	mtvec_en    = i_en & (i_csr_sel == CSR_SEL_MTVEC);
   wire 	mscratch_en = i_en & (i_csr_sel == CSR_SEL_MSCRATCH);
   wire 	mepc_en     = i_en & (i_trap | (i_csr_sel == CSR_SEL_MEPC));
   wire 	mcause_en   = i_en & (i_csr_sel == CSR_SEL_MCAUSE);
   wire 	mtval_en    = i_en & (i_trap | (i_csr_sel == CSR_SEL_MTVAL));

   wire 	csr_in;
   wire 	csr_out;

   assign csr_in = (i_csr_source == CSR_SOURCE_EXT) ? i_d :
		   (i_csr_source == CSR_SOURCE_SET) ? csr_out | i_d :
		   (i_csr_source == CSR_SOURCE_CLR) ? csr_out & ~i_d :
		   (i_csr_source == CSR_SOURCE_CSR) ? csr_out :
		   1'bx;

   assign csr_out = (i_csr_sel == CSR_SEL_MTVEC)    ? mtvec[0]  :
		    (i_csr_sel == CSR_SEL_MSCRATCH) ? mscratch[0]   :
		    (i_csr_sel == CSR_SEL_MEPC)    ? mepc[0]   :
		    (i_csr_sel == CSR_SEL_MCAUSE)  ? mcause[0] :
		    (i_csr_sel == CSR_SEL_MTVAL)   ? mtval[0]  :
		    1'bx;


   assign o_q = csr_out;

   always @(posedge i_clk) begin
      if (i_trap)
	mcause[3:0] <= i_mcause;

      if (mscratch_en)
	mscratch <= {csr_in, mscratch[31:1]};

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
