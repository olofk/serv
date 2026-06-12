// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vservant_sim.h for the primary calling header

#include "Vservant_sim__pch.h"

#ifdef VL_DEBUG
VL_ATTR_COLD void Vservant_sim___024root___dump_triggers__ico(Vservant_sim___024root* vlSelf);
#endif  // VL_DEBUG

void Vservant_sim___024root___eval_triggers__ico(Vservant_sim___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vservant_sim___024root___eval_triggers__ico\n"); );
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__VicoTriggered.setBit(0U, (IData)(vlSelfRef.__VicoFirstIteration));
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vservant_sim___024root___dump_triggers__ico(vlSelf);
    }
#endif
}

void Vservant_sim_servant__Mz1_Dz2_S1_Cz3_Az3___ico_sequent__TOP__servant_sim__dut__0(Vservant_sim_servant__Mz1_Dz2_S1_Cz3_Az3* vlSelf);
void Vservant_sim___024root___ico_sequent__TOP__0(Vservant_sim___024root* vlSelf);
void Vservant_sim_servant_ram__D2000_R4d494e49___ico_sequent__TOP__servant_sim__dut__ram__0(Vservant_sim_servant_ram__D2000_R4d494e49* vlSelf);

void Vservant_sim___024root___eval_ico(Vservant_sim___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vservant_sim___024root___eval_ico\n"); );
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1ULL & vlSelfRef.__VicoTriggered.word(0U))) {
        Vservant_sim_servant__Mz1_Dz2_S1_Cz3_Az3___ico_sequent__TOP__servant_sim__dut__0((&vlSymsp->TOP__servant_sim__dut));
        vlSelfRef.__Vm_traceActivity[1U] = 1U;
        Vservant_sim___024root___ico_sequent__TOP__0(vlSelf);
        Vservant_sim_servant_ram__D2000_R4d494e49___ico_sequent__TOP__servant_sim__dut__ram__0((&vlSymsp->TOP__servant_sim__dut__ram));
    }
}

void Vservant_sim___024root___ico_sequent__TOP__0(Vservant_sim___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vservant_sim___024root___ico_sequent__TOP__0\n"); );
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.pc_adr = ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_ibus_cyc)
                         ? vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__wb_ibus_adr
                         : (0xfffffffcU & vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__data));
}

bool Vservant_sim___024root___eval_phase__ico(Vservant_sim___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vservant_sim___024root___eval_phase__ico\n"); );
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VicoExecute;
    // Body
    Vservant_sim___024root___eval_triggers__ico(vlSelf);
    __VicoExecute = vlSelfRef.__VicoTriggered.any();
    if (__VicoExecute) {
        Vservant_sim___024root___eval_ico(vlSelf);
    }
    return (__VicoExecute);
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vservant_sim___024root___dump_triggers__act(Vservant_sim___024root* vlSelf);
#endif  // VL_DEBUG

void Vservant_sim___024root___eval_triggers__act(Vservant_sim___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vservant_sim___024root___eval_triggers__act\n"); );
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__VactTriggered.setBit(0U, ((IData)(vlSelfRef.wb_clk) 
                                          & (~ (IData)(vlSelfRef.__Vtrigprevexpr___TOP__wb_clk__0))));
    vlSelfRef.__Vtrigprevexpr___TOP__wb_clk__0 = vlSelfRef.wb_clk;
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vservant_sim___024root___dump_triggers__act(vlSelf);
    }
#endif
}

void Vservant_sim___024root___eval_act(Vservant_sim___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vservant_sim___024root___eval_act\n"); );
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}

void Vservant_sim_servant__Mz1_Dz2_S1_Cz3_Az3___nba_sequent__TOP__servant_sim__dut__0(Vservant_sim_servant__Mz1_Dz2_S1_Cz3_Az3* vlSelf);
void Vservant_sim_servant_ram__D2000_R4d494e49___nba_sequent__TOP__servant_sim__dut__ram__0(Vservant_sim_servant_ram__D2000_R4d494e49* vlSelf);
void Vservant_sim___024root___nba_sequent__TOP__0(Vservant_sim___024root* vlSelf);
void Vservant_sim_servant__Mz1_Dz2_S1_Cz3_Az3___nba_sequent__TOP__servant_sim__dut__1(Vservant_sim_servant__Mz1_Dz2_S1_Cz3_Az3* vlSelf);

void Vservant_sim___024root___eval_nba(Vservant_sim___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vservant_sim___024root___eval_nba\n"); );
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1ULL & vlSelfRef.__VnbaTriggered.word(0U))) {
        Vservant_sim_servant__Mz1_Dz2_S1_Cz3_Az3___nba_sequent__TOP__servant_sim__dut__0((&vlSymsp->TOP__servant_sim__dut));
        vlSelfRef.__Vm_traceActivity[2U] = 1U;
        Vservant_sim_servant_ram__D2000_R4d494e49___nba_sequent__TOP__servant_sim__dut__ram__0((&vlSymsp->TOP__servant_sim__dut__ram));
        Vservant_sim___024root___nba_sequent__TOP__0(vlSelf);
        Vservant_sim_servant__Mz1_Dz2_S1_Cz3_Az3___nba_sequent__TOP__servant_sim__dut__1((&vlSymsp->TOP__servant_sim__dut));
        Vservant_sim_servant_ram__D2000_R4d494e49___ico_sequent__TOP__servant_sim__dut__ram__0((&vlSymsp->TOP__servant_sim__dut__ram));
    }
}

void Vservant_sim___024root___nba_sequent__TOP__0(Vservant_sim___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vservant_sim___024root___nba_sequent__TOP__0\n"); );
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.q = vlSymsp->TOP__servant_sim__dut.__PVT__q;
    vlSelfRef.pc_adr = ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_ibus_cyc)
                         ? vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__wb_ibus_adr
                         : (0xfffffffcU & vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__data));
    vlSelfRef.pc_vld = vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_ack;
}

bool Vservant_sim___024root___eval_phase__act(Vservant_sim___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vservant_sim___024root___eval_phase__act\n"); );
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    VlTriggerVec<1> __VpreTriggered;
    CData/*0:0*/ __VactExecute;
    // Body
    Vservant_sim___024root___eval_triggers__act(vlSelf);
    __VactExecute = vlSelfRef.__VactTriggered.any();
    if (__VactExecute) {
        __VpreTriggered.andNot(vlSelfRef.__VactTriggered, vlSelfRef.__VnbaTriggered);
        vlSelfRef.__VnbaTriggered.thisOr(vlSelfRef.__VactTriggered);
        Vservant_sim___024root___eval_act(vlSelf);
    }
    return (__VactExecute);
}

bool Vservant_sim___024root___eval_phase__nba(Vservant_sim___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vservant_sim___024root___eval_phase__nba\n"); );
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VnbaExecute;
    // Body
    __VnbaExecute = vlSelfRef.__VnbaTriggered.any();
    if (__VnbaExecute) {
        Vservant_sim___024root___eval_nba(vlSelf);
        vlSelfRef.__VnbaTriggered.clear();
    }
    return (__VnbaExecute);
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vservant_sim___024root___dump_triggers__nba(Vservant_sim___024root* vlSelf);
#endif  // VL_DEBUG

void Vservant_sim___024root___eval(Vservant_sim___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vservant_sim___024root___eval\n"); );
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    IData/*31:0*/ __VicoIterCount;
    CData/*0:0*/ __VicoContinue;
    IData/*31:0*/ __VnbaIterCount;
    CData/*0:0*/ __VnbaContinue;
    // Body
    __VicoIterCount = 0U;
    vlSelfRef.__VicoFirstIteration = 1U;
    __VicoContinue = 1U;
    while (__VicoContinue) {
        if (VL_UNLIKELY(((0x00000064U < __VicoIterCount)))) {
#ifdef VL_DEBUG
            Vservant_sim___024root___dump_triggers__ico(vlSelf);
#endif
            VL_FATAL_MT("src/award-winning_serv_servant_1.4.0/bench/servant_sim.v", 2, "", "Input combinational region did not converge after 100 tries");
        }
        __VicoIterCount = ((IData)(1U) + __VicoIterCount);
        __VicoContinue = 0U;
        if (Vservant_sim___024root___eval_phase__ico(vlSelf)) {
            __VicoContinue = 1U;
        }
        vlSelfRef.__VicoFirstIteration = 0U;
    }
    __VnbaIterCount = 0U;
    __VnbaContinue = 1U;
    while (__VnbaContinue) {
        if (VL_UNLIKELY(((0x00000064U < __VnbaIterCount)))) {
#ifdef VL_DEBUG
            Vservant_sim___024root___dump_triggers__nba(vlSelf);
#endif
            VL_FATAL_MT("src/award-winning_serv_servant_1.4.0/bench/servant_sim.v", 2, "", "NBA region did not converge after 100 tries");
        }
        __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
        __VnbaContinue = 0U;
        vlSelfRef.__VactIterCount = 0U;
        vlSelfRef.__VactContinue = 1U;
        while (vlSelfRef.__VactContinue) {
            if (VL_UNLIKELY(((0x00000064U < vlSelfRef.__VactIterCount)))) {
#ifdef VL_DEBUG
                Vservant_sim___024root___dump_triggers__act(vlSelf);
#endif
                VL_FATAL_MT("src/award-winning_serv_servant_1.4.0/bench/servant_sim.v", 2, "", "Active region did not converge after 100 tries");
            }
            vlSelfRef.__VactIterCount = ((IData)(1U) 
                                         + vlSelfRef.__VactIterCount);
            vlSelfRef.__VactContinue = 0U;
            if (Vservant_sim___024root___eval_phase__act(vlSelf)) {
                vlSelfRef.__VactContinue = 1U;
            }
        }
        if (Vservant_sim___024root___eval_phase__nba(vlSelf)) {
            __VnbaContinue = 1U;
        }
    }
}

#ifdef VL_DEBUG
void Vservant_sim___024root___eval_debug_assertions(Vservant_sim___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vservant_sim___024root___eval_debug_assertions\n"); );
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if (VL_UNLIKELY(((vlSelfRef.wb_clk & 0xfeU)))) {
        Verilated::overWidthError("wb_clk");
    }
    if (VL_UNLIKELY(((vlSelfRef.wb_rst & 0xfeU)))) {
        Verilated::overWidthError("wb_rst");
    }
}
#endif  // VL_DEBUG
