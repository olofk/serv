`default_nettype none
module serv_regfile
  (
   input       i_clk,
   input       i_rd_en,
   input [4:0] i_rd_addr,
   input       i_rd,
   input [4:0] i_rs1_addr,
   input [4:0] i_rs2_addr,
   input       i_rs_en,
   output      o_rs1,
   output      o_rs2);

   //reg [31:0]  rf [0:31];

`ifndef SYNTHESIS
/*   always @(*)
     for (i=0;i<32;i=i+1) begin
        dbg_x1[i] = rf[i][1];
        dbg_x2[i] = rf[i][2];
        dbg_x3[i] = rf[i][3];
        dbg_x4[i] = rf[i][4];
        dbg_x5[i] = rf[i][5];
        dbg_x6[i] = rf[i][6];
        dbg_x7[i] = rf[i][7];
        dbg_x8[i] = rf[i][8];
        dbg_x9[i] = rf[i][9];
        dbg_x10[i] = rf[i][10];
        dbg_x11[i] = rf[i][11];
        dbg_x12[i] = rf[i][12];
        dbg_x13[i] = rf[i][13];
        dbg_x14[i] = rf[i][14];
        dbg_x15[i] = rf[i][15];
        dbg_x16[i] = rf[i][16];
        dbg_x17[i] = rf[i][17];
        dbg_x18[i] = rf[i][18];
        dbg_x19[i] = rf[i][19];
        dbg_x20[i] = rf[i][20];
        dbg_x21[i] = rf[i][21];
        dbg_x22[i] = rf[i][22];
        dbg_x23[i] = rf[i][23];
        dbg_x24[i] = rf[i][24];
        dbg_x25[i] = rf[i][25];
        dbg_x26[i] = rf[i][26];
        dbg_x27[i] = rf[i][27];
        dbg_x28[i] = rf[i][28];
        dbg_x29[i] = rf[i][29];
        dbg_x30[i] = rf[i][30];
        dbg_x31[i] = rf[i][31];
     end
  */    
   reg [31:0] dbg_x0 ;
   reg [31:0] dbg_x1 ;
   reg [31:0] dbg_x2 ;
   reg [31:0] dbg_x3 ;
   reg [31:0] dbg_x4 ;
   reg [31:0] dbg_x5 ;
   reg [31:0] dbg_x6 ;
   reg [31:0] dbg_x7 ;
   reg [31:0] dbg_x8 ;
   reg [31:0] dbg_x9 ;
   reg [31:0] dbg_x10;
   reg [31:0] dbg_x11;
   reg [31:0] dbg_x12;
   reg [31:0] dbg_x13;
   reg [31:0] dbg_x14;
   reg [31:0] dbg_x15;
   reg [31:0] dbg_x16;
   reg [31:0] dbg_x17;
   reg [31:0] dbg_x18;
   reg [31:0] dbg_x19;
   reg [31:0] dbg_x20;
   reg [31:0] dbg_x21;
   reg [31:0] dbg_x22;
   reg [31:0] dbg_x23;
   reg [31:0] dbg_x24;
   reg [31:0] dbg_x25;
   reg [31:0] dbg_x26;
   reg [31:0] dbg_x27;
   reg [31:0] dbg_x28;
   reg [31:0] dbg_x29;
   reg [31:0] dbg_x30;
   reg [31:0] dbg_x31;
   
   integer     i;
//   initial for (i=0; i<32; i=i+1) rf[i] = 0;
   `endif
      
   reg [4:0]   raddr = 5'd1;
   reg [4:0]   waddr = 5'd0;
//   reg [31:0]  rs = 32'd0;
   wire [31:0]  rs;

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
         //rf[waddr][i_rd_addr] <= i_rd;
      end

      if (i_rs_en)
        raddr <= raddr + 1;
      //rs <= rf[raddr2];
   end
   wire [4:0] raddr2 = raddr & {5{i_rs_en}};
   
   assign o_rs1 = (|i_rs1_addr) ? rs[i_rs1_addr] : 1'b0;
   assign o_rs2 = (|i_rs2_addr) ? rs[i_rs2_addr] : 1'b0;
   
endmodule
