`default_nettype none
module serv_rf_2bit
  (
   input wire 	    i_clk,
   input wire 	    i_rst,
   input wire 	    i_wreq,
   input wire 	    i_rreq,
   output reg 	    o_rgnt,
   input wire [5:0] i_wreg0,
   input wire [5:0] i_wreg1,
   input wire 	    i_wen0,
   input wire 	    i_wen1,
   input wire 	    i_wdata0,
   input wire 	    i_wdata1,
   input wire [5:0] i_rreg0,
   input wire [5:0] i_rreg1,
   output wire 	    o_rdata0,
   output wire 	    o_rdata1);


   /*
    ********** Write side ***********
    */

   reg [4:0] 	     wcnt;
   reg 		     wgo;

   wire [3:0] 	     wslot = wcnt[4:1];
   wire 	     wport = wcnt[0];

   reg 		     wdata0_r;
   reg 		     wdata1_r;
   reg 		     wdata1_2r;
   wire [1:0] 	     wdata = !wport ?
		     {i_wdata0, wdata0_r} :
		     {wdata1_r, wdata1_2r};

   wire [5:0] wreg  = wport ? i_wreg1 : i_wreg0;
   wire [9:0] waddr = {wreg, wslot};

   wire       wen = wgo & (wport ? wen1_r : wen0_r);

   reg 	      wreq_r;

   reg 	      wen0_r;
   reg 	      wen1_r;

   always @(posedge i_clk) begin
      wen0_r    <= i_wen0;
      wen1_r    <= i_wen1;
      wreq_r    <= i_wreq;
      wdata0_r  <= i_wdata0;
      wdata1_r  <= i_wdata1;
      wdata1_2r <= wdata1_r;

      if (wgo)
	wcnt <= wcnt+5'd1;

      if (wreq_r)
	 wgo <= 1'b1;
      if (wcnt == 5'b11111)
	wgo <= 1'b0;

      if (i_rst) begin
	 wcnt <= 5'd0;
      end
   end

   /*
    ********** Read side ***********
    */


   reg [4:0]  rcnt;
   wire [3:0] rslot = rcnt[4:1];
   wire       rport = rcnt[0];

   wire [5:0] rreg = rport ? i_rreg1 : i_rreg0;
   wire [9:0] raddr = {rreg, rslot};

   reg [1:0]  rdata;
   reg [1:0]  rdata0;
   reg 	      rdata1;


   assign o_rdata0 = !rport ? rdata0[0] : rdata0[1];
   assign o_rdata1 = rport ? rdata1 : rdata[0];

   reg 	      rreq_r;

   always @(posedge i_clk) begin
      rcnt <= rcnt+5'd1;
      if (i_rreq)
	 rcnt <= 5'd0;

      rreq_r <= i_rreq;
      o_rgnt <= rreq_r;

      if (rport)
	rdata0 <= rdata;
      if (!rport)
	rdata1 <= rdata[1];

      if (i_rst) begin
	 o_rgnt <= 1'b0;
	 rreq_r <= 1'b0;
      end
   end


   reg [1:0]  memory [0:575];

   always @(posedge i_clk) begin
      if (wen)
`ifdef RISCV_FORMAL
	if (!i_rst)
`endif
	memory[waddr] <= wdata;
      rdata <= memory[raddr];
   end

`ifdef RISCV_FORMAL
 `define SERV_CLEAR_RAM
`endif

`ifdef SERV_CLEAR_RAM
   integer i;
   initial
     for (i=0;i<512;i=i+1)
       memory[i] = 2'd0;
`endif

endmodule
