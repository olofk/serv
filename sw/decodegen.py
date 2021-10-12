from sympy.logic import SOPform
from sympy import symbols
from functools import partial, reduce
from itertools import product, combinations
import networkx as nx
import z3

HEADER = """module serv_auto_decode
  #(parameter [0:0] MDU = 1'b0,
    parameter [0:0] CSR = 1'b0)
  (
   input wire i_clk,
   //Input
   input wire i_en,
   input wire i_imm30,
   input wire [2:0] i_funct3,
   input wire [4:0] i_opcode,
   //MDU/Ext/CSR
   input wire i_imm25,
   output reg [2:0] o_ext_funct3,
   output reg o_mdu_op,
   input wire i_op20,
   input wire i_op21,
   input wire i_op22,
   input wire i_op26,
   output reg o_e_op,
   output reg o_ebreak,
   output reg o_ctrl_mret,
   output reg o_csr_en,
   output reg o_csr_addr1,
   output reg o_csr_addr0,
   output reg o_csr_mstatus_en,
   output reg o_csr_mie_en,
   output reg o_csr_mcause_en,
   output reg o_csr_source1,
   output reg o_csr_source0,
   output reg o_csr_d_sel,
   output reg o_csr_imm_en,
   output reg o_rd_csr_en,
   //Output
   {ports});

{body}
endmodule
"""

def printmap(ctrlmap):
    s = ""
    l = max([len(x) for x in ctrlmap])
    s+=' '*(l+2)+"lajjbbbbbblllllsssassxoasssassssxssoa\n"
    s+=' '*(l+2)+"uuaaenlglgbhwbhbhwdllornlrrdulllorrrn\n"
    s+=' '*(l+2)+"iillqetete   uu   dttridlladblttrla d\n"
    s+=' '*(l+2)+" p r    uu        iiii iiii    u     \n"
    s+=' '*(l+2)+" c                  u                \n"

    for k,v in ctrlmap.items():
        s += f"{k:<{l}} |{v}|\n"
    s += f"{len(ctrlmap)} signals\n"
    return s
        
def merge(d, dst, src):
    l = list(d[dst])
    for i in range(len(l)):
        if l[i] == ' ':
            l[i] = d[src][i]
        elif l[i] == '1' and d[src][i] == '0':
            raise Exception
        elif l[i] == '0' and d[src][i] == '1':
            raise Exception
    d[dst] = ''.join(l)
    d.pop(src)

def merge_signals(ctrlmap):
    #Merge control signals and keep track of which signals that have been combined

    # We build a graph of signals as nodes and merge conflicts as edges. We use z3 to find
    # an optimal coloring of the graph. All nodes of the same color will have no conflicts
    # and can be merged

    solver = z3.Optimize()

    node_colors = {}

    g = nx.Graph()

    color_count = z3.Int('color_count')

    # Create a node for every signal
    for sig in ctrlmap:
        g.add_node(sig)
        node_colors[sig] = node_color = z3.Int('color_' + sig)

        solver.add(node_color >= 0, node_color < color_count)

    # Conflicting signals may not get the same color
    for sig_i, sig_j in combinations(ctrlmap, 2):
        collide = any(
            i != j and ' ' not in (i, j)
            for i, j in zip(ctrlmap[sig_i], ctrlmap[sig_j])
        )
        if collide:
            g.add_edge(sig_i, sig_j)
            solver.add(node_colors[sig_i] != node_colors[sig_j])

    # We use networkx to find the largest clique. All nodes in that clique will have to get
    # distinct colors. Since the numbering of colors is arbitrary, we can without loss of
    # generality decide a fixed numbering of the colors of that clique. This kind of
    # symmetry breaking is essential for performance here.
    for i, sig in enumerate(max(nx.find_cliques(g), key=len)):
        solver.add(node_colors[sig] == i)

    solver.minimize(color_count)

    if solver.check() != z3.sat:
        raise Exception("optmization failed") # Shouldn't happen

    model = solver.model()

    print(f"Found coloring using {model[color_count]} colors")

    merged_signals = {}
    merge_by_color = {}

    for signal in list(ctrlmap):
        color = model[node_colors[signal]]
        if color in merge_by_color:
            other_signal = merge_by_color[color]
            merge(ctrlmap, other_signal, signal)
            merged_signals.setdefault(other_signal, []).append(signal)
        else:
            merge_by_color[color] = signal

    if merged_signals:
        for k,v in merged_signals.items():
            print(f"Merged {', '.join(v)} into {k}")
    return (ctrlmap, merged_signals)

def map2signals(ctrlmap):
    for k,v in ctrlmap.items():
        ctrl_signals = {}
        t = []
        f = []
        for i,op in enumerate(ops):
            #Only rv32i for now
            if i > 36:
                continue

            if v[i] == '1':
                t.append(op)
            elif v[i] == '0':
                f.append(op)
        ctrl_signals[k] = (t,f)
    return ctrl_signals

def minterms(s):
    return list(map(partial(reduce, lambda x, y: 2*x + y), product(*([0, 1] if z == 'x' else [int(z)] for z in s))))

def map2minterms(bitmap):
    m = []
    falsies = []
    for i,op in enumerate(ops):
        #Only rv32i for now
        if i > 36:
            continue

        if bitmap[i] == '1':
            m += minterms(ops[op])
        elif bitmap[i] == '0':
            falsies += minterms(ops[op])
    return (m, falsies)

def write_post_reg_logic_decoder(ctrlmap, merged_signals):
    signames = [
        'i_imm30',
        'i_funct3[2]',
        'i_funct3[1]',
        'i_funct3[0]',
        'i_opcode[4]',
        'i_opcode[3]',
        'i_opcode[2]',
        'i_opcode[1]',
        'i_opcode[0]',
    ]
    syms = [*symbols(' '.join(signames))]
    ports = []
    body = '\n'.join('//'+x for x in printmap(ctrlmap).split('\n'))
    body += "\nalways @(posedge i_clk)\n"
    body += "   if (i_en) begin\n"
    body2 ="   end\n\n"
    for sig, bitmap in ctrlmap.items():
        #Find all conditions signals must be true and false
        (t, f) = map2minterms(bitmap)

        #Use Quine-McCluskey to minimize the logic expressions needed for each
        #control signal. Don't cares are the ones that are neither listed as
        #true or false
        dc = set(range(2**9))-set(t)-set(f)
        s = SOPform(syms, t, dc)

        ports.append(f"output reg o_{sig}")

        #Output final control signal expression
        body += f"      o_{sig} <= {s};\n"
        if sig in merged_signals:
            for alias in merged_signals[sig]:
                ports.append(f"output wire o_{alias}")
                body2 += f"   assign o_{alias} = o_{sig};\n"

    #Some extra signals
    body += "   //MDU/CSR/Ext\n"
    body += "   o_mdu_op <= MDU & (i_opcode == 5'b01100) & i_imm25;\n"
    body += "   o_ext_funct3 <= i_funct3;\n"
    body += "   o_ebreak <= i_op20;\n"
    body += "   o_rd_csr_en <= i_opcode[4] & i_opcode[2] &  (|i_funct3);\n"
    body += "   o_ctrl_mret <= i_opcode[4] & i_opcode[2] & !(|i_funct3) &  i_op21;\n"
    body += "   o_e_op      <= i_opcode[4] & i_opcode[2] & !(|i_funct3) & !i_op21;\n"
    body += "   o_csr_en         <= i_op20 | (i_op26 & !i_op21);\n"
    body += "   o_csr_mstatus_en <= !i_op26 & !i_op22;\n"
    body += "   o_csr_mie_en     <= !i_op26 &  i_op22 & !i_op20;\n"
    body += "   o_csr_mcause_en  <=          i_op21 & !i_op20;\n"
    body += "   o_csr_source1 <= i_funct3[1];\n"
    body += "   o_csr_source0 <= i_funct3[0];\n"
    body += "   o_csr_d_sel   <= i_funct3[2];\n"
    body += "   o_csr_imm_en  <= i_opcode[4] & i_opcode[2] & i_funct3[2];\n"
    body += "   o_csr_addr1   <= i_op26 & i_op20;\n"
    body += "   o_csr_addr0   <= !i_op26 | i_op21;\n"

    with open('serv_post_reg_decode.v', 'w') as f:
        f.write(HEADER.format(ports=',\n   '.join(ports), body=body+body2+'\n'))

def write_pre_reg_logic_decoder(ctrlmap, merged_signals):
    signames = [
        'imm30',
        'funct3[2]',
        'funct3[1]',
        'funct3[0]',
        'opcode[4]',
        'opcode[3]',
        'opcode[2]',
        'opcode[1]',
        'opcode[0]',
    ]
    syms = [*symbols(' '.join(signames))]
    ports = []
    body = """   reg imm30;
   reg [2:0] funct3;
   reg [4:0] opcode;

always @(posedge i_clk)
   if (i_en) begin
      imm30 <= i_imm30;
      funct3 <= i_funct3;
      opcode <= i_opcode;
   end
"""

    for sig, bitmap in ctrlmap.items():
        #Find all conditions signals must be true and false
        (t, f) = map2minterms(bitmap)

        #Use Quine-McCluskey to minimize the logic expressions needed for each
        #control signal. Don't cares are the ones that are neither listed as
        #true or false
        dc = set(range(2**9))-set(t)-set(f)
        s = SOPform(syms, t, dc)

        ports.append(f"output wire o_{sig}")

        #Output final control signal expression
        body += f"   assign o_{sig} = {s};\n"
        if sig in merged_signals:
            for alias in merged_signals[sig]:
                ports.append(f"output wire o_{alias}")
                body += f"   assign o_{alias} = o_{sig};"

    #Some extra signals
    body += "\n"
    body += "   //MDU/CSR/Ext\n"
    body += "always @(posedge i_clk)\n"
    body += "   if (i_en) begin\n"
    body += "      imm25 <= i_imm25;\n"
    body += "      funct3 <= i_funct3;\n"
    body += "      opcode <= i_opcode;\n"
    body += "      op20 <= i_op20;\n"
    body += "      op21 <= i_op21;\n"
    body += "      op22 <= i_op22;\n"
    body += "      op26 <= i_op26;\n"
    body += "   end\n"
    body += "   assign o_mdu_op = MDU & (opcode == 5'b01100) & imm25;\n"
    body += "   assign o_ext_funct3 = funct3;\n"
    body += "   assign o_ebreak = op20;\n"
    body += "   assign o_rd_csr_en = opcode[4] & opcode[2] &  (|funct3);\n"
    body += "   assign o_ctrl_mret = opcode[4] & opcode[2] & !(|funct3) &  op21;\n"
    body += "   assign o_e_op      = opcode[4] & opcode[2] & !(|funct3) & !op21;\n"
    body += "   assign o_csr_en         = op20 | (op26 & !op21);\n"
    body += "   assign o_csr_mstatus_en = !op26 & !op22;\n"
    body += "   assign o_csr_mie_en     = !op26 &  op22 & !op20;\n"
    body += "   assign o_csr_mcause_en  =          op21 & !op20;\n"
    body += "   assign o_csr_source1 = funct3[1];\n"
    body += "   assign o_csr_source0 = funct3[0];\n"
    body += "   assign o_csr_d_sel   = funct3[2];\n"
    body += "   assign o_csr_imm_en  = opcode[4] & opcode[2] & funct3[2];\n"
    body += "   assign o_csr_addr1   = op26 & op20;\n"
    body += "   assign o_csr_addr0   = !op26 | op21;\n"

    with open('serv_pre_reg_decode.v', 'w') as f:
        f.write(HEADER.format(ports=',\n   '.join(ports), body=body))

def write_mem_decoder(ctrlmap, merged_signals):
    ports = []
    mem = [0]*512

    width = len(ctrlmap)
    body = """   (* ram_style = "block" *) reg [{msb}:0] mem [0:511];
   reg [{msb}:0] d;

   initial begin
{mem}   end

always @(posedge i_clk)
   if (i_en)
      d <= mem[{{i_imm30,i_funct3,i_opcode}}];

"""

    s = ""
    for i, (sig, bitmap) in enumerate(ctrlmap.items()):
        #Find all conditions signals must be true
        #Rest can be zero
        (t, _) = map2minterms(bitmap)
        for x in t:
            mem[x] += 2**i
        body += f"   assign o_{sig} = d[{i}];\n"

        ports.append(f"output wire o_{sig}")

        if sig in merged_signals:
            for alias in merged_signals[sig]:
                ports.append(f"output wire o_{alias}")
                body += f"   assign o_{alias} = o_{sig};\n"

    for i, m in enumerate(mem):
        s += f"      mem[{i}] = {width}'h{m:0{(width+3)//4}x};\n"

    body += "\nalways @(posedge i_clk) begin\n"
    body += "if (i_en) begin\n"
    body += "   //MDU/CSR/Ext\n"
    body += "   o_mdu_op     <= MDU & (i_opcode == 5'b01100) & i_imm25;\n"
    body += "   o_ext_funct3 <=  MDU ? i_funct3 : 3'b000;\n"
    body += "   o_ebreak         <= CSR & (i_op20);\n"
    body += "   o_rd_csr_en      <= CSR & (i_opcode[4] & i_opcode[2] &  (|i_funct3));\n"
    body += "   o_ctrl_mret      <= CSR & (i_opcode[4] & i_opcode[2] & !(|i_funct3) &  i_op21);\n"
    body += "   o_e_op           <= CSR & (i_opcode[4] & i_opcode[2] & !(|i_funct3) & !i_op21);\n"
    body += "   o_csr_en         <= CSR & (i_op20 | (i_op26 & !i_op21));\n"
    body += "   o_csr_mstatus_en <= CSR & (!i_op26 & !i_op22);\n"
    body += "   o_csr_mie_en     <= CSR & (!i_op26 &  i_op22 & !i_op20);\n"
    body += "   o_csr_mcause_en  <= CSR & (         i_op21 & !i_op20);\n"
    body += "   o_csr_source1    <= CSR & (i_funct3[1]);\n"
    body += "   o_csr_source0    <= CSR & (i_funct3[0]);\n"
    body += "   o_csr_d_sel      <= CSR & (i_funct3[2]);\n"
    body += "   o_csr_imm_en     <= CSR & (i_opcode[4] & i_opcode[2] & i_funct3[2]);\n"
    body += "   o_csr_addr1      <= CSR & (i_op26 & i_op20);\n"
    body += "   o_csr_addr0      <= CSR & (!i_op26 | i_op21);\n"
    body += "end\n"
    body += "end\n"
        
    with open('serv_mem_decode.v', 'w') as f:
        f.write(HEADER.format(ports=',\n   '.join(ports), body=body.format(msb=width-1, mem=s)))


#imm30, funct3, opcode
ops = {
    'lui'   : 'x' + 'xxx' + '01101',
    'auipc' : 'x' + 'xxx' + '00101',
    'jal'   : 'x' + 'xxx' + '11011',
    'jalr'  : 'x' + 'xxx' + '11001',#funct3 = 000?
    'beq'   : 'x' + '000' + '11000',
    'bne'   : 'x' + '001' + '11000',
    'blt'   : 'x' + '100' + '11000',
    'bge'   : 'x' + '101' + '11000',
    'bltu'  : 'x' + '110' + '11000',
    'bgeu'  : 'x' + '111' + '11000',
    'lb'    : 'x' + '000' + '00000',
    'lh'    : 'x' + '001' + '00000',
    'lw'    : 'x' + '010' + '00000',
    'lbu'   : 'x' + '100' + '00000',
    'lhu'   : 'x' + '101' + '00000',
    'sb'    : 'x' + '000' + '01000',
    'sh'    : 'x' + '001' + '01000',
    'sw'    : 'x' + '010' + '01000',
    'addi'  : 'x' + '000' + '00100',
    'slti'  : 'x' + '010' + '00100',
    'sltiu' : 'x' + '011' + '00100',
    'xori'  : 'x' + '100' + '00100',
    'ori'   : 'x' + '110' + '00100',
    'andi'  : 'x' + '111' + '00100',
    'slli'  : '0' + '001' + '00100',
    'srli'  : '0' + '101' + '00100',
    'srai'  : '1' + '101' + '00100',
    'add'   : '0' + '000' + '01100',
    'sub'   : '1' + '000' + '01100',
    'sll'   : '0' + '001' + '01100',
    'slt'   : '0' + '010' + '01100',
    'sltu'  : '0' + '011' + '01100',
    'xor'   : '0' + '100' + '01100',
    'srl'   : '0' + '101' + '01100',
    'sra'   : '1' + '101' + '01100',
    'or'    : '0' + '110' + '01100',
    'and'   : '0' + '111' + '01100',
    'fence' : 'x' + 'xxx' + '00011',#funct3=000?
    'ecall' : 'x' + '000' + '11100',#ebreak same but op20=1
    'csrrw' : 'x' + '001' + '11100',
    'csrrs' : 'x' + '010' + '11100',
    'csrrc' : 'x' + '011' + '11100',
    'csrrwi': 'x' + '101' + '11100',
    'csrrsi': 'x' + '110' + '11100',
    'csrrci': 'x' + '111' + '11100',
}

###################################
###################################
###################################


#Map of all required true/false conditions for each op.
#This should ideally be created automatically from riscv-formal runs
#TODO: Extend with optional ISA extensions (M, Zicsr, Zifencei..)

#ebreak = ecall with op20=1
ctrlmap = \
{
                        #UUJRBBBBBBIIIIISSSIIIIIIIIIRRRRRRRRRR
                        #lajjbbbbbblllllsssassxoasssassssxssoa
                        #uuaaenlglgbhwbhbhwdllornlrrdulllorrrn
                        #iillqetete   uu   dttridlladblttrla d
                        # p r    uu        iiii iiii    u
                        # c                  u
    'branch_op'       : '  1111111100000000 00   000  000 00  ',
    'slt_or_branch'   : '  1111111100000000 11   000  011 00  ',
    'op_b_source'     : '  11111111000001110000000001111111111',
    'immdec_ctrl0'    : '  0 11111100000111000000000          ',
    'immdec_ctrl1'    : '000       11111111111111111          ',
    'immdec_ctrl2'    : '000 11111100000000000000000          ',
    'immdec_ctrl3'    : '001                                  ',
    'immdec_en0'      : '0000111111000001110000000000000000000',
    'immdec_en1'      : '1110000000000000000000000000000000000',
    'immdec_en2'      : '1111000000111110001111111110000000000',
    'immdec_en3'      : '1110111111111111111111111110000000000',
    'bne_or_bge'      : '    010101                           ',
    'sh_right'        : '                        011  0   11  ',
    'cond_branch'     : '  00111111                           ',
    'shift_op'        : '  0000000000000000 00   111  100 11  ',
    'two_stage_op'    : '0011111111111111110110001110011101100',
    'rd_alu_en'       : '0000      00000   1111111111111111111',
    'rd_mem_en'       : '0000      11111   0000000000000000000',
    'dbus_en'         : '  0000000011111111 00   000  000 00  ',
    'bufreg_rs1_en'   : '  0100000011111111      111  1   11  ',
    'bufreg_imm_en'   : '  1111111111111111      000  0   00  ',
    'bufreg_clr_lsb'  : '  1011111100000000      000  0   00  ',
    'bufreg_sh_signed': '                         01      01  ',
    'ctrl_jal_or_jalr': '0011      00000   0000000000000000000',
    'ctrl_utype'      : '110000000000000   0000000000000000000',
    'ctrl_pc_rel'     : '0110111111                           ',
    'rd_op'           : '1111000000111110001111111111111111111',
    'alu_sub'         : '    111111        011      01 11     ',
    'alu_bool_op1'    : '                     011000  0  00011',
    'alu_bool_op0'    : '                     001111  1  01101',
    'alu_cmp_eq'      : '    110000         00         00     ',
    'alu_cmp_sig'     : '      1100         10         10     ',
    'alu_rd_sel0'     : '                  1000000001100000000',
    'alu_rd_sel1'     : '                  0110000000001100000',
    'alu_rd_sel2'     : '                  0001110000000010011',
    'mem_signed'      : '          11 00                      ',
    'mem_word'        : '          00100001                   ',
    'mem_half'        : '          01001010                   ',
    'mem_cmd'         : '          00000111                   ',
#    'mtval_pc'        : '  1111111100000000                   ',
}

print(printmap(ctrlmap))

print("\nMerging control signals")
(ctrlmap, merged_signals) = merge_signals(ctrlmap)
print(printmap(ctrlmap))

#Create the various decoders
print("Creating mem decoder")
write_mem_decoder(ctrlmap, merged_signals)

#print("Writing post-registered logic decoder")
#write_post_reg_logic_decoder(ctrlmap, merged_signals)
#
#print("Writing pre-registered logic decoder")
#write_pre_reg_logic_decoder(ctrlmap, merged_signals)
