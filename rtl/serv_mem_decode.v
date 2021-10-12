module serv_auto_decode
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
   output wire o_branch_op,
   output wire o_ctrl_jal_or_jalr,
   output wire o_slt_or_branch,
   output wire o_alu_sub,
   output wire o_alu_bool_op1,
   output wire o_op_b_source,
   output wire o_mem_cmd,
   output wire o_immdec_ctrl0,
   output wire o_immdec_en0,
   output wire o_immdec_ctrl1,
   output wire o_bufreg_rs1_en,
   output wire o_immdec_ctrl2,
   output wire o_cond_branch,
   output wire o_immdec_ctrl3,
   output wire o_two_stage_op,
   output wire o_immdec_en1,
   output wire o_immdec_en2,
   output wire o_immdec_en3,
   output wire o_bne_or_bge,
   output wire o_rd_alu_en,
   output wire o_sh_right,
   output wire o_alu_cmp_sig,
   output wire o_mem_signed,
   output wire o_shift_op,
   output wire o_alu_bool_op0,
   output wire o_rd_mem_en,
   output wire o_dbus_en,
   output wire o_bufreg_imm_en,
   output wire o_alu_rd_sel0,
   output wire o_bufreg_clr_lsb,
   output wire o_ctrl_pc_rel,
   output wire o_alu_rd_sel1,
   output wire o_bufreg_sh_signed,
   output wire o_alu_cmp_eq,
   output wire o_mem_half,
   output wire o_ctrl_utype,
   output wire o_rd_op,
   output wire o_alu_rd_sel2,
   output wire o_mem_word);

   (* ram_style = "block" *) reg [19:0] mem [0:511];
   reg [19:0] d;

   initial begin
      mem[0] = 20'h46b50;
      mem[1] = 20'h00000;
      mem[2] = 20'h00000;
      mem[3] = 20'h00000;
      mem[4] = 20'h44710;
      mem[5] = 20'h68380;
      mem[6] = 20'h00000;
      mem[7] = 20'h00000;
      mem[8] = 20'h0625c;
      mem[9] = 20'h00000;
      mem[10] = 20'h00000;
      mem[11] = 20'h00000;
      mem[12] = 20'h44404;
      mem[13] = 20'h60380;
      mem[14] = 20'h00000;
      mem[15] = 20'h00000;
      mem[16] = 20'h00000;
      mem[17] = 20'h00000;
      mem[18] = 20'h00000;
      mem[19] = 20'h00000;
      mem[20] = 20'h00000;
      mem[21] = 20'h00000;
      mem[22] = 20'h00000;
      mem[23] = 20'h00000;
      mem[24] = 20'h1c26f;
      mem[25] = 20'h44157;
      mem[26] = 20'h00000;
      mem[27] = 20'h4c3c7;
      mem[28] = 20'h00000;
      mem[29] = 20'h00000;
      mem[30] = 20'h00000;
      mem[31] = 20'h00000;
      mem[32] = 20'h56b50;
      mem[33] = 20'h00000;
      mem[34] = 20'h00000;
      mem[35] = 20'h00000;
      mem[36] = 20'h41750;
      mem[37] = 20'h68380;
      mem[38] = 20'h00000;
      mem[39] = 20'h00000;
      mem[40] = 20'h1625c;
      mem[41] = 20'h00000;
      mem[42] = 20'h00000;
      mem[43] = 20'h00000;
      mem[44] = 20'h41454;
      mem[45] = 20'h60380;
      mem[46] = 20'h00000;
      mem[47] = 20'h00000;
      mem[48] = 20'h00000;
      mem[49] = 20'h00000;
      mem[50] = 20'h00000;
      mem[51] = 20'h00000;
      mem[52] = 20'h00000;
      mem[53] = 20'h00000;
      mem[54] = 20'h00000;
      mem[55] = 20'h00000;
      mem[56] = 20'h1c66f;
      mem[57] = 20'h44157;
      mem[58] = 20'h00000;
      mem[59] = 20'h4c3c7;
      mem[60] = 20'h00000;
      mem[61] = 20'h00000;
      mem[62] = 20'h00000;
      mem[63] = 20'h00000;
      mem[64] = 20'hc6350;
      mem[65] = 20'h00000;
      mem[66] = 20'h00000;
      mem[67] = 20'h00000;
      mem[68] = 20'h48f52;
      mem[69] = 20'h68380;
      mem[70] = 20'h00000;
      mem[71] = 20'h00000;
      mem[72] = 20'h8625c;
      mem[73] = 20'h00000;
      mem[74] = 20'h00000;
      mem[75] = 20'h00000;
      mem[76] = 20'h48c46;
      mem[77] = 20'h60380;
      mem[78] = 20'h00000;
      mem[79] = 20'h00000;
      mem[80] = 20'h00000;
      mem[81] = 20'h00000;
      mem[82] = 20'h00000;
      mem[83] = 20'h00000;
      mem[84] = 20'h00000;
      mem[85] = 20'h00000;
      mem[86] = 20'h00000;
      mem[87] = 20'h00000;
      mem[88] = 20'h00000;
      mem[89] = 20'h44157;
      mem[90] = 20'h00000;
      mem[91] = 20'h4c3c7;
      mem[92] = 20'h00000;
      mem[93] = 20'h00000;
      mem[94] = 20'h00000;
      mem[95] = 20'h00000;
      mem[96] = 20'h00000;
      mem[97] = 20'h00000;
      mem[98] = 20'h00000;
      mem[99] = 20'h00000;
      mem[100] = 20'h48752;
      mem[101] = 20'h68380;
      mem[102] = 20'h00000;
      mem[103] = 20'h00000;
      mem[104] = 20'h00000;
      mem[105] = 20'h00000;
      mem[106] = 20'h00000;
      mem[107] = 20'h00000;
      mem[108] = 20'h48446;
      mem[109] = 20'h60380;
      mem[110] = 20'h00000;
      mem[111] = 20'h00000;
      mem[112] = 20'h00000;
      mem[113] = 20'h00000;
      mem[114] = 20'h00000;
      mem[115] = 20'h00000;
      mem[116] = 20'h00000;
      mem[117] = 20'h00000;
      mem[118] = 20'h00000;
      mem[119] = 20'h00000;
      mem[120] = 20'h00000;
      mem[121] = 20'h44157;
      mem[122] = 20'h00000;
      mem[123] = 20'h4c3c7;
      mem[124] = 20'h00000;
      mem[125] = 20'h00000;
      mem[126] = 20'h00000;
      mem[127] = 20'h00000;
      mem[128] = 20'h46350;
      mem[129] = 20'h00000;
      mem[130] = 20'h00000;
      mem[131] = 20'h00000;
      mem[132] = 20'hc0710;
      mem[133] = 20'h68380;
      mem[134] = 20'h00000;
      mem[135] = 20'h00000;
      mem[136] = 20'h00000;
      mem[137] = 20'h00000;
      mem[138] = 20'h00000;
      mem[139] = 20'h00000;
      mem[140] = 20'hc0404;
      mem[141] = 20'h60380;
      mem[142] = 20'h00000;
      mem[143] = 20'h00000;
      mem[144] = 20'h00000;
      mem[145] = 20'h00000;
      mem[146] = 20'h00000;
      mem[147] = 20'h00000;
      mem[148] = 20'h00000;
      mem[149] = 20'h00000;
      mem[150] = 20'h00000;
      mem[151] = 20'h00000;
      mem[152] = 20'h0ca6f;
      mem[153] = 20'h44157;
      mem[154] = 20'h00000;
      mem[155] = 20'h4c3c7;
      mem[156] = 20'h00000;
      mem[157] = 20'h00000;
      mem[158] = 20'h00000;
      mem[159] = 20'h00000;
      mem[160] = 20'h56350;
      mem[161] = 20'h00000;
      mem[162] = 20'h00000;
      mem[163] = 20'h00000;
      mem[164] = 20'h41f50;
      mem[165] = 20'h68380;
      mem[166] = 20'h00000;
      mem[167] = 20'h00000;
      mem[168] = 20'h00000;
      mem[169] = 20'h00000;
      mem[170] = 20'h00000;
      mem[171] = 20'h00000;
      mem[172] = 20'h41c54;
      mem[173] = 20'h60380;
      mem[174] = 20'h00000;
      mem[175] = 20'h00000;
      mem[176] = 20'h00000;
      mem[177] = 20'h00000;
      mem[178] = 20'h00000;
      mem[179] = 20'h00000;
      mem[180] = 20'h00000;
      mem[181] = 20'h00000;
      mem[182] = 20'h00000;
      mem[183] = 20'h00000;
      mem[184] = 20'h0ce6f;
      mem[185] = 20'h44157;
      mem[186] = 20'h00000;
      mem[187] = 20'h4c3c7;
      mem[188] = 20'h00000;
      mem[189] = 20'h00000;
      mem[190] = 20'h00000;
      mem[191] = 20'h00000;
      mem[192] = 20'h00000;
      mem[193] = 20'h00000;
      mem[194] = 20'h00000;
      mem[195] = 20'h00000;
      mem[196] = 20'hc0712;
      mem[197] = 20'h68380;
      mem[198] = 20'h00000;
      mem[199] = 20'h00000;
      mem[200] = 20'h00000;
      mem[201] = 20'h00000;
      mem[202] = 20'h00000;
      mem[203] = 20'h00000;
      mem[204] = 20'hc0406;
      mem[205] = 20'h60380;
      mem[206] = 20'h00000;
      mem[207] = 20'h00000;
      mem[208] = 20'h00000;
      mem[209] = 20'h00000;
      mem[210] = 20'h00000;
      mem[211] = 20'h00000;
      mem[212] = 20'h00000;
      mem[213] = 20'h00000;
      mem[214] = 20'h00000;
      mem[215] = 20'h00000;
      mem[216] = 20'h0c26f;
      mem[217] = 20'h44157;
      mem[218] = 20'h00000;
      mem[219] = 20'h4c3c7;
      mem[220] = 20'h00000;
      mem[221] = 20'h00000;
      mem[222] = 20'h00000;
      mem[223] = 20'h00000;
      mem[224] = 20'h00000;
      mem[225] = 20'h00000;
      mem[226] = 20'h00000;
      mem[227] = 20'h00000;
      mem[228] = 20'hc1712;
      mem[229] = 20'h68380;
      mem[230] = 20'h00000;
      mem[231] = 20'h00000;
      mem[232] = 20'h00000;
      mem[233] = 20'h00000;
      mem[234] = 20'h00000;
      mem[235] = 20'h00000;
      mem[236] = 20'hc1406;
      mem[237] = 20'h60380;
      mem[238] = 20'h00000;
      mem[239] = 20'h00000;
      mem[240] = 20'h00000;
      mem[241] = 20'h00000;
      mem[242] = 20'h00000;
      mem[243] = 20'h00000;
      mem[244] = 20'h00000;
      mem[245] = 20'h00000;
      mem[246] = 20'h00000;
      mem[247] = 20'h00000;
      mem[248] = 20'h0c66f;
      mem[249] = 20'h44157;
      mem[250] = 20'h00000;
      mem[251] = 20'h4c3c7;
      mem[252] = 20'h00000;
      mem[253] = 20'h00000;
      mem[254] = 20'h00000;
      mem[255] = 20'h00000;
      mem[256] = 20'h46b50;
      mem[257] = 20'h00000;
      mem[258] = 20'h00000;
      mem[259] = 20'h00000;
      mem[260] = 20'h44710;
      mem[261] = 20'h68380;
      mem[262] = 20'h00000;
      mem[263] = 20'h00000;
      mem[264] = 20'h0625c;
      mem[265] = 20'h00000;
      mem[266] = 20'h00000;
      mem[267] = 20'h00000;
      mem[268] = 20'h44406;
      mem[269] = 20'h60380;
      mem[270] = 20'h00000;
      mem[271] = 20'h00000;
      mem[272] = 20'h00000;
      mem[273] = 20'h00000;
      mem[274] = 20'h00000;
      mem[275] = 20'h00000;
      mem[276] = 20'h00000;
      mem[277] = 20'h00000;
      mem[278] = 20'h00000;
      mem[279] = 20'h00000;
      mem[280] = 20'h1c26f;
      mem[281] = 20'h44157;
      mem[282] = 20'h00000;
      mem[283] = 20'h4c3c7;
      mem[284] = 20'h00000;
      mem[285] = 20'h00000;
      mem[286] = 20'h00000;
      mem[287] = 20'h00000;
      mem[288] = 20'h56b50;
      mem[289] = 20'h00000;
      mem[290] = 20'h00000;
      mem[291] = 20'h00000;
      mem[292] = 20'h00000;
      mem[293] = 20'h68380;
      mem[294] = 20'h00000;
      mem[295] = 20'h00000;
      mem[296] = 20'h1625c;
      mem[297] = 20'h00000;
      mem[298] = 20'h00000;
      mem[299] = 20'h00000;
      mem[300] = 20'h00000;
      mem[301] = 20'h60380;
      mem[302] = 20'h00000;
      mem[303] = 20'h00000;
      mem[304] = 20'h00000;
      mem[305] = 20'h00000;
      mem[306] = 20'h00000;
      mem[307] = 20'h00000;
      mem[308] = 20'h00000;
      mem[309] = 20'h00000;
      mem[310] = 20'h00000;
      mem[311] = 20'h00000;
      mem[312] = 20'h1c66f;
      mem[313] = 20'h44157;
      mem[314] = 20'h00000;
      mem[315] = 20'h4c3c7;
      mem[316] = 20'h00000;
      mem[317] = 20'h00000;
      mem[318] = 20'h00000;
      mem[319] = 20'h00000;
      mem[320] = 20'hc6350;
      mem[321] = 20'h00000;
      mem[322] = 20'h00000;
      mem[323] = 20'h00000;
      mem[324] = 20'h48f52;
      mem[325] = 20'h68380;
      mem[326] = 20'h00000;
      mem[327] = 20'h00000;
      mem[328] = 20'h8625c;
      mem[329] = 20'h00000;
      mem[330] = 20'h00000;
      mem[331] = 20'h00000;
      mem[332] = 20'h00000;
      mem[333] = 20'h60380;
      mem[334] = 20'h00000;
      mem[335] = 20'h00000;
      mem[336] = 20'h00000;
      mem[337] = 20'h00000;
      mem[338] = 20'h00000;
      mem[339] = 20'h00000;
      mem[340] = 20'h00000;
      mem[341] = 20'h00000;
      mem[342] = 20'h00000;
      mem[343] = 20'h00000;
      mem[344] = 20'h00000;
      mem[345] = 20'h44157;
      mem[346] = 20'h00000;
      mem[347] = 20'h4c3c7;
      mem[348] = 20'h00000;
      mem[349] = 20'h00000;
      mem[350] = 20'h00000;
      mem[351] = 20'h00000;
      mem[352] = 20'h00000;
      mem[353] = 20'h00000;
      mem[354] = 20'h00000;
      mem[355] = 20'h00000;
      mem[356] = 20'h48752;
      mem[357] = 20'h68380;
      mem[358] = 20'h00000;
      mem[359] = 20'h00000;
      mem[360] = 20'h00000;
      mem[361] = 20'h00000;
      mem[362] = 20'h00000;
      mem[363] = 20'h00000;
      mem[364] = 20'h00000;
      mem[365] = 20'h60380;
      mem[366] = 20'h00000;
      mem[367] = 20'h00000;
      mem[368] = 20'h00000;
      mem[369] = 20'h00000;
      mem[370] = 20'h00000;
      mem[371] = 20'h00000;
      mem[372] = 20'h00000;
      mem[373] = 20'h00000;
      mem[374] = 20'h00000;
      mem[375] = 20'h00000;
      mem[376] = 20'h00000;
      mem[377] = 20'h44157;
      mem[378] = 20'h00000;
      mem[379] = 20'h4c3c7;
      mem[380] = 20'h00000;
      mem[381] = 20'h00000;
      mem[382] = 20'h00000;
      mem[383] = 20'h00000;
      mem[384] = 20'h46350;
      mem[385] = 20'h00000;
      mem[386] = 20'h00000;
      mem[387] = 20'h00000;
      mem[388] = 20'hc0710;
      mem[389] = 20'h68380;
      mem[390] = 20'h00000;
      mem[391] = 20'h00000;
      mem[392] = 20'h00000;
      mem[393] = 20'h00000;
      mem[394] = 20'h00000;
      mem[395] = 20'h00000;
      mem[396] = 20'h00000;
      mem[397] = 20'h60380;
      mem[398] = 20'h00000;
      mem[399] = 20'h00000;
      mem[400] = 20'h00000;
      mem[401] = 20'h00000;
      mem[402] = 20'h00000;
      mem[403] = 20'h00000;
      mem[404] = 20'h00000;
      mem[405] = 20'h00000;
      mem[406] = 20'h00000;
      mem[407] = 20'h00000;
      mem[408] = 20'h0ca6f;
      mem[409] = 20'h44157;
      mem[410] = 20'h00000;
      mem[411] = 20'h4c3c7;
      mem[412] = 20'h00000;
      mem[413] = 20'h00000;
      mem[414] = 20'h00000;
      mem[415] = 20'h00000;
      mem[416] = 20'h56350;
      mem[417] = 20'h00000;
      mem[418] = 20'h00000;
      mem[419] = 20'h00000;
      mem[420] = 20'h51f50;
      mem[421] = 20'h68380;
      mem[422] = 20'h00000;
      mem[423] = 20'h00000;
      mem[424] = 20'h00000;
      mem[425] = 20'h00000;
      mem[426] = 20'h00000;
      mem[427] = 20'h00000;
      mem[428] = 20'h51c54;
      mem[429] = 20'h60380;
      mem[430] = 20'h00000;
      mem[431] = 20'h00000;
      mem[432] = 20'h00000;
      mem[433] = 20'h00000;
      mem[434] = 20'h00000;
      mem[435] = 20'h00000;
      mem[436] = 20'h00000;
      mem[437] = 20'h00000;
      mem[438] = 20'h00000;
      mem[439] = 20'h00000;
      mem[440] = 20'h0ce6f;
      mem[441] = 20'h44157;
      mem[442] = 20'h00000;
      mem[443] = 20'h4c3c7;
      mem[444] = 20'h00000;
      mem[445] = 20'h00000;
      mem[446] = 20'h00000;
      mem[447] = 20'h00000;
      mem[448] = 20'h00000;
      mem[449] = 20'h00000;
      mem[450] = 20'h00000;
      mem[451] = 20'h00000;
      mem[452] = 20'hc0712;
      mem[453] = 20'h68380;
      mem[454] = 20'h00000;
      mem[455] = 20'h00000;
      mem[456] = 20'h00000;
      mem[457] = 20'h00000;
      mem[458] = 20'h00000;
      mem[459] = 20'h00000;
      mem[460] = 20'h00000;
      mem[461] = 20'h60380;
      mem[462] = 20'h00000;
      mem[463] = 20'h00000;
      mem[464] = 20'h00000;
      mem[465] = 20'h00000;
      mem[466] = 20'h00000;
      mem[467] = 20'h00000;
      mem[468] = 20'h00000;
      mem[469] = 20'h00000;
      mem[470] = 20'h00000;
      mem[471] = 20'h00000;
      mem[472] = 20'h0c26f;
      mem[473] = 20'h44157;
      mem[474] = 20'h00000;
      mem[475] = 20'h4c3c7;
      mem[476] = 20'h00000;
      mem[477] = 20'h00000;
      mem[478] = 20'h00000;
      mem[479] = 20'h00000;
      mem[480] = 20'h00000;
      mem[481] = 20'h00000;
      mem[482] = 20'h00000;
      mem[483] = 20'h00000;
      mem[484] = 20'hc1712;
      mem[485] = 20'h68380;
      mem[486] = 20'h00000;
      mem[487] = 20'h00000;
      mem[488] = 20'h00000;
      mem[489] = 20'h00000;
      mem[490] = 20'h00000;
      mem[491] = 20'h00000;
      mem[492] = 20'h00000;
      mem[493] = 20'h60380;
      mem[494] = 20'h00000;
      mem[495] = 20'h00000;
      mem[496] = 20'h00000;
      mem[497] = 20'h00000;
      mem[498] = 20'h00000;
      mem[499] = 20'h00000;
      mem[500] = 20'h00000;
      mem[501] = 20'h00000;
      mem[502] = 20'h00000;
      mem[503] = 20'h00000;
      mem[504] = 20'h0c66f;
      mem[505] = 20'h44157;
      mem[506] = 20'h00000;
      mem[507] = 20'h4c3c7;
      mem[508] = 20'h00000;
      mem[509] = 20'h00000;
      mem[510] = 20'h00000;
      mem[511] = 20'h00000;
   end

always @(posedge i_clk)
   if (i_en)
      d <= mem[{i_imm30,i_funct3,i_opcode}];

   assign o_branch_op = d[0];
   assign o_ctrl_jal_or_jalr = o_branch_op;
   assign o_slt_or_branch = d[1];
   assign o_alu_sub = o_slt_or_branch;
   assign o_alu_bool_op1 = o_slt_or_branch;
   assign o_op_b_source = d[2];
   assign o_mem_cmd = o_op_b_source;
   assign o_immdec_ctrl0 = d[3];
   assign o_immdec_en0 = o_immdec_ctrl0;
   assign o_immdec_ctrl1 = d[4];
   assign o_bufreg_rs1_en = o_immdec_ctrl1;
   assign o_immdec_ctrl2 = d[5];
   assign o_cond_branch = o_immdec_ctrl2;
   assign o_immdec_ctrl3 = d[6];
   assign o_two_stage_op = o_immdec_ctrl3;
   assign o_immdec_en1 = d[7];
   assign o_immdec_en2 = d[8];
   assign o_immdec_en3 = d[9];
   assign o_bne_or_bge = d[10];
   assign o_rd_alu_en = o_bne_or_bge;
   assign o_sh_right = d[11];
   assign o_alu_cmp_sig = o_sh_right;
   assign o_mem_signed = o_sh_right;
   assign o_shift_op = d[12];
   assign o_alu_bool_op0 = o_shift_op;
   assign o_rd_mem_en = d[13];
   assign o_dbus_en = o_rd_mem_en;
   assign o_bufreg_imm_en = d[14];
   assign o_alu_rd_sel0 = o_bufreg_imm_en;
   assign o_bufreg_clr_lsb = d[15];
   assign o_ctrl_pc_rel = o_bufreg_clr_lsb;
   assign o_alu_rd_sel1 = o_bufreg_clr_lsb;
   assign o_bufreg_sh_signed = d[16];
   assign o_alu_cmp_eq = o_bufreg_sh_signed;
   assign o_mem_half = o_bufreg_sh_signed;
   assign o_ctrl_utype = d[17];
   assign o_rd_op = d[18];
   assign o_alu_rd_sel2 = d[19];
   assign o_mem_word = o_alu_rd_sel2;

always @(posedge i_clk) begin
if (i_en) begin
   //MDU/CSR/Ext
   o_mdu_op     <= MDU & (i_opcode == 5'b01100) & i_imm25;
   o_ext_funct3 <=  MDU ? i_funct3 : 3'b000;
   o_ebreak         <= CSR & (i_op20);
   o_rd_csr_en      <= CSR & (i_opcode[4] & i_opcode[2] &  (|i_funct3));
   o_ctrl_mret      <= CSR & (i_opcode[4] & i_opcode[2] & !(|i_funct3) &  i_op21);
   o_e_op           <= CSR & (i_opcode[4] & i_opcode[2] & !(|i_funct3) & !i_op21);
   o_csr_en         <= CSR & (i_op20 | (i_op26 & !i_op21));
   o_csr_mstatus_en <= CSR & (!i_op26 & !i_op22);
   o_csr_mie_en     <= CSR & (!i_op26 &  i_op22 & !i_op20);
   o_csr_mcause_en  <= CSR & (         i_op21 & !i_op20);
   o_csr_source1    <= CSR & (i_funct3[1]);
   o_csr_source0    <= CSR & (i_funct3[0]);
   o_csr_d_sel      <= CSR & (i_funct3[2]);
   o_csr_imm_en     <= CSR & (i_opcode[4] & i_opcode[2] & i_funct3[2]);
   o_csr_addr1      <= CSR & (i_op26 & i_op20);
   o_csr_addr0      <= CSR & (!i_op26 | i_op21);
end
end

endmodule
