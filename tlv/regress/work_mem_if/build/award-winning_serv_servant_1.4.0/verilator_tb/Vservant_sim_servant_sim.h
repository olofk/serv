// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vservant_sim.h for the primary calling header

#ifndef VERILATED_VSERVANT_SIM_SERVANT_SIM_H_
#define VERILATED_VSERVANT_SIM_SERVANT_SIM_H_  // guard

#include "verilated.h"
class Vservant_sim_servant__Mz1_Dz2_S1_Cz3_Az3;


class Vservant_sim__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vservant_sim_servant_sim final : public VerilatedModule {
  public:
    // CELLS
    Vservant_sim_servant__Mz1_Dz2_S1_Cz3_Az3* dut;

    // DESIGN SPECIFIC STATE
    VL_IN8(wb_clk,0,0);
    VL_IN8(wb_rst,0,0);
    VL_OUT8(pc_vld,0,0);
    VL_OUT8(q,0,0);
    VL_OUT(pc_adr,31,0);
    VlWide<32>/*1023:0*/ __PVT__firmware_file;

    // INTERNAL VARIABLES
    Vservant_sim__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vservant_sim_servant_sim(Vservant_sim__Syms* symsp, const char* v__name);
    ~Vservant_sim_servant_sim();
    VL_UNCOPYABLE(Vservant_sim_servant_sim);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
