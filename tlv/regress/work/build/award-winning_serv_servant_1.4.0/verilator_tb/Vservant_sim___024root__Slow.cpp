// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vservant_sim.h for the primary calling header

#include "Vservant_sim__pch.h"

void Vservant_sim___024root___ctor_var_reset(Vservant_sim___024root* vlSelf);

Vservant_sim___024root::Vservant_sim___024root(Vservant_sim__Syms* symsp, const char* v__name)
    : VerilatedModule{v__name}
    , vlSymsp{symsp}
 {
    // Reset structure values
    Vservant_sim___024root___ctor_var_reset(this);
}

void Vservant_sim___024root::__Vconfigure(bool first) {
    (void)first;  // Prevent unused variable warning
}

Vservant_sim___024root::~Vservant_sim___024root() {
}
