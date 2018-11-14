localparam [2:0]
  RD_SOURCE_CTRL = 3'd0,
  RD_SOURCE_ALU  = 3'd1,
  RD_SOURCE_IMM  = 3'd2,
  RD_SOURCE_MEM  = 3'd3,
  RD_SOURCE_CSR  = 3'd4;

localparam [0:0]
  OFFSET_SOURCE_IMM = 1'd0,
  OFFSET_SOURCE_RS1 = 1'd1;

localparam [0:0]
  OP_B_SOURCE_IMM = 1'd0,
  OP_B_SOURCE_RS2 = 1'd1;

localparam[2:0]
  ALU_RESULT_ADD = 3'd0,
  ALU_RESULT_SR  = 3'd1,
  ALU_RESULT_LT  = 3'd2,
  ALU_RESULT_XOR = 3'd3,
  ALU_RESULT_OR  = 3'd4,
  ALU_RESULT_AND = 3'd5;

localparam [0:0]
  ALU_CMP_LT = 1'b0,
  ALU_CMP_EQ = 1'b1;

/*
 source
 ADD, SUB
 SL,SR
 SLT
 XOR,
 OR
 AND
*/

localparam [2:0]
  CSR_SEL_MTVEC   = 3'd0,
  CSR_SEL_MEPC    = 3'd1,
  CSR_SEL_MTVAL   = 3'd2,
  CSR_SEL_MCAUSE  = 3'd3
;

localparam [1:0]
  CSR_SOURCE_CSR = 2'b00,
  CSR_SOURCE_EXT = 2'b01,
  CSR_SOURCE_SET = 2'b10,
  CSR_SOURCE_CLR = 2'b11;
