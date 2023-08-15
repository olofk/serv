module serv_rf_ram_if
#(
    //Data width. Adjust to preferred width of SRAM data interface
    parameter width=8,
    //Number of CSR registers. These are allocated after the normal
    // GPR registers in the RAM.
    parameter csr_regs=4,
    //Internal parameters calculated from above values. Do not change
    parameter raw=$clog2(32+csr_regs), //Register address width
//    parameter raw=$clog2(32),
    parameter l2w=$clog2(width), //log2 of width
    parameter aw=5+raw-l2w) //Address width
(
    // Global control
    input  wire		        i_clk,
    input  wire		        i_rst,
    // SERV control signal
    input  wire		        i_rreq,
    input  wire		        i_wreq,
    output wire		        o_ready,
    input  wire [raw-1:0]   i_wreg0,
    input  wire [raw-1:0]   i_wreg1,
    input  wire		        i_wen0,
    input  wire		        i_wen1,
    input  wire		        i_wdata0,
    input  wire		        i_wdata1,
    input  wire [raw-1:0]   i_rreg0,
    input  wire [raw-1:0]   i_rreg1,
    output wire		        o_rdata0,
    output wire		        o_rdata1,
    //RAM side
    output wire [aw-1:0]    o_waddr,
    output wire [width-1:0] o_wdata,
    output wire		        o_wen,
    output wire [aw-1:0]	o_raddr,
    output wire		        o_ren,
    input  wire [width-1:0] i_rdata
);

   reg 		 rgnt;
   reg [4:0] rcnt;
   reg 		 rtrig1;
   /*
    ********** Write side ***********
    */

   wire [4:0] 	     wcnt;

   reg [width-1:0]   wdata0_r;
   reg [width-0:0]   wdata1_r;

   reg 		     wen0_r;
   reg 		     wen1_r;
   wire 	     wtrig0;
   wire 	     wtrig1;

   assign wtrig0 = rtrig1;

//   generate if (width == 2) begin
//      assign wtrig1 =  wcnt[0];
//   end else begin
   reg wtrig0_r;
   
   always @(posedge i_clk) 
    wtrig0_r <= wtrig0;
      
   assign wtrig1 = wtrig0_r;
//   end
//   endgenerate

   assign o_wdata = wtrig1 ? wdata1_r[width-1:0] : wdata0_r;

   wire [raw-1:0] wreg  = wtrig1 ? i_wreg1 : i_wreg0;
//   generate if (width == 32)
//     assign o_waddr = wreg;
//   else
   assign o_waddr = {wreg, wcnt[4:l2w]};
//   endgenerate

   assign o_wen = (wtrig0 & wen0_r) | (wtrig1 & wen1_r);
   assign wcnt = rcnt-4;

   always @(posedge i_clk) begin
      if (wcnt[0]) begin
         wen0_r    <= i_wen0;
         wen1_r    <= i_wen1;
      end

      if (i_rst) begin
          wdata0_r  <= 0;
          wdata1_r  <= 0;
      end
      else begin
          wdata0_r  <= {i_wdata0,wdata0_r[width-1:1]};
          wdata1_r  <= {i_wdata1,wdata1_r[width-0:1]};
      end
   end

   /*
    ********** Read side ***********
    */


   wire 	  rtrig0;

   wire [raw-1:0] rreg = rtrig0 ? i_rreg1 : i_rreg0;
//   generate if (width == 32)
//     assign o_raddr = rreg;
//   else
   assign o_raddr = {rreg, rcnt[4:l2w]};
//   endgenerate

   reg [width-1:0]  rdata0;
   reg [width-2:0]  rdata1;

   reg rgate;

   assign o_rdata0 = rdata0[0];
   assign o_rdata1 = rtrig1 ? i_rdata[0] : rdata1[0];

   assign rtrig0 = (rcnt[l2w-1:0] == 1);

//   generate if (width == 2)
//     assign o_ren = rgate;
//   else
     assign o_ren = rgate & (rcnt[l2w-1:1] == 0);
//   endgenerate

   reg 	      rreq_r;

//   generate 
//     if (width>2)
     always @(posedge i_clk) begin
        rdata1 <= {1'b0,rdata1[width-2:1]}; //Optimize?
        if (rtrig1) rdata1[width-2:0] <= i_rdata[width-1:1];
     end
//     else
//     always @(posedge i_clk) 
//        if (rtrig1) rdata1 <= i_rdata[1];
//   endgenerate

   always @(posedge i_clk) begin
      if (i_rst) rgate <= 1'b0;
      else if (&rcnt | i_rreq) rgate <= i_rreq;
      
      if (i_rst) rgnt <= 1'b0;
      else rgnt <= rreq_r;
      
      if (i_rst) rreq_r <= 1'b0;
      else rreq_r <= i_rreq;
      
      if (i_rst) rcnt <= 5'd0;
      else if (i_rreq | i_wreq) rcnt <= {3'd0,i_wreq,1'b0};
      else rcnt <= rcnt+5'd1;
      
      rtrig1 <= rtrig0;
      
      if (i_rst) rdata0 <= 0;
      else if (rtrig0) rdata0 <= i_rdata;
      else rdata0 <= {1'b0,rdata0[width-1:1]};
   end

   assign o_ready = rgnt | i_wreq;

endmodule
