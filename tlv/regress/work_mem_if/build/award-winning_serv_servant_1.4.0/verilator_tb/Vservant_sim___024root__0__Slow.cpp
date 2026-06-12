// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vservant_sim.h for the primary calling header

#include "Vservant_sim__pch.h"

VL_ATTR_COLD void Vservant_sim_servant__Mz1_Dz2_S1_Cz3_Az3___eval_static__TOP__servant_sim__dut(Vservant_sim_servant__Mz1_Dz2_S1_Cz3_Az3* vlSelf);
VL_ATTR_COLD void Vservant_sim___024root____Vm_traceActivitySetAll(Vservant_sim___024root* vlSelf);

VL_ATTR_COLD void Vservant_sim___024root___eval_static(Vservant_sim___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vservant_sim___024root___eval_static\n"); );
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    Vservant_sim_servant__Mz1_Dz2_S1_Cz3_Az3___eval_static__TOP__servant_sim__dut((&vlSymsp->TOP__servant_sim__dut));
    Vservant_sim___024root____Vm_traceActivitySetAll(vlSelf);
    vlSelfRef.__Vtrigprevexpr___TOP__wb_clk__0 = vlSelfRef.wb_clk;
}

VL_ATTR_COLD void Vservant_sim_servant_sim___eval_initial__TOP__servant_sim(Vservant_sim_servant_sim* vlSelf);
VL_ATTR_COLD void Vservant_sim_servant__Mz1_Dz2_S1_Cz3_Az3___eval_initial__TOP__servant_sim__dut(Vservant_sim_servant__Mz1_Dz2_S1_Cz3_Az3* vlSelf);

VL_ATTR_COLD void Vservant_sim___024root___eval_initial(Vservant_sim___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vservant_sim___024root___eval_initial\n"); );
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    Vservant_sim_servant_sim___eval_initial__TOP__servant_sim((&vlSymsp->TOP__servant_sim));
    Vservant_sim___024root____Vm_traceActivitySetAll(vlSelf);
    Vservant_sim_servant__Mz1_Dz2_S1_Cz3_Az3___eval_initial__TOP__servant_sim__dut((&vlSymsp->TOP__servant_sim__dut));
}

VL_ATTR_COLD void Vservant_sim___024root___eval_final(Vservant_sim___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vservant_sim___024root___eval_final\n"); );
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vservant_sim___024root___dump_triggers__stl(Vservant_sim___024root* vlSelf);
#endif  // VL_DEBUG
VL_ATTR_COLD bool Vservant_sim___024root___eval_phase__stl(Vservant_sim___024root* vlSelf);

VL_ATTR_COLD void Vservant_sim___024root___eval_settle(Vservant_sim___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vservant_sim___024root___eval_settle\n"); );
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    IData/*31:0*/ __VstlIterCount;
    CData/*0:0*/ __VstlContinue;
    // Body
    __VstlIterCount = 0U;
    vlSelfRef.__VstlFirstIteration = 1U;
    __VstlContinue = 1U;
    while (__VstlContinue) {
        if (VL_UNLIKELY(((0x00000064U < __VstlIterCount)))) {
#ifdef VL_DEBUG
            Vservant_sim___024root___dump_triggers__stl(vlSelf);
#endif
            VL_FATAL_MT("src/award-winning_serv_servant_1.4.0/bench/servant_sim.v", 2, "", "Settle region did not converge after 100 tries");
        }
        __VstlIterCount = ((IData)(1U) + __VstlIterCount);
        __VstlContinue = 0U;
        if (Vservant_sim___024root___eval_phase__stl(vlSelf)) {
            __VstlContinue = 1U;
        }
        vlSelfRef.__VstlFirstIteration = 0U;
    }
}

VL_ATTR_COLD void Vservant_sim___024root___eval_triggers__stl(Vservant_sim___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vservant_sim___024root___eval_triggers__stl\n"); );
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__VstlTriggered.setBit(0U, (IData)(vlSelfRef.__VstlFirstIteration));
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vservant_sim___024root___dump_triggers__stl(vlSelf);
    }
#endif
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vservant_sim___024root___dump_triggers__stl(Vservant_sim___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vservant_sim___024root___dump_triggers__stl\n"); );
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1U & (~ vlSelfRef.__VstlTriggered.any()))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelfRef.__VstlTriggered.word(0U))) {
        VL_DBG_MSGF("         'stl' region trigger index 0 is active: Internal 'stl' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Vservant_sim___024root___stl_sequent__TOP__0(Vservant_sim___024root* vlSelf);
VL_ATTR_COLD void Vservant_sim_servant__Mz1_Dz2_S1_Cz3_Az3___stl_sequent__TOP__servant_sim__dut__0(Vservant_sim_servant__Mz1_Dz2_S1_Cz3_Az3* vlSelf);
void Vservant_sim___024root___ico_sequent__TOP__0(Vservant_sim___024root* vlSelf);
void Vservant_sim_servant_ram__D2000_R4d494e49___ico_sequent__TOP__servant_sim__dut__ram__0(Vservant_sim_servant_ram__D2000_R4d494e49* vlSelf);

VL_ATTR_COLD void Vservant_sim___024root___eval_stl(Vservant_sim___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vservant_sim___024root___eval_stl\n"); );
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1ULL & vlSelfRef.__VstlTriggered.word(0U))) {
        Vservant_sim___024root___stl_sequent__TOP__0(vlSelf);
        Vservant_sim___024root____Vm_traceActivitySetAll(vlSelf);
        Vservant_sim_servant__Mz1_Dz2_S1_Cz3_Az3___stl_sequent__TOP__servant_sim__dut__0((&vlSymsp->TOP__servant_sim__dut));
        Vservant_sim___024root___ico_sequent__TOP__0(vlSelf);
        Vservant_sim_servant_ram__D2000_R4d494e49___ico_sequent__TOP__servant_sim__dut__ram__0((&vlSymsp->TOP__servant_sim__dut__ram));
    }
}

VL_ATTR_COLD void Vservant_sim___024root___stl_sequent__TOP__0(Vservant_sim___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vservant_sim___024root___stl_sequent__TOP__0\n"); );
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.q = vlSymsp->TOP__servant_sim__dut.__PVT__q;
    vlSelfRef.pc_vld = vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_ack;
}

VL_ATTR_COLD bool Vservant_sim___024root___eval_phase__stl(Vservant_sim___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vservant_sim___024root___eval_phase__stl\n"); );
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VstlExecute;
    // Body
    Vservant_sim___024root___eval_triggers__stl(vlSelf);
    __VstlExecute = vlSelfRef.__VstlTriggered.any();
    if (__VstlExecute) {
        Vservant_sim___024root___eval_stl(vlSelf);
    }
    return (__VstlExecute);
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vservant_sim___024root___dump_triggers__ico(Vservant_sim___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vservant_sim___024root___dump_triggers__ico\n"); );
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1U & (~ vlSelfRef.__VicoTriggered.any()))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelfRef.__VicoTriggered.word(0U))) {
        VL_DBG_MSGF("         'ico' region trigger index 0 is active: Internal 'ico' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

#ifdef VL_DEBUG
VL_ATTR_COLD void Vservant_sim___024root___dump_triggers__act(Vservant_sim___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vservant_sim___024root___dump_triggers__act\n"); );
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1U & (~ vlSelfRef.__VactTriggered.any()))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelfRef.__VactTriggered.word(0U))) {
        VL_DBG_MSGF("         'act' region trigger index 0 is active: @(posedge wb_clk)\n");
    }
}
#endif  // VL_DEBUG

#ifdef VL_DEBUG
VL_ATTR_COLD void Vservant_sim___024root___dump_triggers__nba(Vservant_sim___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vservant_sim___024root___dump_triggers__nba\n"); );
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1U & (~ vlSelfRef.__VnbaTriggered.any()))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelfRef.__VnbaTriggered.word(0U))) {
        VL_DBG_MSGF("         'nba' region trigger index 0 is active: @(posedge wb_clk)\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Vservant_sim___024root____Vm_traceActivitySetAll(Vservant_sim___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vservant_sim___024root____Vm_traceActivitySetAll\n"); );
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__Vm_traceActivity[0U] = 1U;
    vlSelfRef.__Vm_traceActivity[1U] = 1U;
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
}

VL_ATTR_COLD void Vservant_sim___024root___ctor_var_reset(Vservant_sim___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vservant_sim___024root___ctor_var_reset\n"); );
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    const uint64_t __VscopeHash = VL_MURMUR64_HASH(vlSelf->name());
    vlSelf->wb_clk = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 698468219118072005ull);
    vlSelf->wb_rst = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 4170193020889413778ull);
    vlSelf->pc_adr = VL_SCOPED_RAND_RESET_I(32, __VscopeHash, 3648203601179646818ull);
    vlSelf->pc_vld = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 1212806710944158544ull);
    vlSelf->q = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 8861071527689086543ull);
    vlSelf->__Vtrigprevexpr___TOP__wb_clk__0 = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 18168319319735634787ull);
    for (int __Vi0 = 0; __Vi0 < 3; ++__Vi0) {
        vlSelf->__Vm_traceActivity[__Vi0] = 0;
    }
}
