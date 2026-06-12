// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vservant_sim.h for the primary calling header

#ifndef VERILATED_VSERVANT_SIM_SERVANT_RAM__D2000_R4D494E49_H_
#define VERILATED_VSERVANT_SIM_SERVANT_RAM__D2000_R4D494E49_H_  // guard

#include "verilated.h"


class Vservant_sim__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vservant_sim_servant_ram__D2000_R4d494e49 final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    VL_IN8(__PVT__i_wb_clk,0,0);
    VL_IN8(__PVT__i_wb_rst,0,0);
    VL_IN8(__PVT__i_wb_sel,3,0);
    VL_IN8(__PVT__i_wb_we,0,0);
    VL_IN8(__PVT__i_wb_cyc,0,0);
    VL_OUT8(__PVT__o_wb_ack,0,0);
    CData/*3:0*/ __PVT__we;
    VL_IN16(__PVT__i_wb_adr,12,2);
    VL_IN(__PVT__i_wb_dat,31,0);
    VL_OUT(__PVT__o_wb_rdt,31,0);
    VlUnpacked<IData/*31:0*/, 2048> mem;

    // INTERNAL VARIABLES
    Vservant_sim__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vservant_sim_servant_ram__D2000_R4d494e49(Vservant_sim__Syms* symsp, const char* v__name);
    ~Vservant_sim_servant_ram__D2000_R4d494e49();
    VL_UNCOPYABLE(Vservant_sim_servant_ram__D2000_R4d494e49);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
