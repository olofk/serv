// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vservant_sim.h for the primary calling header

#include "Vservant_sim__pch.h"

void Vservant_sim_servant_ram__D2000_R4d494e49___ico_sequent__TOP__servant_sim__dut__ram__0(Vservant_sim_servant_ram__D2000_R4d494e49* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+          Vservant_sim_servant_ram__D2000_R4d494e49___ico_sequent__TOP__servant_sim__dut__ram__0\n"); );
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__PVT__we = ((- (IData)(((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__arbiter__DOT__o_wb_mem_stb) 
                                       & ((~ (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_ibus_cyc)) 
                                          & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode) 
                                             >> 3U))))) 
                           & ((((2U & (((3U == (3U 
                                                & vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__data)) 
                                        | (((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                                            >> 1U) 
                                           | ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                                              & (vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__data 
                                                 >> 1U)))) 
                                       << 1U)) | (1U 
                                                  & ((2U 
                                                      == 
                                                      (3U 
                                                       & vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__data)) 
                                                     | ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                                                        >> 1U)))) 
                               << 2U) | ((2U & (((1U 
                                                  == 
                                                  (3U 
                                                   & vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__data)) 
                                                 | (((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                                                     >> 1U) 
                                                    | ((~ 
                                                        (vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__data 
                                                         >> 1U)) 
                                                       & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3)))) 
                                                << 1U)) 
                                         | (0U == (3U 
                                                   & vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__data)))));
}

void Vservant_sim_servant_ram__D2000_R4d494e49___nba_sequent__TOP__servant_sim__dut__ram__0(Vservant_sim_servant_ram__D2000_R4d494e49* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+          Vservant_sim_servant_ram__D2000_R4d494e49___nba_sequent__TOP__servant_sim__dut__ram__0\n"); );
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*7:0*/ __VdlyVal__mem__v0;
    __VdlyVal__mem__v0 = 0;
    SData/*10:0*/ __VdlyDim0__mem__v0;
    __VdlyDim0__mem__v0 = 0;
    CData/*0:0*/ __VdlySet__mem__v0;
    __VdlySet__mem__v0 = 0;
    CData/*7:0*/ __VdlyVal__mem__v1;
    __VdlyVal__mem__v1 = 0;
    SData/*10:0*/ __VdlyDim0__mem__v1;
    __VdlyDim0__mem__v1 = 0;
    CData/*0:0*/ __VdlySet__mem__v1;
    __VdlySet__mem__v1 = 0;
    CData/*7:0*/ __VdlyVal__mem__v2;
    __VdlyVal__mem__v2 = 0;
    SData/*10:0*/ __VdlyDim0__mem__v2;
    __VdlyDim0__mem__v2 = 0;
    CData/*0:0*/ __VdlySet__mem__v2;
    __VdlySet__mem__v2 = 0;
    CData/*7:0*/ __VdlyVal__mem__v3;
    __VdlyVal__mem__v3 = 0;
    SData/*10:0*/ __VdlyDim0__mem__v3;
    __VdlyDim0__mem__v3 = 0;
    CData/*0:0*/ __VdlySet__mem__v3;
    __VdlySet__mem__v3 = 0;
    // Body
    __VdlySet__mem__v0 = 0U;
    __VdlySet__mem__v1 = 0U;
    __VdlySet__mem__v2 = 0U;
    __VdlySet__mem__v3 = 0U;
    vlSelfRef.__PVT__o_wb_ack = ((~ (IData)(vlSymsp->TOP.wb_rst)) 
                                 & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__arbiter__DOT__o_wb_mem_stb) 
                                    & (~ (IData)(vlSelfRef.__PVT__o_wb_ack))));
    if ((1U & (IData)(vlSelfRef.__PVT__we))) {
        __VdlyVal__mem__v0 = (0x000000ffU & vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_dat);
        __VdlyDim0__mem__v0 = (0x000007ffU & (vlSymsp->TOP.pc_adr 
                                              >> 2U));
        __VdlySet__mem__v0 = 1U;
    }
    if ((2U & (IData)(vlSelfRef.__PVT__we))) {
        __VdlyVal__mem__v1 = (0x000000ffU & (vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_dat 
                                             >> 8U));
        __VdlyDim0__mem__v1 = (0x000007ffU & (vlSymsp->TOP.pc_adr 
                                              >> 2U));
        __VdlySet__mem__v1 = 1U;
    }
    if ((4U & (IData)(vlSelfRef.__PVT__we))) {
        __VdlyVal__mem__v2 = (0x000000ffU & (vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_dat 
                                             >> 0x10U));
        __VdlyDim0__mem__v2 = (0x000007ffU & (vlSymsp->TOP.pc_adr 
                                              >> 2U));
        __VdlySet__mem__v2 = 1U;
    }
    if ((8U & (IData)(vlSelfRef.__PVT__we))) {
        __VdlyVal__mem__v3 = (vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_dat 
                              >> 0x18U);
        __VdlyDim0__mem__v3 = (0x000007ffU & (vlSymsp->TOP.pc_adr 
                                              >> 2U));
        __VdlySet__mem__v3 = 1U;
    }
    vlSelfRef.__PVT__o_wb_rdt = vlSelfRef.mem[(0x000007ffU 
                                               & (vlSymsp->TOP.pc_adr 
                                                  >> 2U))];
    if (__VdlySet__mem__v0) {
        vlSelfRef.mem[__VdlyDim0__mem__v0] = ((0xffffff00U 
                                               & vlSelfRef.mem
                                               [__VdlyDim0__mem__v0]) 
                                              | (IData)(__VdlyVal__mem__v0));
    }
    if (__VdlySet__mem__v1) {
        vlSelfRef.mem[__VdlyDim0__mem__v1] = ((0xffff00ffU 
                                               & vlSelfRef.mem
                                               [__VdlyDim0__mem__v1]) 
                                              | ((IData)(__VdlyVal__mem__v1) 
                                                 << 8U));
    }
    if (__VdlySet__mem__v2) {
        vlSelfRef.mem[__VdlyDim0__mem__v2] = ((0xff00ffffU 
                                               & vlSelfRef.mem
                                               [__VdlyDim0__mem__v2]) 
                                              | ((IData)(__VdlyVal__mem__v2) 
                                                 << 0x00000010U));
    }
    if (__VdlySet__mem__v3) {
        vlSelfRef.mem[__VdlyDim0__mem__v3] = ((0x00ffffffU 
                                               & vlSelfRef.mem
                                               [__VdlyDim0__mem__v3]) 
                                              | ((IData)(__VdlyVal__mem__v3) 
                                                 << 0x00000018U));
    }
}
