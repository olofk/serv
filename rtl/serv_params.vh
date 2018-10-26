localparam [1:0]
  RD_SOURCE_CTRL = 2'd0,
  RD_SOURCE_ALU  = 2'd1,
  RD_SOURCE_IMM  = 2'd2,
  RD_SOURCE_MEM = 2'd3;

localparam [0:0]
  OFFSET_SOURCE_IMM = 1'd0,
  OFFSET_SOURCE_RD  = 1'd1;

localparam [0:0]
  OP_B_SOURCE_IMM = 1'd0,
  OP_B_SOURCE_RS2 = 1'd1;
  
