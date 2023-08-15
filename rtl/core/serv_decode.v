
module serv_decode
(
   input wire        clk,
   input wire        i_rst,
   //Input
   input wire [31:2] i_wb_rdt,
   input wire        i_wb_en,
   input wire        i_cnt_done,
   //To state
   output reg       o_sh_right,
   output reg       o_bne_or_bge,
   output reg       o_cond_branch,
   output reg       o_e_op,
   output reg       o_ebreak,
   output reg       o_branch_op,
   output reg       o_shift_op,
   output reg       o_slt_or_branch,
   output reg       o_rd_op,
   output reg       o_two_stage_op,
   output reg       o_dbus_en,
   //Extension
   output reg [2:0] o_ext_funct3,
   //To bufreg
   output reg       o_bufreg_rs1_en,
   output reg       o_bufreg_imm_en,
   output reg       o_bufreg_clr_lsb,
   output reg       o_bufreg_sh_signed,
   //To ctrl
   output reg       o_ctrl_jal_or_jalr,
   output reg       o_ctrl_utype,
   output reg       o_ctrl_pc_rel,
   output reg       o_ctrl_mret,
   output reg       o_ctrl_dret,
   //To alu
   output reg       o_alu_sub,
   output reg [1:0] o_alu_bool_op,
   output reg       o_alu_cmp_eq,
   output reg       o_alu_cmp_sig,
   output reg [2:0] o_alu_rd_sel,
   //To mem IF
   output reg       o_mem_signed,
   output reg       o_mem_word,
   output reg       o_mem_half,
   output reg       o_mem_cmd,
   //To CSR
   output reg       o_csr_en,
   output reg [2:0] o_csr_addr,
   output reg       o_csr_mstatus_en,
   output reg       o_csr_mie_en,
   output reg       o_csr_mcause_en,
   output reg       o_csr_misa_en,
   output reg       o_csr_mhartid_en,
   output reg       o_csr_dcsr_en,
   output reg [1:0] o_csr_source,
   output reg       o_csr_d_sel,
   output reg       o_csr_imm_en,
   output reg       o_mtval_pc,
   //To top
   output reg [3:0] o_immdec_ctrl,
   output reg [3:0] o_immdec_en,
   output reg       o_op_b_source,
   //To RF IF
   output reg       o_rd_mem_en,
   output reg       o_rd_csr_en,
   output reg       o_rd_alu_en,
   // Debug signal
   input  wire      i_dbg_halt,
   input  wire      i_dbg_step,
   output reg       o_dbg_process,
   output reg       o_dbg_delay
);

   reg [4:0] opcode;
   reg [2:0] funct3;
   reg        op20;
   reg        op21;
   reg        op22;
   reg        op26;
   reg        op27;
   reg        op29;
   reg        op31;
   
   
   reg       imm25;
   reg       imm30;

   wire co_two_stage_op =
	~opcode[2] | (funct3[0] & ~funct3[1] & ~opcode[0] & ~opcode[4]) |
	(funct3[1] & ~funct3[2] & ~opcode[0] & ~opcode[4]);
   wire co_shift_op = (opcode[2] & ~funct3[1]);
   wire co_slt_or_branch = (opcode[4] | (funct3[1] & opcode[2]) | (imm30 & opcode[2] & opcode[3] & ~funct3[2]));
   wire co_branch_op = opcode[4];
   wire co_dbus_en    = ~opcode[2] & ~opcode[4];
   wire co_mtval_pc   = opcode[4];   
   wire co_mem_word   = funct3[1];
   wire co_rd_alu_en  = !opcode[0] & opcode[2] & !opcode[4];
   wire co_rd_mem_en  = (!opcode[2] & !opcode[0]);

   //jal,branch =     imm
   //jalr       = rs1+imm
   //mem        = rs1+imm
   //shift      = rs1
   wire co_bufreg_rs1_en = !opcode[4] | (!opcode[1] & opcode[0]);
   wire co_bufreg_imm_en = !opcode[2];

   //Clear LSB of immediate for BRANCH and JAL ops
   //True for BRANCH and JAL
   //False for JALR/LOAD/STORE/OP/OPIMM?
   wire co_bufreg_clr_lsb = opcode[4] & ((opcode[1:0] == 2'b00) | (opcode[1:0] == 2'b11));

   //Conditional branch
   //True for BRANCH
   //False for JAL/JALR
   wire co_cond_branch = !opcode[0];

   wire co_ctrl_utype       = !opcode[4] & opcode[2] & opcode[0];
   wire co_ctrl_jal_or_jalr = opcode[4] & opcode[0];

   //PC-relative operations
   //True for jal, b* auipc, ebreak
   //False for jalr, lui
   wire co_ctrl_pc_rel = (opcode[2:0] == 3'b000)  |
                          (opcode[1:0] == 2'b11)  |
                          (opcode[4] & opcode[2]) & op20|
                          (opcode[4:3] == 2'b00);
   //Write to RD
   //True for OP-IMM, AUIPC, OP, LUI, SYSTEM, JALR, JAL, LOAD
   //False for STORE, BRANCH, MISC-MEM
   wire co_rd_op = (opcode[2] |
                     (!opcode[2] & opcode[4] & opcode[0]) |
                     (!opcode[2] & !opcode[3] & !opcode[0]));

   //
   //funct3
   //

   wire co_sh_right   = funct3[2];
   wire co_bne_or_bge = funct3[0];

   //Matches system ops except eceall/ebreak/mret
   wire csr_op = opcode[4] & opcode[2] & (|funct3);


   //op20
//   wire co_ebreak = &{op20, opcode[4:2]};
    wire co_ebreak = op20 && (opcode == 5'b11100) && (funct3 == 3'b000);

   //opcode & funct3 & op21

   wire co_ctrl_mret = opcode[4] & opcode[2] & op21 & !(|funct3);
   wire co_ctrl_dret = opcode[4] & opcode[2] & !(|funct3) & imm30;
   //Matches system opcodes except CSR accesses (funct3 == 0)
   //and mret (!op21)
   wire co_e_op = opcode[4] & opcode[2] & !op21 & !(|funct3);

   //opcode & funct3 & imm30

   wire co_bufreg_sh_signed = imm30;

   /*
    True for sub, b*, slt*
    False for add*
    op    opcode f3  i30
    b*    11000  xxx x   t
    addi  00100  000 x   f
    slt*  0x100  01x x   t
    add   01100  000 0   f
    sub   01100  000 1   t
    */
   wire co_alu_sub = funct3[1] | funct3[0] | (opcode[3] & imm30) | opcode[4];

   /*
    Bits 30, 26, 22, 21 and 20 are enough to uniquely identify the eight supported CSR regs
    mtvec, mscratch, mepc and mtval are stored externally (normally in the RF) and are
    treated differently from mstatus, mie and mcause which are stored in serv_csr.

    The former get a 2-bit address as seen below while the latter get a
    one-hot enable signal each.

                         hex
                         addr
    Hex|32 222|Reg      |2222|
    adr|06 210|name     |7210|
    ---|------|---------|----|
    300|00_000|mstatus  |xxxx|
    304|00_100|mie      |xxxx|
    342|01_010|mcause   |xxxx|
    7b0|10_000|dcsr     |xxxx|
    301|00_001|misa     |xxxx|    |op22|!op21|
    344|01_100|mip      |xxxx|    |or  |and  |csr
    f14|10_100|mhartid  |xxxx|op27|op21|op20 |addr
    ---|------|---------|----|----|----|-----|---- 
    305|00_101|mtvec    |0101| 0  | 1  | 1   | 3 -- 010_011
    340|01_000|mscratch |0000| 0  | 0  | 0   | 0 -- 010_000
    341|01_001|mepc     |0001| 0  | 0  | 1   | 1 -- 010_001
    343|01_011|mtval    |0011| 0  | 1  | 0   | 2 -- 010_010
    7b1|10_001|dpc      |1001| 1  | 0  | 1   | 5 -- 010_101
    7b2|10_010|dscratch0|1010| 1  | 1  | 0   | 6 -- 010_110
    
    */

   //true  for mtvec,mscratch,mepc and mtval, dpc, dscratch0
   //false for mstatus, mie, mcause, mip, dcsr, mhartid, misa
//   wire csr_valid = op(op26 & !op21) | op20;
//   wire csr_valid = imm30 | (op26 & !op22 & !op21) | op20;
   wire csr_valid = (imm30 & (op21 | op20)) | // dpc, dscratch0
                    ((op26 | op22) & op20)  | // mtvec, mepc, mtval
                    (op26 & !(op22 | op21));  // mscratch
   
   wire co_rd_csr_en = csr_op;
   
   // for valid csr (stored in rf)
   wire co_csr_en         = csr_op & csr_valid;
   // for invalid csr (process in serv_csr)
//   wire co_csr_mstatus_en = csr_op & !op22  & !op21 & !op20;
//   wire co_csr_mie_en     = csr_op & !imm30 & !op26 &  op22;
//   wire co_csr_mcause_en  = csr_op &  op21  & !op20;
//   wire co_csr_misa_en    = csr_op &  op20;
//   wire co_csr_mhartid_en = csr_op &  imm30 & op22;
//   wire co_csr_dcsr_en    = csr_op &  imm30 & !op22;
   
   wire co_csr_mstatus_en = ({imm30, op26, op22, op21, op20} == 5'b00_000) & csr_op;
   wire co_csr_mie_en     = ({imm30, op26, op22, op21, op20} == 5'b00_100) & csr_op;
   wire co_csr_mcause_en  = ({imm30, op26, op22, op21, op20} == 5'b01_010) & csr_op;
   wire co_csr_misa_en    = ({imm30, op26, op22, op21, op20} == 5'b00_001) & csr_op;
   wire co_csr_mhartid_en = ({imm30, op26, op22, op21, op20} == 5'b10_100) & csr_op;
   wire co_csr_dcsr_en    = ({imm30, op26, op22, op21, op20} == 5'b10_000) & csr_op;
   //4000_0500
   //0100_0000_0000_0000_0000_0101_0000_0000
   wire [1:0] co_csr_source = funct3[1:0];
   wire co_csr_d_sel = funct3[2];
   wire co_csr_imm_en = opcode[4] & opcode[2] & funct3[2];
//   wire [2:0] co_csr_addr = {op26 & op20, !op26 | op21};
   wire [2:0] co_csr_addr = {op27, op22 | op21, !op21 & op20};
   wire co_alu_cmp_eq = funct3[2:1] == 2'b00;

   wire co_alu_cmp_sig = ~((funct3[0] & funct3[1]) | (funct3[1] & funct3[2]));

   wire co_mem_cmd  = opcode[3];
   wire co_mem_signed = ~funct3[2];
   wire co_mem_half   = funct3[0];

   wire [1:0] co_alu_bool_op = funct3[1:0];

   wire [3:0] co_immdec_ctrl;
   //True for S (STORE) or B (BRANCH) type instructions
   //False for J type instructions
   assign co_immdec_ctrl[0] = opcode[3:0] == 4'b1000;
   //True for OP-IMM, LOAD, STORE, JALR  (I S)
   //False for LUI, AUIPC, JAL           (U J)
   assign co_immdec_ctrl[1] = (opcode[1:0] == 2'b00) | (opcode[2:1] == 2'b00);
   assign co_immdec_ctrl[2] = opcode[4] & !opcode[0];
   assign co_immdec_ctrl[3] = opcode[4];

   wire [3:0] co_immdec_en;
   assign co_immdec_en[3] = opcode[4] | opcode[3] | opcode[2] | !opcode[0];                 //B I J S U
   assign co_immdec_en[2] = (opcode[4] & opcode[2]) | !opcode[3] | opcode[0];               //  I J   U
   assign co_immdec_en[1] = (opcode[2:1] == 2'b01) | (opcode[2] & opcode[0]) | co_csr_imm_en;//    J   U
   assign co_immdec_en[0] = ~co_rd_op;                                                       //B     S

   wire [2:0] co_alu_rd_sel;
   assign co_alu_rd_sel[0] = (funct3 == 3'b000); // Add/sub
   assign co_alu_rd_sel[1] = (funct3[2:1] == 2'b01); //SLT*
   assign co_alu_rd_sel[2] = funct3[2]; //Bool

   //0 (OP_B_SOURCE_IMM) when OPIMM
   //1 (OP_B_SOURCE_RS2) when BRANCH or OP
   wire co_op_b_source = opcode[3];

   wire enter_debug = (i_dbg_halt | i_dbg_step) & !(o_dbg_delay | o_dbg_process);
   
    always @(posedge clk) begin
        if (i_rst) begin // NOP
            funct3 <= 3'b000;
            imm30  <= 1'b0;
            imm25  <= 1'b0;
            opcode <= 5'b00100;
            op20   <= 1'b0;
            op21   <= 1'b0;
            op22   <= 1'b0;
            op26   <= 1'b0;
            op27   <= 1'b0;
            op29   <= 1'b0;
            op31   <= 1'b0;
        end
        else if (i_wb_en) begin
            // wire co_ebreak = op20 && (opcode == 5'b11100) && (funct3 == 3'b000);
            // wire co_e_op = opcode[4] & opcode[2] & !op21 & !(|funct3);
            // When enter debug mode, the fetch instruction is replaced by ebreak
//            funct3 <= i_wb_rdt[14:12] & {3{!enter_debug}};
            funct3 <= i_wb_rdt[14:12] & {3{!enter_debug}};
            imm30  <= i_wb_rdt[30];
            imm25  <= i_wb_rdt[25];
//            opcode <= i_wb_rdt[6:2];
            opcode[4:2] <= i_wb_rdt[6:4] | {3{enter_debug}};
            opcode[1:0] <= i_wb_rdt[3:2] & {2{!enter_debug}};
            op20   <= i_wb_rdt[20] | enter_debug;
            op21   <= i_wb_rdt[21] & !enter_debug;
            op22   <= i_wb_rdt[22];
            op26   <= i_wb_rdt[26];
            op27   <= i_wb_rdt[27];
            op29   <= i_wb_rdt[29];
            op31   <= i_wb_rdt[31];
            

        end
        
        if (i_rst) o_dbg_process <= 1'b0;
        else begin
//            if (&{i_wb_rdt[20], i_wb_rdt[6:4]}) o_dbg_process <= 1'b1;
//            else if (co_ctrl_dret && i_cnt_done) o_dbg_process <= 1'b0;  
            if (co_ebreak) o_dbg_process <= 1'b1;
            else if (co_ctrl_dret && i_cnt_done) o_dbg_process <= 1'b0;        
        end
        
        if (i_rst) o_dbg_delay <= 1'b1;
        else begin
            if (i_cnt_done && o_dbg_process) o_dbg_delay <= 1'b1;
            else if (i_cnt_done && o_dbg_delay) o_dbg_delay <= 1'b0;
        end
    end
    
    always @(*) begin
        o_sh_right         = co_sh_right;
        o_bne_or_bge       = co_bne_or_bge;
        o_cond_branch      = co_cond_branch;
        o_dbus_en          = co_dbus_en;
        o_mtval_pc         = co_mtval_pc;
        o_two_stage_op     = co_two_stage_op;
        o_e_op             = co_e_op;
        o_ebreak           = co_ebreak;
        o_branch_op        = co_branch_op;
        o_shift_op         = co_shift_op;
        o_slt_or_branch    = co_slt_or_branch;
        o_rd_op            = co_rd_op;
        o_bufreg_rs1_en    = co_bufreg_rs1_en;
        o_bufreg_imm_en    = co_bufreg_imm_en;
        o_bufreg_clr_lsb   = co_bufreg_clr_lsb;
        o_bufreg_sh_signed = co_bufreg_sh_signed;
        o_ctrl_jal_or_jalr = co_ctrl_jal_or_jalr;
        o_ctrl_utype       = co_ctrl_utype;
        o_ctrl_pc_rel      = co_ctrl_pc_rel;
        o_ctrl_mret        = co_ctrl_mret;
        o_ctrl_dret        = co_ctrl_dret;
        o_alu_sub          = co_alu_sub;
        o_alu_bool_op      = co_alu_bool_op;
        o_alu_cmp_eq       = co_alu_cmp_eq;
        o_alu_cmp_sig      = co_alu_cmp_sig;
        o_alu_rd_sel       = co_alu_rd_sel;
        o_mem_signed       = co_mem_signed;
        o_mem_word         = co_mem_word;
        o_mem_half         = co_mem_half;
        o_mem_cmd          = co_mem_cmd;
        o_csr_en           = co_csr_en;
        o_csr_addr         = co_csr_addr;
        o_csr_mstatus_en   = co_csr_mstatus_en;
        o_csr_mie_en       = co_csr_mie_en;
        o_csr_mcause_en    = co_csr_mcause_en;
        o_csr_misa_en      = co_csr_misa_en;
        o_csr_mhartid_en   = co_csr_mhartid_en;
        o_csr_dcsr_en      = co_csr_dcsr_en;
        o_csr_source       = co_csr_source;
        o_csr_d_sel        = co_csr_d_sel;
        o_csr_imm_en       = co_csr_imm_en;
        o_immdec_ctrl      = co_immdec_ctrl;
        o_immdec_en        = co_immdec_en;
        o_op_b_source      = co_op_b_source;
        o_rd_csr_en        = co_rd_csr_en;
        o_rd_alu_en        = co_rd_alu_en;
        o_rd_mem_en        = co_rd_mem_en;
    end


endmodule
