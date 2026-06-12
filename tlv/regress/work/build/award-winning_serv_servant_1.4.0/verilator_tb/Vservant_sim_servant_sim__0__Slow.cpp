// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vservant_sim.h for the primary calling header

#include "Vservant_sim__pch.h"

VL_ATTR_COLD void Vservant_sim_servant_sim___eval_initial__TOP__servant_sim(Vservant_sim_servant_sim* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+      Vservant_sim_servant_sim___eval_initial__TOP__servant_sim\n"); );
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if (VL_UNLIKELY((VL_VALUEPLUSARGS_INW(1024, "firmware=%s"s, 
                                          vlSelfRef.__PVT__firmware_file)))) {
        VL_WRITEF_NX("Loading RAM from %0s\n",0,1024,
                     vlSelfRef.__PVT__firmware_file.data());
        VL_READMEM_N(true, 32, 2048, 0, VL_CVT_PACK_STR_NW(32, vlSelfRef.__PVT__firmware_file)
                     ,  &(vlSymsp->TOP__servant_sim__dut__ram.mem)
                     , 0, ~0ULL);
    }
}

VL_ATTR_COLD void Vservant_sim_servant_sim___ctor_var_reset(Vservant_sim_servant_sim* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+      Vservant_sim_servant_sim___ctor_var_reset\n"); );
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    const uint64_t __VscopeHash = VL_MURMUR64_HASH(vlSelf->name());
    vlSelf->wb_clk = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 698468219118072005ull);
    vlSelf->wb_rst = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 4170193020889413778ull);
    vlSelf->pc_adr = VL_SCOPED_RAND_RESET_I(32, __VscopeHash, 3648203601179646818ull);
    vlSelf->pc_vld = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 1212806710944158544ull);
    vlSelf->q = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 8861071527689086543ull);
    VL_SCOPED_RAND_RESET_W(1024, vlSelf->__PVT__firmware_file, __VscopeHash, 3146487849762252557ull);
}
