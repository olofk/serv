// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vservant_sim.h for the primary calling header

#ifndef VERILATED_VSERVANT_SIM___024ROOT_H_
#define VERILATED_VSERVANT_SIM___024ROOT_H_  // guard

#include "verilated.h"
class Vservant_sim_servant_sim;


class Vservant_sim__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vservant_sim___024root final : public VerilatedModule {
  public:
    // CELLS
    Vservant_sim_servant_sim* servant_sim;

    // DESIGN SPECIFIC STATE
    VL_IN8(wb_clk,0,0);
    VL_IN8(wb_rst,0,0);
    VL_OUT8(pc_vld,0,0);
    VL_OUT8(q,0,0);
    CData/*0:0*/ __VstlFirstIteration;
    CData/*0:0*/ __VicoFirstIteration;
    CData/*0:0*/ __Vtrigprevexpr___TOP__wb_clk__0;
    CData/*0:0*/ __VactContinue;
    VL_OUT(pc_adr,31,0);
    IData/*31:0*/ __VactIterCount;
    VlUnpacked<CData/*0:0*/, 3> __Vm_traceActivity;
    VlTriggerVec<1> __VstlTriggered;
    VlTriggerVec<1> __VicoTriggered;
    VlTriggerVec<1> __VactTriggered;
    VlTriggerVec<1> __VnbaTriggered;

    // INTERNAL VARIABLES
    Vservant_sim__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vservant_sim___024root(Vservant_sim__Syms* symsp, const char* v__name);
    ~Vservant_sim___024root();
    VL_UNCOPYABLE(Vservant_sim___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
