// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table implementation internals

#include "Vservant_sim__pch.h"
#include "Vservant_sim.h"
#include "Vservant_sim___024root.h"
#include "Vservant_sim_servant_sim.h"
#include "Vservant_sim_servant__Mz1_Dz2_S1_Cz3_Az3.h"
#include "Vservant_sim_servant_ram__D2000_R4d494e49.h"

// FUNCTIONS
Vservant_sim__Syms::~Vservant_sim__Syms()
{
}

Vservant_sim__Syms::Vservant_sim__Syms(VerilatedContext* contextp, const char* namep, Vservant_sim* modelp)
    : VerilatedSyms{contextp}
    // Setup internal state of the Syms class
    , __Vm_modelp{modelp}
    // Setup module instances
    , TOP{this, namep}
    , TOP__servant_sim{this, Verilated::catName(namep, "servant_sim")}
    , TOP__servant_sim__dut{this, Verilated::catName(namep, "servant_sim.dut")}
    , TOP__servant_sim__dut__ram{this, Verilated::catName(namep, "servant_sim.dut.ram")}
{
    // Check resources
    Verilated::stackCheck(133);
    // Configure time unit / time precision
    _vm_contextp__->timeunit(-12);
    _vm_contextp__->timeprecision(-12);
    // Setup each module's pointers to their submodules
    TOP.servant_sim = &TOP__servant_sim;
    TOP__servant_sim.dut = &TOP__servant_sim__dut;
    TOP__servant_sim__dut.ram = &TOP__servant_sim__dut__ram;
    // Setup each module's pointer back to symbol table (for public functions)
    TOP.__Vconfigure(true);
    TOP__servant_sim.__Vconfigure(true);
    TOP__servant_sim__dut.__Vconfigure(true);
    TOP__servant_sim__dut__ram.__Vconfigure(true);
    // Setup scopes
    __Vscope_servant_sim__dut__ram.configure(this, name(), "servant_sim.dut.ram", "ram", "<null>", 0, VerilatedScope::SCOPE_OTHER);
    // Setup export functions
    for (int __Vfinal = 0; __Vfinal < 2; ++__Vfinal) {
        __Vscope_servant_sim__dut__ram.varInsert(__Vfinal,"mem", &(TOP__servant_sim__dut__ram.mem), false, VLVT_UINT32,VLVD_NODIR|VLVF_PUB_RW,1,1 ,0,2047 ,31,0);
    }
}
