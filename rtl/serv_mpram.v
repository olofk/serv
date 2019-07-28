`default_nettype none
module serv_mpram
  (
   input wire 	    i_clk,
   input wire 	    i_rst,
   //Trap interface
   input wire 	    i_trap,
   input wire 	    i_mepc,
   input wire 	    i_mtval,
   output wire 	    o_csr_pc,
   //CSR interface
   input wire 	    i_csr_en,
   input wire [1:0] i_csr_addr,
   input wire 	    i_csr,
   output wire 	    o_csr,
   //RD write port
   input wire 	    i_rd_wen,
   input wire [4:0] i_rd_waddr,
   input wire 	    i_rd,

   input wire 	    i_rreq,
   output reg 	    o_rgnt,
   //RS1 read port
   input wire [4:0] i_rs1_raddr,
   output wire 	    o_rs1,
   //RS2 read port
   input wire [4:0] i_rs2_raddr,
   output wire 	    o_rs2);

`include "serv_params.vh"

   wire [8:0] 	    waddr;

   reg [4:0] 	     wdata0;
   reg [5:0] 	     wdata1;

   wire [3:0] 	     wdata;

   wire 	     wen;
   reg [1:0] 	     wen_r;

   reg [3:0] 	     wcnt_lo;
   reg [2:0] 	     wcnt_hi;
   reg 		     wgo_r;

   assign wdata = wcnt_lo[0] ? wdata0[3:0] : wdata1[3:0];

   assign wen = !wgo_r & |(wen_r & wcnt_lo[1:0]);

   reg [4:0] 	     rd_waddr;

   //port 0 rd mtval
   //port 1 csr mepc
   //mepc  100010
   //mtval 100011
   //csr   1000xx
   //rd    0xxxxx
   wire [5:0] waddr0 = trap_3r ? {4'b1000,CSR_MTVAL} : {1'b0,rd_waddr};
   wire [5:0] waddr1 = trap_3r ? {4'b1000,CSR_MEPC}  : {4'b1000,i_csr_addr};
  
   assign waddr[8:3] = wcnt_lo[0] ? waddr0 : waddr1;
 
//   assign waddr[8] = wcnt_lo[1] | i_trap;
//   assign waddr[7:5] = (wcnt_lo[1] | i_trap) ? 3'b000 : rd_waddr[4:2];
//   assign waddr[4:3] = wcnt_lo[0] ? (i_trap ? CSR_MTVAL : rd_waddr[1:0]) :
//		                    (i_trap ? CSR_MEPC  : i_csr_addr);
   assign waddr[2:0] = wcnt_hi;

   wire 	     wgo = !(|wcnt_lo) & (i_rd_wen | i_csr_en | i_trap);

   reg 		     trap_r;
   reg 		     trap_2r;
   reg 		     trap_3r;

   always @(posedge i_clk) begin
      trap_r <= i_trap;
      trap_2r <= trap_r;
      trap_3r <= trap_2r;
      
      if (wgo) begin
	 wgo_r <= 1'b1;
	 wen_r <= {i_csr_en|i_trap,i_rd_wen|i_trap};
	 rd_waddr <= i_rd_waddr;
      end
      wdata0 <= {i_trap ? i_mtval : i_rd ,wdata0[4:1]};
      wdata1 <= {i_trap ? i_mepc  : i_csr,wdata1[5:1]};
      wcnt_lo <= {wcnt_lo[2:0],wcnt_lo[3] | wgo};
      if (wcnt_lo[3]) begin
	 wcnt_hi <= wcnt_hi + 1;
	 if (wcnt_hi == 3'd7) begin
	    wgo_r <= !wgo_r;
	    wcnt_lo[0] <= wgo_r;
	    wcnt_hi <= wcnt_hi + {2'b00,wgo_r};
	 end
      end
      if (i_rst) begin
	 wgo_r <= 1'b0;
	 wcnt_lo <= 4'd0;
	 wcnt_hi <= 3'd7;
      end
   end

   //0 : RS1
   //1 : RS2
   //2 : CSR
   reg [2:0] rcnt_hi;
   reg [3:0] rcnt_lo;

   wire [8:0] raddr;

   reg [3:0] rdata;

   reg [5:0] rdata0;
   reg [4:0] rdata1;
   reg [3:0] rdata2;
   //reg [3:0] rdata3;

   reg [2:0] rreq;


   always @(posedge i_clk) begin
      {o_rgnt,rreq} <= {rreq[2:0],i_rreq};
      if (rcnt_lo[3])
	rcnt_hi <= rcnt_hi + 1;
      if (i_rreq) begin
	 rcnt_lo <= 4'd1;
	 rcnt_hi <= 3'd0;
      end else
	rcnt_lo <= {rcnt_lo[2:0],rcnt_lo[3]};

      rdata0[4:0] <= rdata0[5:1];
      rdata1[3:0] <= rdata1[4:1];
      rdata2[2:0] <= rdata2[3:1];
      //rdata3[2:0] <= rdata3[3:1];

      if (rcnt_lo[1]) rdata0[5:2] <= rdata;
      if (rcnt_lo[2]) rdata1[4:1] <= rdata;
      if (rcnt_lo[3]) rdata2[3:0] <= rdata;
      //if (rcnt_lo[0]) rdata3[3:0] <= rdata;

      if (i_rst) begin
	 o_rgnt <= 1'b0;
	 rreq <= 3'd0;
      end
   end

   assign raddr[8] = rcnt_lo[2];
   assign raddr[7:5] = rcnt_lo[0] ? i_rs1_raddr[4:2] :
		       rcnt_lo[1] ? i_rs2_raddr[4:2] : 3'd0;
   assign raddr[4:3] = rcnt_lo[0] ? i_rs1_raddr[1:0] :
		       rcnt_lo[1] ? i_rs2_raddr[1:0] :
		       i_trap ? CSR_MTVEC : i_csr_addr;
   assign raddr[2:0] = rcnt_hi;

   assign o_rs1 = rdata0[0];
   assign o_rs2 = rdata1[0];
   assign o_csr = rdata2[0] & i_csr_en;
   assign o_csr_pc = rdata2[0];

   reg [3:0]  memory [0:511];

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
     for (i=0;i<256;i=i+1)
       memory[i] = 4'd0;
`endif

endmodule
