localparam [1:0]
  CSR_SOURCE_CSR = 2'b00,
  CSR_SOURCE_EXT = 2'b01,
  CSR_SOURCE_SET = 2'b10,
  CSR_SOURCE_CLR = 2'b11;

localparam [1:0]
  CSR_MSCRATCH = 2'b00,
  CSR_MTVEC    = 2'b01,
  CSR_MEPC     = 2'b10,
  CSR_MTVAL    = 2'b11;
