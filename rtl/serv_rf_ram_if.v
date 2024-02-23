`default_nettype none
module serv_rf_ram_if
  #(//Data width. Adjust to preferred width of SRAM data interface
    parameter width=8,

    parameter W = 1,
    //Select reset strategy.
    // "MINI" for resetting minimally required FFs
    // "NONE" for relying on FFs having a defined value on startup
    parameter reset_strategy="MINI",

    //Number of CSR registers. These are allocated after the normal
    // GPR registers in the RAM.
    parameter csr_regs=4,

    //Internal parameters calculated from above values. Do not change
    parameter B=W-1,
    parameter raw=$clog2(32+csr_regs), //Register address width
    parameter l2w=$clog2(width), //log2 of width
    parameter aw=5+raw-l2w) //Address width
  (
   //SERV side
   input wire		   i_clk,
   input wire		   i_rst,
   input wire		   i_wreq,
   input wire		   i_rreq,
   output wire		   o_ready,
   input wire [raw-1:0]	   i_wreg0,
   input wire [raw-1:0]	   i_wreg1,
   input wire		   i_wen0,
   input wire		   i_wen1,
   input wire [B:0]	   i_wdata0,
   input wire [B:0]	   i_wdata1,
   input wire [raw-1:0]	   i_rreg0,
   input wire [raw-1:0]	   i_rreg1,
   output wire [B:0]	   o_rdata0,
   output wire [B:0]	   o_rdata1,
   //RAM side
   output wire [aw-1:0]	   o_waddr,
   output wire [width-1:0] o_wdata,
   output wire		   o_wen,
   output wire [aw-1:0]	   o_raddr,
   output wire		   o_ren,
   input wire [width-1:0]  i_rdata);

   localparam ratio = width/W;
   localparam CMSB = 4-$clog2(W); //Counter MSB
   localparam l2r  = $clog2(ratio);

   reg 				   rgnt;
   assign o_ready = rgnt | i_wreq;
   reg [CMSB:0] 	  rcnt;

   reg 		  rtrig1;
   /*
    ********** Write side ***********
    */

   wire [CMSB:0] 	     wcnt;

   reg [width-1:0]   wdata0_r;
   reg [width+W-1:0]   wdata1_r;

   reg 		     wen0_r;
   reg 		     wen1_r;
   wire 	     wtrig0;
   wire 	     wtrig1;

   assign wtrig0 = rtrig1;

   generate if (ratio == 2) begin : gen_wtrig_ratio_eq_2
      assign wtrig1 =  wcnt[0];
   end else begin : gen_wtrig_ratio_neq_2
      reg wtrig0_r;
      always @(posedge i_clk) wtrig0_r <= wtrig0;
      assign wtrig1 = wtrig0_r;
   end
   endgenerate

   assign 	     o_wdata = wtrig1 ?
			       wdata1_r[width-1:0] :
			       wdata0_r;

   wire [raw-1:0] wreg  = wtrig1 ? i_wreg1 : i_wreg0;
   generate if (width == 32) begin : gen_w_eq_32
      assign o_waddr = wreg;
   end else begin : gen_w_neq_32
      assign o_waddr = {wreg, wcnt[CMSB:l2r]};
   end
   endgenerate

   assign o_wen = (wtrig0 & wen0_r) | (wtrig1 & wen1_r);

   assign wcnt = rcnt-4;

   always @(posedge i_clk) begin
      if (wcnt[0]) begin
	 wen0_r    <= i_wen0;
	 wen1_r    <= i_wen1;
      end

      wdata0_r  <= {i_wdata0,wdata0_r[width-1:W]};
      wdata1_r  <= {i_wdata1,wdata1_r[width+W-1:W]};

   end

   /*
    ********** Read side ***********
    */


   wire 	  rtrig0;

   wire [raw-1:0] rreg = rtrig0 ? i_rreg1 : i_rreg0;
   generate if (width == 32) begin : gen_rreg_eq_32
      assign o_raddr = rreg;
   end else begin : gen_rreg_neq_32
      assign o_raddr = {rreg, rcnt[CMSB:l2r]};
   end
   endgenerate

   reg [width-1:0]  rdata0;
   reg [width-1-W:0]  rdata1;

   reg 		    rgate;

   assign o_rdata0 = rdata0[B:0];
   assign o_rdata1 = rtrig1 ? i_rdata[B:0] : rdata1[B:0];

   assign rtrig0 = (rcnt[l2r-1:0] == 1);

   generate if (ratio == 2) begin : gen_ren_w_eq_2
      assign o_ren = rgate;
   end else begin : gen_ren_w_neq_2
      assign o_ren = rgate & (rcnt[l2r-1:1] == 0);
   end
   endgenerate

   reg 	      rreq_r;

   generate if (ratio > 2) begin : gen_rdata1_w_neq_2
      always @(posedge i_clk) begin
	 rdata1 <= {{W{1'b0}},rdata1[width-W-1:W]};
	 if (rtrig1)
	   rdata1[width-W-1:0] <= i_rdata[width-1:W];
      end
   end else begin : gen_rdata1_w_eq_2
      always @(posedge i_clk) if (rtrig1) rdata1 <= i_rdata[W*2-1:W];
   end
   endgenerate

   always @(posedge i_clk) begin
      if (&rcnt | i_rreq)
	rgate <= i_rreq;

      rtrig1 <= rtrig0;
      rcnt <= rcnt+{{CMSB{1'b0}},1'b1};
      if (i_rreq | i_wreq)
	 rcnt <= {{CMSB-1{1'b0}},i_wreq,1'b0};

      rreq_r <= i_rreq;
      rgnt <= rreq_r;

      rdata0 <= {{W{1'b0}}, rdata0[width-1:W]};
      if (rtrig0)
	rdata0 <= i_rdata;

      if (i_rst) begin
	 if (reset_strategy != "NONE") begin
	    rgate <= 1'b0;
	    rgnt <= 1'b0;
	    rreq_r <= 1'b0;
	    rcnt <= {CMSB+1{1'b0}};
	 end
      end
   end



endmodule
