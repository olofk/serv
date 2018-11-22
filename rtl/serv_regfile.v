`default_nettype none
module serv_regfile
  (
   input wire 	    i_clk,
   input wire 	    i_rd_en,
   input wire [4:0] i_rd_addr,
   input wire 	    i_rd,
   input wire [4:0] i_rs1_addr,
   input wire [4:0] i_rs2_addr,
   input wire 	    i_rs_en,
   output wire 	    o_rs1,
   output wire 	    o_rs2);

   reg [4:0]   raddr = 5'd1;
   reg [4:0]   waddr = 5'd0;

   wire [31:0]  rs;

   wire [4:0] 	raddr2 = raddr & {5{i_rs_en}};
   reg [31:0] mask;

   always @(i_rd_addr)
     mask = ~(1 << i_rd_addr);

   SB_RAM40_4K rf0
     (
      .RDATA (rs[15:0]),
      .RCLK (i_clk),
      .RCLKE (1'b1),
      .RE (1'b1),
      .RADDR ({6'd0,raddr2}),
      .WCLK  (i_clk),
      .WCLKE (1'b1),
      .WE (i_rd_en),
      .WADDR ({6'd0,waddr}),
      .MASK  (mask[15:0]),
      .WDATA ({16{i_rd}})
      );

   SB_RAM40_4K rf1
     (
      .RDATA (rs[31:16]),
      .RCLK (i_clk),
      .RCLKE (1'b1),
      .RE (1'b1),
      .RADDR ({6'd0,raddr2}),
      .WCLK  (i_clk),
      .WCLKE (1'b1),
      .WE (i_rd_en),
      .WADDR ({6'd0,waddr}),
      .MASK  (mask[31:16]),
      .WDATA ({16{i_rd}})
      );
   always @(posedge i_clk) begin
      if (i_rd_en) begin
         waddr <= waddr + 1;
      end

      if (i_rs_en)
        raddr <= raddr + 1;
   end

   assign o_rs1 = (|i_rs1_addr) ? rs[i_rs1_addr] : 1'b0;
   assign o_rs2 = (|i_rs2_addr) ? rs[i_rs2_addr] : 1'b0;

endmodule
