// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vservant_sim__Syms.h"


void Vservant_sim___024root__trace_chg_0_sub_0(Vservant_sim___024root* vlSelf, VerilatedVcd::Buffer* bufp);

void Vservant_sim___024root__trace_chg_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vservant_sim___024root__trace_chg_0\n"); );
    // Body
    Vservant_sim___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vservant_sim___024root*>(voidSelf);
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (VL_UNLIKELY(!vlSymsp->__Vm_activity)) return;
    Vservant_sim___024root__trace_chg_0_sub_0((&vlSymsp->TOP), bufp);
}

void Vservant_sim___024root__trace_chg_0_sub_0(Vservant_sim___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vservant_sim___024root__trace_chg_0_sub_0\n"); );
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode + 1);
    if (VL_UNLIKELY((vlSelfRef.__Vm_traceActivity[0U]))) {
        bufp->chgWData(oldp+0,(vlSymsp->TOP__servant_sim.__PVT__firmware_file),1024);
        bufp->chgIData(oldp+32,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__mux__DOT__genblk1__DOT__f),32);
        bufp->chgWData(oldp+33,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__mux__DOT__genblk1__DOT__signature_file),1024);
    }
    if (VL_UNLIKELY(((vlSelfRef.__Vm_traceActivity[1U] 
                      | vlSelfRef.__Vm_traceActivity
                      [2U])))) {
        bufp->chgBit(oldp+65,((1U & ((~ (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_ibus_cyc)) 
                                     & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode) 
                                        >> 3U)))));
        bufp->chgBit(oldp+66,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__arbiter__DOT__o_wb_mem_stb));
        bufp->chgBit(oldp+67,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_ibus_cyc));
        bufp->chgBit(oldp+68,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trig_irq));
        bufp->chgBit(oldp+69,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__i_load));
        bufp->chgBit(oldp+70,(((~ (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_ibus_cyc)) 
                               & (IData)(vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_ack))));
        bufp->chgBit(oldp+71,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__i_wreq));
        bufp->chgBit(oldp+72,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__i_rreq));
        bufp->chgBit(oldp+73,(((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__i_wreq) 
                               | (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rgnt))));
        bufp->chgCData(oldp+74,(vlSymsp->TOP__servant_sim__dut__ram.__PVT__we),4);
    }
    if (VL_UNLIKELY((vlSelfRef.__Vm_traceActivity[2U]))) {
        bufp->chgBit(oldp+75,(vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_ack));
        bufp->chgBit(oldp+76,(vlSymsp->TOP__servant_sim__dut.__PVT__q));
        bufp->chgBit(oldp+77,(vlSymsp->TOP__servant_sim__dut.__PVT__timer_irq));
        bufp->chgIData(oldp+78,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_dat),32);
        bufp->chgCData(oldp+79,(((((2U & (((3U == (3U 
                                                   & vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1)) 
                                           | (((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                                               >> 1U) 
                                              | ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                                                 & (vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                                    >> 1U)))) 
                                          << 1U)) | 
                                   (1U & ((2U == (3U 
                                                  & vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1)) 
                                          | ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                                             >> 1U)))) 
                                  << 2U) | ((2U & (
                                                   ((1U 
                                                     == 
                                                     (3U 
                                                      & vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1)) 
                                                    | (((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                                                        >> 1U) 
                                                       | ((~ 
                                                           (vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                                            >> 1U)) 
                                                          & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3)))) 
                                                   << 1U)) 
                                            | (0U == 
                                               (3U 
                                                & vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1))))),4);
        bufp->chgIData(oldp+80,(vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt),32);
        bufp->chgBit(oldp+81,((1U & vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dlo)));
        bufp->chgBit(oldp+82,((1U & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode) 
                                     >> 3U))));
        bufp->chgBit(oldp+83,(((~ (vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                   >> 0x0000001fU)) 
                               & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__mux__DOT__o_wb_ext_stb))));
        bufp->chgBit(oldp+84,(vlSymsp->TOP__servant_sim__dut.__PVT__wb_gpio_rdt));
        bufp->chgBit(oldp+85,(((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__mux__DOT__o_wb_ext_stb) 
                               & (vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                  >> 0x0000001fU))));
        bufp->chgIData(oldp+86,(vlSymsp->TOP__servant_sim__dut.__PVT__timer__DOT__mtime),32);
        bufp->chgIData(oldp+87,((0xfffffffcU & vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1)),32);
        bufp->chgBit(oldp+88,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__mux__DOT__o_wb_ext_stb));
        bufp->chgIData(oldp+89,(((vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                  >> 0x0000001fU) ? vlSymsp->TOP__servant_sim__dut.__PVT__timer__DOT__mtime
                                  : (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__wb_gpio_rdt))),32);
        bufp->chgBit(oldp+90,(vlSymsp->TOP__servant_sim__dut.__PVT__wb_ext_ack));
        bufp->chgSData(oldp+91,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__o_waddr),10);
        bufp->chgCData(oldp+92,((3U & ((1U & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rcnt))
                                        ? (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__wdata1_r)
                                        : (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__wdata0_r)))),2);
        bufp->chgBit(oldp+93,((((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rtrig1) 
                                & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__wen0_r)) 
                               | ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rcnt) 
                                  & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__wen1_r)))));
        bufp->chgSData(oldp+94,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__o_raddr),10);
        bufp->chgBit(oldp+95,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rgate));
        bufp->chgCData(oldp+96,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__i_rdata),2);
        bufp->chgIData(oldp+97,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__wb_ibus_adr),32);
        bufp->chgBit(oldp+98,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_dbus_cyc));
        bufp->chgIData(oldp+99,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__i_dat),32);
        bufp->chgBit(oldp+100,(((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_dbus_cyc) 
                                & ((0U == (vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                           >> 0x0000001eU)) 
                                   & (IData)(vlSymsp->TOP__servant_sim__dut.cpu__DOT__mux__DOT____VdfgRegularize_h2b1522d7_0_0)))));
        bufp->chgCData(oldp+101,(((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trap)
                                   ? 0x23U : (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7))),6);
        bufp->chgCData(oldp+102,(((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trap)
                                   ? 0x22U : (0x00000020U 
                                              | (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_csr_addr)))),6);
        bufp->chgBit(oldp+103,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__rf_if__DOT__o_wen0));
        bufp->chgBit(oldp+104,(((0U != (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb)) 
                                & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_csr_en) 
                                   | (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trap)))));
        bufp->chgBit(oldp+105,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__rf_if__DOT__o_wdata0));
        bufp->chgBit(oldp+106,((1U & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trap)
                                       ? vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__wb_ibus_adr
                                       : (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__o_csr_in)))));
        bufp->chgCData(oldp+107,((0x0000001fU & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm19_12_20) 
                                                 >> 4U))),6);
        bufp->chgCData(oldp+108,((((IData)(vlSymsp->TOP__servant_sim__dut.cpu__DOT__cpu__DOT__rf_if__DOT____VdfgRegularize_h1739b917_0_0) 
                                   << 5U) | ((0x0000001cU 
                                              & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm24_20) 
                                                 & ((- (IData)(
                                                               (1U 
                                                                & (~ (IData)(vlSymsp->TOP__servant_sim__dut.cpu__DOT__cpu__DOT__rf_if__DOT____VdfgRegularize_h1739b917_0_0))))) 
                                                    << 2U))) 
                                             | (3U 
                                                & ((((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_mret) 
                                                     << 1U) 
                                                    | (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trap)) 
                                                   | (((- (IData)((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_csr_en))) 
                                                       & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_csr_addr)) 
                                                      | ((- (IData)(
                                                                    (1U 
                                                                     & (~ (IData)(vlSymsp->TOP__servant_sim__dut.cpu__DOT__cpu__DOT__rf_if__DOT____VdfgRegularize_h1739b917_0_0))))) 
                                                         & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm24_20)))))))),6);
        bufp->chgBit(oldp+109,((1U & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rdata0))));
        bufp->chgBit(oldp+110,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__i_rs2));
        bufp->chgIData(oldp+111,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1),32);
        bufp->chgCData(oldp+112,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3),3);
        bufp->chgCData(oldp+113,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7),5);
        bufp->chgCData(oldp+114,((0x0000001fU & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm19_12_20) 
                                                 >> 4U))),5);
        bufp->chgCData(oldp+115,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm24_20),5);
        bufp->chgCData(oldp+116,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_immdec_ctrl),4);
        bufp->chgCData(oldp+117,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_immdec_en),4);
        bufp->chgBit(oldp+118,((1U & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                                      >> 2U))));
        bufp->chgBit(oldp+119,((1U & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3))));
        bufp->chgBit(oldp+120,((1U & (~ (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode)))));
        bufp->chgBit(oldp+121,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_two_stage_op));
        bufp->chgBit(oldp+122,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_e_op));
        bufp->chgBit(oldp+123,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__op20));
        bufp->chgBit(oldp+124,((1U & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode) 
                                      >> 4U))));
        bufp->chgBit(oldp+125,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_shift_op));
        bufp->chgBit(oldp+126,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_rd_op));
        bufp->chgBit(oldp+127,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_rd_alu_en));
        bufp->chgBit(oldp+128,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_rd_csr_en));
        bufp->chgBit(oldp+129,((IData)((0U == (5U & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode))))));
        bufp->chgBit(oldp+130,((((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__i_utype) 
                                 & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__o_bad_pc)) 
                                | ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__pc_plus_4) 
                                   & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__i_jal_or_jalr)))));
        bufp->chgBit(oldp+131,((1U & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__o_q) 
                                      | (((0U == (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3)) 
                                          & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__alu__DOT__result_add)) 
                                         | ((IData)(
                                                    (((2U 
                                                       == 
                                                       (6U 
                                                        & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3))) 
                                                      & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__alu__DOT__cmp_r)) 
                                                     & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt0))) 
                                            | (((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                                                >> 2U) 
                                               & (((~ (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3)) 
                                                   & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_op_b) 
                                                      ^ (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rdata0))) 
                                                  | (((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                                                      >> 1U) 
                                                     & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_op_b) 
                                                        & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rdata0)))))))))));
        bufp->chgBit(oldp+132,(((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__mem_if__DOT__dat_valid)
                                 ? (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_q)
                                 : ((~ ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                                        >> 2U)) & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__mem_if__DOT__signbit)))));
        bufp->chgBit(oldp+133,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__o_q));
        bufp->chgBit(oldp+134,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__i_pc_en));
        bufp->chgBit(oldp+135,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__jump));
        bufp->chgBit(oldp+136,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__i_jal_or_jalr));
        bufp->chgBit(oldp+137,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__i_utype));
        bufp->chgBit(oldp+138,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_mret));
        bufp->chgBit(oldp+139,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_imm));
        bufp->chgBit(oldp+140,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trap));
        bufp->chgBit(oldp+141,(((0U == (7U & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode))) 
                                | ((3U == (3U & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode))) 
                                   | (((IData)(vlSymsp->TOP__servant_sim__dut.cpu__DOT__cpu__DOT__decode__DOT____VdfgRegularize_h6d71b89f_0_4) 
                                       & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__op20)) 
                                      | (0U == (3U 
                                                & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode) 
                                                   >> 3U))))))));
        bufp->chgBit(oldp+142,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_init));
        bufp->chgBit(oldp+143,((0U != (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb))));
        bufp->chgBit(oldp+144,((0U == (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt))));
        bufp->chgBit(oldp+145,((IData)((((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt) 
                                         >> 2U) | (3U 
                                                   == 
                                                   (3U 
                                                    & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt)))))));
        bufp->chgBit(oldp+146,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt0));
        bufp->chgBit(oldp+147,(((0U == (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt)) 
                                & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb) 
                                   >> 1U))));
        bufp->chgBit(oldp+148,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__i_cnt2));
        bufp->chgBit(oldp+149,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_cnt3));
        bufp->chgBit(oldp+150,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__i_cnt7));
        bufp->chgBit(oldp+151,(((2U == (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt)) 
                                & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb) 
                                   >> 3U))));
        bufp->chgBit(oldp+152,(((3U == (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt)) 
                                & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb))));
        bufp->chgBit(oldp+153,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt_done));
        bufp->chgBit(oldp+154,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_en));
        bufp->chgBit(oldp+155,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__imm30));
        bufp->chgBit(oldp+156,((1U & ((~ ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode) 
                                          >> 4U)) | (IData)(
                                                            (1U 
                                                             == 
                                                             (3U 
                                                              & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode))))))));
        bufp->chgBit(oldp+157,((1U & (~ ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode) 
                                         >> 2U)))));
        bufp->chgBit(oldp+158,((((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode) 
                                 >> 4U) & ((0U == (3U 
                                                   & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode))) 
                                           | (3U == 
                                              (3U & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode)))))));
        bufp->chgBit(oldp+159,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__o_q));
        bufp->chgBit(oldp+160,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_q));
        bufp->chgBit(oldp+161,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__alu__DOT__i_sub));
        bufp->chgCData(oldp+162,((3U & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3))),2);
        bufp->chgBit(oldp+163,((0U == (3U & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                                             >> 1U)))));
        bufp->chgBit(oldp+164,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__alu__DOT__i_cmp_sig));
        bufp->chgBit(oldp+165,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__alu__DOT__o_cmp));
        bufp->chgCData(oldp+166,(((4U & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3)) 
                                  | (((1U == (3U & 
                                              ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                                               >> 1U))) 
                                      << 1U) | (0U 
                                                == (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3))))),3);
        bufp->chgBit(oldp+167,(((~ (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_init)) 
                                & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_rd_op))));
        bufp->chgBit(oldp+168,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_op_b));
        bufp->chgBit(oldp+169,((1U & (~ ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                                         >> 2U)))));
        bufp->chgBit(oldp+170,((1U & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                                      >> 1U))));
        bufp->chgCData(oldp+171,((3U & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt) 
                                        >> 1U))),2);
        bufp->chgBit(oldp+172,((1U & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dat_shamt) 
                                      >> 5U))));
        bufp->chgBit(oldp+173,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__mem_if__DOT__o_misalign));
        bufp->chgBit(oldp+174,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__o_bad_pc));
        bufp->chgBit(oldp+175,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_mstatus_en));
        bufp->chgBit(oldp+176,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_mie_en));
        bufp->chgBit(oldp+177,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_mcause_en));
        bufp->chgBit(oldp+178,((1U & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm19_12_20) 
                                      >> 4U))));
        bufp->chgBit(oldp+179,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_csr_en));
        bufp->chgCData(oldp+180,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_csr_addr),2);
        bufp->chgBit(oldp+181,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_csr_imm_en));
        bufp->chgBit(oldp+182,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__o_csr_in));
        bufp->chgBit(oldp+183,(((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_csr_en) 
                                & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__i_rs2))));
        bufp->chgBit(oldp+184,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_dbus_en));
        bufp->chgBit(oldp+185,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__new_irq));
        bufp->chgCData(oldp+186,((3U & vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1)),2);
        bufp->chgBit(oldp+187,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__alu__DOT__result_add));
        bufp->chgBit(oldp+188,(((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__alu__DOT__cmp_r) 
                                & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt0))));
        bufp->chgBit(oldp+189,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__alu__DOT__cmp_r));
        bufp->chgBit(oldp+190,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__alu__DOT__add_cy));
        bufp->chgBit(oldp+191,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__alu__DOT__add_cy_r));
        bufp->chgBit(oldp+192,(((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__alu__DOT__i_cmp_sig) 
                                & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rdata0))));
        bufp->chgBit(oldp+193,(((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__alu__DOT__i_cmp_sig) 
                                & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_op_b))));
        bufp->chgBit(oldp+194,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__alu__DOT__add_b));
        bufp->chgBit(oldp+195,((1U & (((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__alu__DOT__i_cmp_sig) 
                                       & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rdata0)) 
                                      + ((~ ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__alu__DOT__i_cmp_sig) 
                                             & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_op_b))) 
                                         + (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__alu__DOT__add_cy))))));
        bufp->chgBit(oldp+196,(((~ (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__alu__DOT__result_add)) 
                                & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__alu__DOT__cmp_r) 
                                   | (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt0)))));
        bufp->chgBit(oldp+197,((1U & (((~ (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3)) 
                                       & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_op_b) 
                                          ^ (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rdata0))) 
                                      | (((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                                          >> 1U) & 
                                         ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_op_b) 
                                          & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rdata0)))))));
        bufp->chgCData(oldp+198,((7U & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dhi))),3);
        bufp->chgBit(oldp+199,((1U & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_carry_and_sum_a0) 
                                      >> 1U))));
        bufp->chgBit(oldp+200,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_cr_in_a1));
        bufp->chgCData(oldp+201,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_carry_and_sum_a0),2);
        bufp->chgBit(oldp+202,(((((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode) 
                                  >> 4U) & ((0U == 
                                             (3U & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode))) 
                                            | (3U == 
                                               (3U 
                                                & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode))))) 
                                & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt0))));
        bufp->chgBit(oldp+203,((((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_carry_and_sum_a0) 
                                 >> 1U) & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_en))));
        bufp->chgIData(oldp+204,(((((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_en)
                                     ? ((0x20000000U 
                                         & (((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_init)
                                              ? (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_carry_and_sum_a0)
                                              : ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__imm30) 
                                                 & (vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                                    >> 0x0000001fU))) 
                                            << 0x0000001dU)) 
                                        | (vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                           >> 3U)) : 
                                    (vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                     >> 2U)) << 2U) 
                                  | (3U & (((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_init)
                                             ? (IData)(vlSymsp->TOP__servant_sim__dut.__VdfgRegularize_hd8275ffe_1_0)
                                             : (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_en))
                                            ? ((2U 
                                                & (((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_init)
                                                     ? (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_carry_and_sum_a0)
                                                     : 
                                                    (vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                                     >> 2U)) 
                                                   << 1U)) 
                                               | (1U 
                                                  & (vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                                     >> 1U)))
                                            : vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1)))),32);
        bufp->chgCData(oldp+205,((7U & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_en)
                                         ? ((vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                             >> 1U) 
                                            & (- (IData)(
                                                         (1U 
                                                          & (~ (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt_done))))))
                                         : (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_tail_a1)))),3);
        bufp->chgCData(oldp+206,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_tail_a1),3);
        bufp->chgIData(oldp+207,(((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_en)
                                   ? ((((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_init)
                                         ? (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_carry_and_sum_a0)
                                         : ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__imm30) 
                                            & (vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                               >> 0x0000001fU))) 
                                       << 0x0000001fU) 
                                      | (vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                         >> 1U)) : vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1)),32);
        bufp->chgCData(oldp+208,((((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt0) 
                                   & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_en))
                                   ? (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_carry_and_sum_a0)
                                   : (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_lsb_a1))),2);
        bufp->chgCData(oldp+209,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_lsb_a1),2);
        bufp->chgSData(oldp+210,(((0x000003f8U & (vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                                  << 3U)) 
                                  | (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_tail_a1))),10);
        bufp->chgBit(oldp+211,((1U & (((0x000003f8U 
                                        & (vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                           << 3U)) 
                                       | (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_tail_a1)) 
                                      >> ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_shift_op)
                                           ? (7U & 
                                              ((4U 
                                                & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3))
                                                ? ((IData)(3U) 
                                                   + 
                                                   (3U 
                                                    & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dhi)))
                                                : (3U 
                                                   & (~ (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dhi)))))
                                           : 3U)))));
        bufp->chgBit(oldp+212,((1U & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_carry_and_sum_a0))));
        bufp->chgBit(oldp+213,((0x000003ffU & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_en) 
                                               & (((0x000003f8U 
                                                    & (vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                                       << 3U)) 
                                                   | (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_tail_a1)) 
                                                  >> 
                                                  ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_shift_op)
                                                    ? 
                                                   (7U 
                                                    & ((4U 
                                                        & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3))
                                                        ? 
                                                       ((IData)(3U) 
                                                        + 
                                                        (3U 
                                                         & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dhi)))
                                                        : 
                                                       (3U 
                                                        & (~ (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dhi)))))
                                                    : 3U))))));
        bufp->chgCData(oldp+214,(((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_shift_op)
                                   ? (7U & ((4U & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3))
                                             ? ((IData)(3U) 
                                                + (3U 
                                                   & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dhi)))
                                             : (3U 
                                                & (~ (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dhi)))))
                                   : 3U)),3);
        bufp->chgCData(oldp+215,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dhi),8);
        bufp->chgIData(oldp+216,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dlo),24);
        bufp->chgBit(oldp+217,((1U & ((IData)((0U == 
                                               (3U 
                                                & vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1))) 
                                      | ((IData)((0U 
                                                  == 
                                                  (6U 
                                                   & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt)))) 
                                         | (((~ ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt) 
                                                 >> 2U)) 
                                             & (~ (vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                                   >> 1U))) 
                                            | (((~ 
                                                 ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt) 
                                                  >> 2U)) 
                                                & (~ vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1)) 
                                               | ((~ 
                                                   ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt) 
                                                    >> 1U)) 
                                                  & (~ 
                                                     (vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                                      >> 1U))))))))));
        bufp->chgBit(oldp+218,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__shift_en));
        bufp->chgBit(oldp+219,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__cnt_en));
        bufp->chgCData(oldp+220,((((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_op_b) 
                                   << 7U) | ((0x00000040U 
                                              & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dhi) 
                                                 >> 1U)) 
                                             | (0x0000003fU 
                                                & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dhi) 
                                                   - (IData)(1U)))))),8);
        bufp->chgCData(oldp+221,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dat_shamt),8);
        bufp->chgBit(oldp+222,(((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_mret) 
                                | (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trap))));
        bufp->chgBit(oldp+223,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__pc_plus_4));
        bufp->chgBit(oldp+224,((1U & (((1U & vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__wb_ibus_adr) 
                                       + ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__i_cnt2) 
                                          + (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__pc_plus_4_cy_r))) 
                                      >> 1U))));
        bufp->chgBit(oldp+225,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__pc_plus_4_cy_r));
        bufp->chgBit(oldp+226,((1U & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__offset_a) 
                                      + ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__offset_b) 
                                         + (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__pc_plus_offset_cy_r))))));
        bufp->chgBit(oldp+227,((1U & (((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__offset_a) 
                                       + ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__offset_b) 
                                          + (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__pc_plus_offset_cy_r))) 
                                      >> 1U))));
        bufp->chgBit(oldp+228,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__pc_plus_offset_cy_r));
        bufp->chgBit(oldp+229,((1U & vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__wb_ibus_adr)));
        bufp->chgBit(oldp+230,((((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_mret) 
                                 | (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trap))
                                 ? ((~ (IData)(vlSymsp->TOP__servant_sim__dut.__VdfgRegularize_hd8275ffe_1_0)) 
                                    & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__i_rs2))
                                 : ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__jump)
                                     ? (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__o_bad_pc)
                                     : (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__pc_plus_4)))));
        bufp->chgBit(oldp+231,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__offset_a));
        bufp->chgBit(oldp+232,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__offset_b));
        bufp->chgIData(oldp+233,((vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt 
                                  >> 2U)),30);
        bufp->chgCData(oldp+234,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode),5);
        bufp->chgBit(oldp+235,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__op21));
        bufp->chgBit(oldp+236,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__op22));
        bufp->chgBit(oldp+237,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__op26));
        bufp->chgBit(oldp+238,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__imm25));
        bufp->chgBit(oldp+239,(((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__op20) 
                                | ((~ (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__op21)) 
                                   & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__op26)))));
        bufp->chgBit(oldp+240,((1U & (~ ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode) 
                                         >> 4U)))));
        bufp->chgBit(oldp+241,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mstatus_mie));
        bufp->chgBit(oldp+242,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mstatus_mpie));
        bufp->chgBit(oldp+243,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mie_mtie));
        bufp->chgBit(oldp+244,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mcause31));
        bufp->chgCData(oldp+245,(((((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mcause3_0__BRA__3__KET__) 
                                    << 3U) | ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mcause3_0__BRA__2__KET__) 
                                              << 2U)) 
                                  | (((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mcause3_0__BRA__1__KET__) 
                                      << 1U) | (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mcause3_0__BRA__0__KET__)))),4);
        bufp->chgBit(oldp+246,(((0U == (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt))
                                 ? (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mcause3_0__BRA__0__KET__)
                                 : ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt_done) 
                                    & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mcause31)))));
        bufp->chgBit(oldp+247,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__timer_irq_r));
        bufp->chgBit(oldp+248,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__d));
        bufp->chgBit(oldp+249,((((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_cnt3) 
                                 & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mstatus_mie)) 
                                | (((2U == (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt)) 
                                    & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb) 
                                       >> 3U)) | ((3U 
                                                   == (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt)) 
                                                  & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb))))));
        bufp->chgBit(oldp+250,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__timer_irq));
        bufp->chgBit(oldp+251,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__update_rd));
        bufp->chgBit(oldp+252,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__update_mscratch));
        bufp->chgBit(oldp+253,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__update_mtvec));
        bufp->chgBit(oldp+254,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__update_mepc));
        bufp->chgBit(oldp+255,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__update_mtval));
        bufp->chgBit(oldp+256,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__update_mstatus));
        bufp->chgBit(oldp+257,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__update_mie));
        bufp->chgBit(oldp+258,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__update_mcause));
        bufp->chgIData(oldp+259,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_rd),32);
        bufp->chgIData(oldp+260,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_csr),32);
        bufp->chgIData(oldp+261,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_mstatus),32);
        bufp->chgIData(oldp+262,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_mie),32);
        bufp->chgIData(oldp+263,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_mcause),32);
        bufp->chgIData(oldp+264,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_mscratch),32);
        bufp->chgIData(oldp+265,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_mtvec),32);
        bufp->chgIData(oldp+266,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_mepc),32);
        bufp->chgIData(oldp+267,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_mtval),32);
        bufp->chgIData(oldp+268,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x1),32);
        bufp->chgIData(oldp+269,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x2),32);
        bufp->chgIData(oldp+270,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x3),32);
        bufp->chgIData(oldp+271,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x4),32);
        bufp->chgIData(oldp+272,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x5),32);
        bufp->chgIData(oldp+273,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x6),32);
        bufp->chgIData(oldp+274,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x7),32);
        bufp->chgIData(oldp+275,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x8),32);
        bufp->chgIData(oldp+276,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x9),32);
        bufp->chgIData(oldp+277,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x10),32);
        bufp->chgIData(oldp+278,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x11),32);
        bufp->chgIData(oldp+279,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x12),32);
        bufp->chgIData(oldp+280,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x13),32);
        bufp->chgIData(oldp+281,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x14),32);
        bufp->chgIData(oldp+282,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x15),32);
        bufp->chgIData(oldp+283,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x16),32);
        bufp->chgIData(oldp+284,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x17),32);
        bufp->chgIData(oldp+285,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x18),32);
        bufp->chgIData(oldp+286,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x19),32);
        bufp->chgIData(oldp+287,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x20),32);
        bufp->chgIData(oldp+288,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x21),32);
        bufp->chgIData(oldp+289,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x22),32);
        bufp->chgIData(oldp+290,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x23),32);
        bufp->chgIData(oldp+291,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x24),32);
        bufp->chgIData(oldp+292,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x25),32);
        bufp->chgIData(oldp+293,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x26),32);
        bufp->chgIData(oldp+294,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x27),32);
        bufp->chgIData(oldp+295,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x28),32);
        bufp->chgIData(oldp+296,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x29),32);
        bufp->chgIData(oldp+297,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x30),32);
        bufp->chgIData(oldp+298,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x31),32);
        bufp->chgBit(oldp+299,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__LUI));
        bufp->chgBit(oldp+300,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__AUIPC));
        bufp->chgBit(oldp+301,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__JAL));
        bufp->chgBit(oldp+302,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__JALR));
        bufp->chgBit(oldp+303,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__BEQ));
        bufp->chgBit(oldp+304,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__BNE));
        bufp->chgBit(oldp+305,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__BLT));
        bufp->chgBit(oldp+306,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__BGE));
        bufp->chgBit(oldp+307,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__BLTU));
        bufp->chgBit(oldp+308,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__BGEU));
        bufp->chgBit(oldp+309,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__LB));
        bufp->chgBit(oldp+310,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__LH));
        bufp->chgBit(oldp+311,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__LW));
        bufp->chgBit(oldp+312,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__LBU));
        bufp->chgBit(oldp+313,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__LHU));
        bufp->chgBit(oldp+314,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SB));
        bufp->chgBit(oldp+315,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SH));
        bufp->chgBit(oldp+316,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SW));
        bufp->chgBit(oldp+317,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__ADDI));
        bufp->chgBit(oldp+318,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SLTI));
        bufp->chgBit(oldp+319,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SLTIU));
        bufp->chgBit(oldp+320,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__XORI));
        bufp->chgBit(oldp+321,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__ORI));
        bufp->chgBit(oldp+322,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__ANDI));
        bufp->chgBit(oldp+323,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SLLI));
        bufp->chgBit(oldp+324,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SRLI));
        bufp->chgBit(oldp+325,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SRAI));
        bufp->chgBit(oldp+326,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__ADD));
        bufp->chgBit(oldp+327,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SUB));
        bufp->chgBit(oldp+328,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SLL));
        bufp->chgBit(oldp+329,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SLT));
        bufp->chgBit(oldp+330,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SLTU));
        bufp->chgBit(oldp+331,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__XOR));
        bufp->chgBit(oldp+332,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SRL));
        bufp->chgBit(oldp+333,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SRA));
        bufp->chgBit(oldp+334,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__OR));
        bufp->chgBit(oldp+335,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__AND));
        bufp->chgBit(oldp+336,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__FENCE));
        bufp->chgBit(oldp+337,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__ECALL));
        bufp->chgBit(oldp+338,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__EBREAK));
        bufp->chgBit(oldp+339,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__CSRRW));
        bufp->chgBit(oldp+340,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__CSRRS));
        bufp->chgBit(oldp+341,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__CSRRC));
        bufp->chgBit(oldp+342,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__CSRRWI));
        bufp->chgBit(oldp+343,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__CSRRSI));
        bufp->chgBit(oldp+344,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__CSRRCI));
        bufp->chgBit(oldp+345,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__OTHER));
        bufp->chgIData(oldp+346,((vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt 
                                  >> 7U)),25);
        bufp->chgBit(oldp+347,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm31));
        bufp->chgSData(oldp+348,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm19_12_20),9);
        bufp->chgBit(oldp+349,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm7));
        bufp->chgCData(oldp+350,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm30_25),6);
        bufp->chgBit(oldp+351,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__signbit));
        bufp->chgBit(oldp+352,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__mem_if__DOT__signbit));
        bufp->chgBit(oldp+353,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__mem_if__DOT__dat_valid));
        bufp->chgBit(oldp+354,((((~ (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_init)) 
                                 & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_rd_op)) 
                                & (0U != (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7)))));
        bufp->chgBit(oldp+355,(((((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__o_q) 
                                  | (((0U == (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3)) 
                                      & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__alu__DOT__result_add)) 
                                     | ((IData)((((2U 
                                                   == 
                                                   (6U 
                                                    & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3))) 
                                                  & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__alu__DOT__cmp_r)) 
                                                 & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt0))) 
                                        | (((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                                            >> 2U) 
                                           & (((~ (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3)) 
                                               & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_op_b) 
                                                  ^ (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rdata0))) 
                                              | (((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                                                  >> 1U) 
                                                 & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_op_b) 
                                                    & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rdata0)))))))) 
                                 & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_rd_alu_en)) 
                                | (((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__o_q) 
                                    & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_rd_csr_en)) 
                                   | ((((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__mem_if__DOT__dat_valid)
                                         ? (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_q)
                                         : ((~ ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                                                >> 2U)) 
                                            & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__mem_if__DOT__signbit))) 
                                       & (IData)((0U 
                                                  == 
                                                  (5U 
                                                   & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode))))) 
                                      | (((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__i_utype) 
                                          & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__o_bad_pc)) 
                                         | ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__pc_plus_4) 
                                            & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__i_jal_or_jalr))))))));
        bufp->chgBit(oldp+356,(((0x00000010U & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode))
                                 ? (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__o_bad_pc)
                                 : (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__o_q))));
        bufp->chgBit(oldp+357,((1U & (~ (IData)(vlSymsp->TOP__servant_sim__dut.cpu__DOT__cpu__DOT__rf_if__DOT____VdfgRegularize_h1739b917_0_0)))));
        bufp->chgBit(oldp+358,((1U & (vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                      >> 1U))));
        bufp->chgBit(oldp+359,((1U == (3U & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                                             >> 1U)))));
        bufp->chgBit(oldp+360,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__init_done));
        bufp->chgBit(oldp+361,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_csr__DOT__misalign_trap_sync_r));
        bufp->chgCData(oldp+362,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt),3);
        bufp->chgCData(oldp+363,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb),4);
        bufp->chgBit(oldp+364,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__ibus_cyc));
        bufp->chgBit(oldp+365,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__take_branch));
        bufp->chgBit(oldp+366,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__last_init));
        bufp->chgBit(oldp+367,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__trap_pending));
        bufp->chgBit(oldp+368,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__mux__DOT__sig_en));
        bufp->chgBit(oldp+369,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__mux__DOT__halt_en));
        bufp->chgBit(oldp+370,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__mux__DOT__sim_ack));
        bufp->chgBit(oldp+371,((0U != (vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                       >> 0x0000001eU))));
        bufp->chgBit(oldp+372,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rgnt));
        bufp->chgCData(oldp+373,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rcnt),5);
        bufp->chgBit(oldp+374,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rtrig1));
        bufp->chgCData(oldp+375,((0x0000001fU & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rcnt) 
                                                 - (IData)(4U)))),5);
        bufp->chgCData(oldp+376,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__wdata0_r),2);
        bufp->chgCData(oldp+377,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__wdata1_r),3);
        bufp->chgBit(oldp+378,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__wen0_r));
        bufp->chgBit(oldp+379,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__wen1_r));
        bufp->chgBit(oldp+380,((1U & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rcnt))));
        bufp->chgCData(oldp+381,(((1U & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rcnt))
                                   ? ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trap)
                                       ? 0x22U : (0x00000020U 
                                                  | (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_csr_addr)))
                                   : ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trap)
                                       ? 0x23U : (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7)))),6);
        bufp->chgCData(oldp+382,(((1U & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rcnt))
                                   ? (((IData)(vlSymsp->TOP__servant_sim__dut.cpu__DOT__cpu__DOT__rf_if__DOT____VdfgRegularize_h1739b917_0_0) 
                                       << 5U) | ((0x0000001cU 
                                                  & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm24_20) 
                                                     & ((- (IData)(
                                                                   (1U 
                                                                    & (~ (IData)(vlSymsp->TOP__servant_sim__dut.cpu__DOT__cpu__DOT__rf_if__DOT____VdfgRegularize_h1739b917_0_0))))) 
                                                        << 2U))) 
                                                 | (3U 
                                                    & ((((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_mret) 
                                                         << 1U) 
                                                        | (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trap)) 
                                                       | (((- (IData)((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_csr_en))) 
                                                           & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_csr_addr)) 
                                                          | ((- (IData)(
                                                                        (1U 
                                                                         & (~ (IData)(vlSymsp->TOP__servant_sim__dut.cpu__DOT__cpu__DOT__rf_if__DOT____VdfgRegularize_h1739b917_0_0))))) 
                                                             & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm24_20)))))))
                                   : (0x0000001fU & 
                                      ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm19_12_20) 
                                       >> 4U)))),6);
        bufp->chgCData(oldp+383,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rdata0),2);
        bufp->chgBit(oldp+384,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rdata1));
        bufp->chgBit(oldp+385,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rreq_r));
        bufp->chgCData(oldp+386,(vlSymsp->TOP__servant_sim__dut.__PVT__rf_ram__DOT__rdata),2);
        bufp->chgBit(oldp+387,(vlSymsp->TOP__servant_sim__dut.__PVT__rf_ram__DOT__regzero));
        bufp->chgCData(oldp+388,((vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                  >> 0x0000001eU)),2);
        bufp->chgIData(oldp+389,(vlSymsp->TOP__servant_sim__dut.__PVT__timer__DOT__mtimecmp),32);
    }
    bufp->chgBit(oldp+390,(vlSelfRef.wb_clk));
    bufp->chgBit(oldp+391,(vlSelfRef.wb_rst));
    bufp->chgIData(oldp+392,(vlSelfRef.pc_adr),32);
    bufp->chgBit(oldp+393,(vlSelfRef.pc_vld));
    bufp->chgBit(oldp+394,(vlSelfRef.q));
    bufp->chgSData(oldp+395,((0x000007ffU & (vlSelfRef.pc_adr 
                                             >> 2U))),11);
}

void Vservant_sim___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vservant_sim___024root__trace_cleanup\n"); );
    // Body
    Vservant_sim___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vservant_sim___024root*>(voidSelf);
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    vlSymsp->__Vm_activity = false;
    vlSymsp->TOP.__Vm_traceActivity[0U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[1U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[2U] = 0U;
}
