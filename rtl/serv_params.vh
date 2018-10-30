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
  
localparam[2:0]
  ALU_OP_ADD = 3'd0,
  ALU_OP_SL  = 3'd1,
  ALU_OP_SUB = 3'd2,
  ALU_OP_SLT = 3'd3,
  ALU_OP_XOR = 3'd4,
  ALU_OP_SR  = 3'd5,
  ALU_OP_OR  = 3'd6,
  ALU_OP_AND = 3'd7;

  
