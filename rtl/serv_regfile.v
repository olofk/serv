`default_nettype none
module serv_regfile
  (
   input  clk,
   input  i_d,
   input  i_field_rs1,
   input  i_field_rs2,
   input  i_field_rd,
   input  i_rs_en,
   output o_rs1,
   output o_rs2,
   input  i_rd,
   input  i_rd_valid);

   reg [31:0] rf [0:31];

   function automatic [31:0] xreg;
      input [4:0] regnum;
      begin
         xreg = {rf[31][regnum],rf[30][regnum],rf[29][regnum],rf[28][regnum],
                 rf[27][regnum],rf[26][regnum],rf[25][regnum],rf[24][regnum],
                 rf[23][regnum],rf[22][regnum],rf[21][regnum],rf[20][regnum],
                 rf[19][regnum],rf[18][regnum],rf[17][regnum],rf[16][regnum],
                 rf[15][regnum],rf[14][regnum],rf[13][regnum],rf[12][regnum],
                 rf[11][regnum],rf[10][regnum],rf[9][regnum] ,rf[8][regnum],
                 rf[7][regnum] ,rf[6][regnum] ,rf[5][regnum] ,rf[4][regnum],
                 rf[3][regnum] ,rf[2][regnum] ,rf[1][regnum] ,rf[0][regnum]};
      end
   endfunction // xreg

   always @(*)
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
   
   

   reg [4:0]   raddr = 5'd0;
   reg [4:0]   waddr = 5'd0;
   reg [31:0]  rs = 32'd0;
   
   integer     i;
   initial for (i=0; i<32; i=i+1) rf[i] = 0;
      
   always @(posedge clk) begin
      if (i_rd_valid) begin
         waddr <= waddr + 1;
         rf[waddr][rd_addr] <= i_rd;
      end

      if (i_rs_en)
        rs <= rf[raddr];

   end

   wire [4:0] rs1_addr;
   wire [4:0] rs2_addr;
   wire [4:0] rd_addr;
   
   shift_reg #(5) shift_reg_rs1_addr
     (.clk   (clk),
      .i_en  (i_field_rs1),
      .i_d   (i_d),
      .o_q   (rs1_addr[0]),
      .o_par (rs1_addr[4:1]));
   
   shift_reg #(5) shift_reg_rs2_addr
     (.clk   (clk),
      .i_en  (i_field_rs2),
      .i_d   (i_d),
      .o_q   (rs2_addr[0]),
      .o_par (rs2_addr[4:1]));

   shift_reg #(5) shift_reg_rd_addr
     (.clk   (clk),
      .i_en  (i_field_rd),
      .i_d   (i_d),
      .o_q   (rd_addr[0]),
      .o_par (rd_addr[4:1]));

   assign o_rs1 = (|rs1_addr) ? rs[rs1_addr] : 1'b0;
   assign o_rs2 = (|rs2_addr) ? rs[rs2_addr] : 1'b0;
   
endmodule
