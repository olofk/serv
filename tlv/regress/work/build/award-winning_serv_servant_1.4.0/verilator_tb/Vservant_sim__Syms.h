// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef VERILATED_VSERVANT_SIM__SYMS_H_
#define VERILATED_VSERVANT_SIM__SYMS_H_  // guard

#include "verilated.h"

// INCLUDE MODEL CLASS

#include "Vservant_sim.h"

// INCLUDE MODULE CLASSES
#include "Vservant_sim___024root.h"
#include "Vservant_sim_servant_sim.h"
#include "Vservant_sim_servant__Mz1_Dz2_S1_Cz3_Az3.h"
#include "Vservant_sim_servant_ram__D2000_R4d494e49.h"

// DPI TYPES for DPI Export callbacks (Internal use)

// SYMS CLASS (contains all model state)
class alignas(VL_CACHE_LINE_BYTES) Vservant_sim__Syms final : public VerilatedSyms {
  public:
    // INTERNAL STATE
    Vservant_sim* const __Vm_modelp;
    bool __Vm_activity = false;  ///< Used by trace routines to determine change occurred
    uint32_t __Vm_baseCode = 0;  ///< Used by trace routines when tracing multiple models
    VlDeleter __Vm_deleter;
    bool __Vm_didInit = false;

    // MODULE INSTANCE STATE
    Vservant_sim___024root         TOP;
    Vservant_sim_servant_sim       TOP__servant_sim;
    Vservant_sim_servant__Mz1_Dz2_S1_Cz3_Az3 TOP__servant_sim__dut;
    Vservant_sim_servant_ram__D2000_R4d494e49 TOP__servant_sim__dut__ram;

    // SCOPE NAMES
    VerilatedScope __Vscope_servant_sim__dut__ram;

    // CONSTRUCTORS
    Vservant_sim__Syms(VerilatedContext* contextp, const char* namep, Vservant_sim* modelp);
    ~Vservant_sim__Syms();

    // METHODS
    const char* name() { return TOP.name(); }
};

#endif  // guard
