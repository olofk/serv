// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vservant_sim__Syms.h"


VL_ATTR_COLD void Vservant_sim___024root__trace_init_sub__TOP__servant_sim__0(Vservant_sim___024root* vlSelf, VerilatedVcd* tracep);

VL_ATTR_COLD void Vservant_sim___024root__trace_init_sub__TOP__0(Vservant_sim___024root* vlSelf, VerilatedVcd* tracep) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vservant_sim___024root__trace_init_sub__TOP__0\n"); );
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    const int c = vlSymsp->__Vm_baseCode;
    tracep->pushPrefix("$rootio", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+391,0,"wb_clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+392,0,"wb_rst",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+393,0,"pc_adr",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+394,0,"pc_vld",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+395,0,"q",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->popPrefix();
    tracep->pushPrefix("servant_sim", VerilatedTracePrefixType::SCOPE_MODULE);
    Vservant_sim___024root__trace_init_sub__TOP__servant_sim__0(vlSelf, tracep);
    tracep->popPrefix();
}

VL_ATTR_COLD void Vservant_sim___024root__trace_init_sub__TOP__servant_sim__dut__0(Vservant_sim___024root* vlSelf, VerilatedVcd* tracep);

VL_ATTR_COLD void Vservant_sim___024root__trace_init_sub__TOP__servant_sim__0(Vservant_sim___024root* vlSelf, VerilatedVcd* tracep) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vservant_sim___024root__trace_init_sub__TOP__servant_sim__0\n"); );
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    const int c = vlSymsp->__Vm_baseCode;
    tracep->declBit(c+391,0,"wb_clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+392,0,"wb_rst",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+393,0,"pc_adr",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+76,0,"pc_vld",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+77,0,"q",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+397,0,"memfile",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+398,0,"memsize",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+399,0,"width",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+399,0,"with_csr",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+400,0,"compressed",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+400,0,"align",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declArray(c+1,0,"firmware_file",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 1023,0);
    tracep->pushPrefix("dut", VerilatedTracePrefixType::SCOPE_MODULE);
    Vservant_sim___024root__trace_init_sub__TOP__servant_sim__dut__0(vlSelf, tracep);
    tracep->popPrefix();
}

VL_ATTR_COLD void Vservant_sim___024root__trace_init_sub__TOP__servant_sim__dut__ram__0(Vservant_sim___024root* vlSelf, VerilatedVcd* tracep);

VL_ATTR_COLD void Vservant_sim___024root__trace_init_sub__TOP__servant_sim__dut__0(Vservant_sim___024root* vlSelf, VerilatedVcd* tracep) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vservant_sim___024root__trace_init_sub__TOP__servant_sim__dut__0\n"); );
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    const int c = vlSymsp->__Vm_baseCode;
    tracep->declBit(c+391,0,"wb_clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+392,0,"wb_rst",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+77,0,"q",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+397,0,"memfile",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+398,0,"memsize",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+401,0,"reset_strategy",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+399,0,"width",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+399,0,"sim",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+402,0,"debug",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+399,0,"with_csr",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+403,0,"compress",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+403,0,"align",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+403,0,"with_mdu",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+404,0,"aw",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+405,0,"csr_regs",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+406,0,"rf_width",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+407,0,"rf_l2d",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+78,0,"timer_irq",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+393,0,"wb_mem_adr",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+79,0,"wb_mem_dat",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+80,0,"wb_mem_sel",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBit(c+66,0,"wb_mem_we",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+67,0,"wb_mem_stb",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+81,0,"wb_mem_rdt",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+76,0,"wb_mem_ack",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+82,0,"wb_gpio_dat",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+83,0,"wb_gpio_we",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+84,0,"wb_gpio_stb",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+85,0,"wb_gpio_rdt",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+79,0,"wb_timer_dat",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+83,0,"wb_timer_we",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+86,0,"wb_timer_stb",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+87,0,"wb_timer_rdt",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+88,0,"wb_ext_adr",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+79,0,"wb_ext_dat",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+80,0,"wb_ext_sel",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBit(c+83,0,"wb_ext_we",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+89,0,"wb_ext_stb",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+90,0,"wb_ext_rdt",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+91,0,"wb_ext_ack",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+92,0,"rf_waddr",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 9,0);
    tracep->declBus(c+93,0,"rf_wdata",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBit(c+94,0,"rf_wen",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+95,0,"rf_raddr",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 9,0);
    tracep->declBit(c+96,0,"rf_ren",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+97,0,"rf_rdata",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->pushPrefix("ram", VerilatedTracePrefixType::SCOPE_MODULE);
    Vservant_sim___024root__trace_init_sub__TOP__servant_sim__dut__ram__0(vlSelf, tracep);
    tracep->popPrefix();
    tracep->pushPrefix("cpu", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+399,0,"width",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+408,0,"reset_pc",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+401,0,"reset_strategy",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+406,0,"rf_width",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+402,0,"sim",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+402,0,"debug",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+403,0,"with_c",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+402,0,"with_csr",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+403,0,"with_mdu",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+400,0,"B",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+409,0,"regs",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+407,0,"rf_l2d",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+391,0,"i_clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+392,0,"i_rst",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+78,0,"i_timer_irq",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+393,0,"o_wb_mem_adr",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+79,0,"o_wb_mem_dat",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+80,0,"o_wb_mem_sel",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBit(c+66,0,"o_wb_mem_we",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+67,0,"o_wb_mem_stb",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+81,0,"i_wb_mem_rdt",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+76,0,"i_wb_mem_ack",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+88,0,"o_wb_ext_adr",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+79,0,"o_wb_ext_dat",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+80,0,"o_wb_ext_sel",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBit(c+83,0,"o_wb_ext_we",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+89,0,"o_wb_ext_stb",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+90,0,"i_wb_ext_rdt",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+91,0,"i_wb_ext_ack",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+92,0,"o_rf_waddr",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 9,0);
    tracep->declBus(c+93,0,"o_rf_wdata",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBit(c+94,0,"o_rf_wen",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+95,0,"o_rf_raddr",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 9,0);
    tracep->declBus(c+97,0,"i_rf_rdata",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBit(c+96,0,"o_rf_ren",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+98,0,"wb_ibus_adr",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+68,0,"wb_ibus_stb",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+81,0,"wb_ibus_rdt",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+69,0,"wb_ibus_ack",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+88,0,"wb_dbus_adr",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+79,0,"wb_dbus_dat",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+80,0,"wb_dbus_sel",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBit(c+83,0,"wb_dbus_we",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+99,0,"wb_dbus_stb",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+100,0,"wb_dbus_rdt",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+70,0,"wb_dbus_ack",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+88,0,"wb_dmem_adr",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+79,0,"wb_dmem_dat",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+80,0,"wb_dmem_sel",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBit(c+83,0,"wb_dmem_we",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+101,0,"wb_dmem_stb",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+81,0,"wb_dmem_rdt",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+71,0,"wb_dmem_ack",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+72,0,"rf_wreq",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+73,0,"rf_rreq",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+102,0,"wreg0",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 5,0);
    tracep->declBus(c+103,0,"wreg1",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 5,0);
    tracep->declBit(c+104,0,"wen0",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+105,0,"wen1",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+106,0,"wdata0",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+107,0,"wdata1",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+108,0,"rreg0",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 5,0);
    tracep->declBus(c+109,0,"rreg1",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 5,0);
    tracep->declBit(c+74,0,"rf_ready",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+110,0,"rdata0",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+111,0,"rdata1",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+112,0,"mdu_rs1",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+79,0,"mdu_rs2",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+113,0,"mdu_op",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBit(c+410,0,"mdu_valid",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+408,0,"mdu_rd",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+410,0,"mdu_ready",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->pushPrefix("arbiter", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+88,0,"i_wb_cpu_dbus_adr",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+79,0,"i_wb_cpu_dbus_dat",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+80,0,"i_wb_cpu_dbus_sel",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBit(c+83,0,"i_wb_cpu_dbus_we",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+101,0,"i_wb_cpu_dbus_stb",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+81,0,"o_wb_cpu_dbus_rdt",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+71,0,"o_wb_cpu_dbus_ack",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+98,0,"i_wb_cpu_ibus_adr",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+68,0,"i_wb_cpu_ibus_stb",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+81,0,"o_wb_cpu_ibus_rdt",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+69,0,"o_wb_cpu_ibus_ack",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+393,0,"o_wb_mem_adr",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+79,0,"o_wb_mem_dat",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+80,0,"o_wb_mem_sel",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBit(c+66,0,"o_wb_mem_we",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+67,0,"o_wb_mem_stb",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+81,0,"i_wb_mem_rdt",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+76,0,"i_wb_mem_ack",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->popPrefix();
    tracep->pushPrefix("cpu", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+399,0,"WITH_CSR",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+399,0,"W",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+400,0,"B",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+402,0,"PRE_REGISTER",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+401,0,"RESET_STRATEGY",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+408,0,"RESET_PC",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+402,0,"DEBUG",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+403,0,"MDU",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+403,0,"COMPRESSED",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+403,0,"ALIGN",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBit(c+391,0,"clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+392,0,"i_rst",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+78,0,"i_timer_irq",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+73,0,"o_rf_rreq",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+72,0,"o_rf_wreq",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+74,0,"i_rf_ready",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+102,0,"o_wreg0",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 5,0);
    tracep->declBus(c+103,0,"o_wreg1",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 5,0);
    tracep->declBit(c+104,0,"o_wen0",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+105,0,"o_wen1",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+106,0,"o_wdata0",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+107,0,"o_wdata1",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+108,0,"o_rreg0",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 5,0);
    tracep->declBus(c+109,0,"o_rreg1",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 5,0);
    tracep->declBus(c+110,0,"i_rdata0",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+111,0,"i_rdata1",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+98,0,"o_ibus_adr",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+68,0,"o_ibus_cyc",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+81,0,"i_ibus_rdt",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+69,0,"i_ibus_ack",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+88,0,"o_dbus_adr",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+79,0,"o_dbus_dat",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+80,0,"o_dbus_sel",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBit(c+83,0,"o_dbus_we",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+99,0,"o_dbus_cyc",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+100,0,"i_dbus_rdt",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+70,0,"i_dbus_ack",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+113,0,"o_ext_funct3",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBit(c+410,0,"i_ext_ready",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+408,0,"i_ext_rd",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+112,0,"o_ext_rs1",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+79,0,"o_ext_rs2",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+410,0,"o_mdu_valid",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+114,0,"rd_addr",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+115,0,"rs1_addr",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+116,0,"rs2_addr",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+117,0,"immdec_ctrl",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBus(c+118,0,"immdec_en",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBit(c+119,0,"sh_right",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+120,0,"bne_or_bge",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+121,0,"cond_branch",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+122,0,"two_stage_op",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+123,0,"e_op",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+124,0,"ebreak",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+125,0,"branch_op",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+126,0,"shift_op",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+127,0,"rd_op",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+410,0,"mdu_op",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+128,0,"rd_alu_en",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+129,0,"rd_csr_en",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+130,0,"rd_mem_en",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+131,0,"ctrl_rd",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+132,0,"alu_rd",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+133,0,"mem_rd",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+134,0,"csr_rd",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBit(c+125,0,"mtval_pc",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+135,0,"ctrl_pc_en",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+136,0,"jump",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+137,0,"jal_or_jalr",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+138,0,"utype",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+139,0,"mret",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+140,0,"imm",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBit(c+141,0,"trap",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+142,0,"pc_rel",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+410,0,"iscomp",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+143,0,"init",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+144,0,"cnt_en",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+145,0,"cnt0to3",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+146,0,"cnt12to31",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+147,0,"cnt0",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+148,0,"cnt1",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+149,0,"cnt2",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+150,0,"cnt3",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+151,0,"cnt7",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+152,0,"cnt11",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+153,0,"cnt12",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+154,0,"cnt_done",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+155,0,"bufreg_en",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+156,0,"bufreg_sh_signed",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+157,0,"bufreg_rs1_en",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+158,0,"bufreg_imm_en",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+159,0,"bufreg_clr_lsb",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+160,0,"bufreg_q",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+161,0,"bufreg2_q",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+100,0,"dbus_rdt",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+70,0,"dbus_ack",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+162,0,"alu_sub",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+163,0,"alu_bool_op",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBit(c+164,0,"alu_cmp_eq",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+165,0,"alu_cmp_sig",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+166,0,"alu_cmp",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+167,0,"alu_rd_sel",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+110,0,"rs1",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+111,0,"rs2",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBit(c+168,0,"rd_en",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+169,0,"op_b",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBit(c+83,0,"op_b_sel",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+170,0,"mem_signed",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+171,0,"mem_word",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+120,0,"mem_half",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+172,0,"mem_bytecnt",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBit(c+173,0,"sh_done",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+174,0,"mem_misalign",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+175,0,"bad_pc",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBit(c+176,0,"csr_mstatus_en",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+177,0,"csr_mie_en",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+178,0,"csr_mcause_en",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+163,0,"csr_source",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBus(c+179,0,"csr_imm",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBit(c+119,0,"csr_d_sel",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+180,0,"csr_en",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+181,0,"csr_addr",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBus(c+111,0,"csr_pc",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBit(c+182,0,"csr_imm_en",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+183,0,"csr_in",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+184,0,"rf_csr_out",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBit(c+185,0,"dbus_en",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+186,0,"new_irq",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+187,0,"lsb",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBus(c+81,0,"i_wb_rdt",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+98,0,"wb_ibus_adr",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+68,0,"wb_ibus_cyc",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+81,0,"wb_ibus_rdt",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+69,0,"wb_ibus_ack",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->pushPrefix("alu", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+399,0,"W",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+400,0,"B",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+391,0,"clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+144,0,"i_en",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+147,0,"i_cnt0",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+166,0,"o_cmp",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+162,0,"i_sub",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+163,0,"i_bool_op",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBit(c+164,0,"i_cmp_eq",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+165,0,"i_cmp_sig",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+167,0,"i_rd_sel",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+110,0,"i_rs1",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+169,0,"i_op_b",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+160,0,"i_buf",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+132,0,"o_rd",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+188,0,"result_add",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+189,0,"result_slt",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBit(c+190,0,"cmp_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+191,0,"add_cy",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+192,0,"add_cy_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBit(c+193,0,"rs1_sx",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+194,0,"op_b_sx",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+195,0,"add_b",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBit(c+196,0,"result_lt",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+197,0,"result_eq",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+198,0,"result_bool",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->popPrefix();
    tracep->pushPrefix("bufreg", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+403,0,"MDU",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+399,0,"W",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+400,0,"B",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+391,0,"i_clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+147,0,"i_cnt0",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+148,0,"i_cnt1",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+154,0,"i_cnt_done",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+155,0,"i_en",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+143,0,"i_init",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+410,0,"i_mdu_op",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+187,0,"o_lsb",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBit(c+157,0,"i_rs1_en",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+158,0,"i_imm_en",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+159,0,"i_clr_lsb",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+126,0,"i_shift_op",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+119,0,"i_right_shift_op",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+199,0,"i_shamt",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBit(c+156,0,"i_sh_signed",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+110,0,"i_rs1",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+140,0,"i_imm",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+160,0,"o_q",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+88,0,"o_dbus_adr",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+112,0,"o_ext_rs1",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+391,0,"clk",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+200,0,"L0_c_a0",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+201,0,"L0_c_r_a0",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+202,0,"L0_carry_and_sum_a0",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBus(c+203,0,"L0_clr_lsb_a0",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBit(c+204,0,"L0_cr_in_a0",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+201,0,"L0_cr_in_a1",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+205,0,"L0_data_a0",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+112,0,"L0_data_a1",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+206,0,"L0_data_tail_a0",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+207,0,"L0_data_tail_a1",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+205,0,"L0_data_w1_a0",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+208,0,"L0_data_w4_a0",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+209,0,"L0_lsb_a0",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBus(c+210,0,"L0_lsb_a1",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBus(c+187,0,"L0_lsb_w_eq_1_a0",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBus(c+211,0,"L0_muxdata_a0",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 9,0);
    tracep->declBus(c+212,0,"L0_muxout_a0",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+187,0,"L0_o_lsb_a0",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBus(c+160,0,"L0_o_q_a0",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+213,0,"L0_q_a0",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBit(c+160,0,"L0_qq_w_eq_1_a0",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+214,0,"L0_qq_w_eq_4_a0",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+215,0,"L0_shift_amount_a0",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->popPrefix();
    tracep->pushPrefix("bufreg2", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+399,0,"W",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+400,0,"B",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+391,0,"i_clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+144,0,"i_en",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+143,0,"i_init",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+151,0,"i_cnt7",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+154,0,"i_cnt_done",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+119,0,"i_sh_right",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+187,0,"i_lsb",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBus(c+172,0,"i_bytecnt",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBit(c+173,0,"o_sh_done",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+83,0,"i_op_b_sel",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+126,0,"i_shift_op",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+111,0,"i_rs2",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+140,0,"i_imm",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+169,0,"o_op_b",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+161,0,"o_q",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+79,0,"o_dat",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+70,0,"i_load",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+100,0,"i_dat",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+216,0,"dhi",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+217,0,"dlo",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 23,0);
    tracep->declBit(c+218,0,"byte_valid",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+219,0,"shift_en",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+220,0,"cnt_en",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+221,0,"cnt_next",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+222,0,"dat_shamt",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->popPrefix();
    tracep->pushPrefix("ctrl", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+401,0,"RESET_STRATEGY",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+408,0,"RESET_PC",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+399,0,"WITH_CSR",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+399,0,"W",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+400,0,"B",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+391,0,"clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+392,0,"i_rst",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+135,0,"i_pc_en",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+146,0,"i_cnt12to31",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+147,0,"i_cnt0",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+148,0,"i_cnt1",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+149,0,"i_cnt2",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+136,0,"i_jump",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+137,0,"i_jal_or_jalr",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+138,0,"i_utype",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+142,0,"i_pc_rel",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+223,0,"i_trap",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+410,0,"i_iscomp",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+140,0,"i_imm",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+160,0,"i_buf",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+111,0,"i_csr_pc",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+131,0,"o_rd",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+175,0,"o_bad_pc",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+98,0,"o_ibus_adr",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+224,0,"pc_plus_4",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBit(c+225,0,"pc_plus_4_cy",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+226,0,"pc_plus_4_cy_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+226,0,"pc_plus_4_cy_r_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+227,0,"pc_plus_offset",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBit(c+228,0,"pc_plus_offset_cy",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+229,0,"pc_plus_offset_cy_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+229,0,"pc_plus_offset_cy_r_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+175,0,"pc_plus_offset_aligned",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+149,0,"plus_4",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+230,0,"pc",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+231,0,"new_pc",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+232,0,"offset_a",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+233,0,"offset_b",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->popPrefix();
    tracep->pushPrefix("decode", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+402,0,"PRE_REGISTER",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+403,0,"MDU",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBit(c+391,0,"clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+234,0,"i_wb_rdt",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,2);
    tracep->declBit(c+69,0,"i_wb_en",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+119,0,"o_sh_right",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+120,0,"o_bne_or_bge",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+121,0,"o_cond_branch",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+123,0,"o_e_op",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+124,0,"o_ebreak",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+125,0,"o_branch_op",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+126,0,"o_shift_op",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+127,0,"o_rd_op",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+122,0,"o_two_stage_op",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+185,0,"o_dbus_en",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+410,0,"o_mdu_op",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+113,0,"o_ext_funct3",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBit(c+157,0,"o_bufreg_rs1_en",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+158,0,"o_bufreg_imm_en",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+159,0,"o_bufreg_clr_lsb",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+156,0,"o_bufreg_sh_signed",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+137,0,"o_ctrl_jal_or_jalr",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+138,0,"o_ctrl_utype",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+142,0,"o_ctrl_pc_rel",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+139,0,"o_ctrl_mret",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+162,0,"o_alu_sub",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+163,0,"o_alu_bool_op",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBit(c+164,0,"o_alu_cmp_eq",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+165,0,"o_alu_cmp_sig",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+167,0,"o_alu_rd_sel",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBit(c+170,0,"o_mem_signed",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+171,0,"o_mem_word",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+120,0,"o_mem_half",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+83,0,"o_mem_cmd",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+180,0,"o_csr_en",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+181,0,"o_csr_addr",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBit(c+176,0,"o_csr_mstatus_en",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+177,0,"o_csr_mie_en",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+178,0,"o_csr_mcause_en",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+163,0,"o_csr_source",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBit(c+119,0,"o_csr_d_sel",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+182,0,"o_csr_imm_en",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+125,0,"o_mtval_pc",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+117,0,"o_immdec_ctrl",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBus(c+118,0,"o_immdec_en",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBit(c+83,0,"o_op_b_source",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+130,0,"o_rd_mem_en",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+129,0,"o_rd_csr_en",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+128,0,"o_rd_alu_en",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+235,0,"opcode",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+113,0,"funct3",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBit(c+124,0,"op20",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+236,0,"op21",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+237,0,"op22",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+238,0,"op26",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+239,0,"imm25",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+156,0,"imm30",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+410,0,"co_mdu_op",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+122,0,"co_two_stage_op",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+126,0,"co_shift_op",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+125,0,"co_branch_op",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+185,0,"co_dbus_en",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+125,0,"co_mtval_pc",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+171,0,"co_mem_word",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+128,0,"co_rd_alu_en",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+130,0,"co_rd_mem_en",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+113,0,"co_ext_funct3",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBit(c+157,0,"co_bufreg_rs1_en",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+158,0,"co_bufreg_imm_en",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+159,0,"co_bufreg_clr_lsb",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+121,0,"co_cond_branch",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+138,0,"co_ctrl_utype",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+137,0,"co_ctrl_jal_or_jalr",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+142,0,"co_ctrl_pc_rel",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+127,0,"co_rd_op",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+119,0,"co_sh_right",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+120,0,"co_bne_or_bge",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+129,0,"csr_op",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+124,0,"co_ebreak",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+139,0,"co_ctrl_mret",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+123,0,"co_e_op",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+156,0,"co_bufreg_sh_signed",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+162,0,"co_alu_sub",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+240,0,"csr_valid",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+129,0,"co_rd_csr_en",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+180,0,"co_csr_en",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+176,0,"co_csr_mstatus_en",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+177,0,"co_csr_mie_en",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+178,0,"co_csr_mcause_en",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+163,0,"co_csr_source",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBit(c+119,0,"co_csr_d_sel",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+182,0,"co_csr_imm_en",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+181,0,"co_csr_addr",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBit(c+164,0,"co_alu_cmp_eq",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+165,0,"co_alu_cmp_sig",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+83,0,"co_mem_cmd",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+170,0,"co_mem_signed",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+120,0,"co_mem_half",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+163,0,"co_alu_bool_op",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBus(c+117,0,"co_immdec_ctrl",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBus(c+118,0,"co_immdec_en",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBus(c+167,0,"co_alu_rd_sel",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBit(c+83,0,"co_op_b_source",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->popPrefix();
    tracep->pushPrefix("gen_csr", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->pushPrefix("csr", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+401,0,"RESET_STRATEGY",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+399,0,"W",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+400,0,"B",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+391,0,"i_clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+392,0,"i_rst",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+69,0,"i_trig_irq",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+144,0,"i_en",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+145,0,"i_cnt0to3",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+150,0,"i_cnt3",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+151,0,"i_cnt7",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+152,0,"i_cnt11",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+153,0,"i_cnt12",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+154,0,"i_cnt_done",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+241,0,"i_mem_op",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+78,0,"i_mtip",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+141,0,"i_trap",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+186,0,"o_new_irq",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+123,0,"i_e_op",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+124,0,"i_ebreak",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+83,0,"i_mem_cmd",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+176,0,"i_mstatus_en",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+177,0,"i_mie_en",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+178,0,"i_mcause_en",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+163,0,"i_csr_source",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBit(c+139,0,"i_mret",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+119,0,"i_csr_d_sel",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+184,0,"i_rf_csr_out",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+183,0,"o_csr_in",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+179,0,"i_csr_imm",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+110,0,"i_rs1",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+134,0,"o_q",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+411,0,"CSR_SOURCE_CSR",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBus(c+412,0,"CSR_SOURCE_EXT",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBus(c+413,0,"CSR_SOURCE_SET",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBus(c+414,0,"CSR_SOURCE_CLR",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBit(c+242,0,"mstatus_mie",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+243,0,"mstatus_mpie",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+244,0,"mie_mtie",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+245,0,"mcause31",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+246,0,"mcause3_0",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBus(c+247,0,"mcause",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+183,0,"csr_in",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+134,0,"csr_out",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBit(c+248,0,"timer_irq_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+249,0,"d",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+250,0,"mstatus",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBit(c+251,0,"timer_irq",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->popPrefix();
    tracep->popPrefix();
    tracep->pushPrefix("gen_debug", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->pushPrefix("debug", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+399,0,"W",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+408,0,"RESET_PC",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+400,0,"B",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+391,0,"i_clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+392,0,"i_rst",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+81,0,"i_ibus_rdt",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+69,0,"i_ibus_ack",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+114,0,"i_rd_addr",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBit(c+144,0,"i_cnt_en",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+183,0,"i_csr_in",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBit(c+176,0,"i_csr_mstatus_en",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+177,0,"i_csr_mie_en",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+178,0,"i_csr_mcause_en",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+180,0,"i_csr_en",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+181,0,"i_csr_addr",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBit(c+104,0,"i_wen0",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+106,0,"i_wdata0",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBit(c+154,0,"i_cnt_done",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+252,0,"update_rd",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+253,0,"update_mscratch",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+254,0,"update_mtvec",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+255,0,"update_mepc",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+256,0,"update_mtval",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+257,0,"update_mstatus",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+258,0,"update_mie",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+259,0,"update_mcause",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+260,0,"dbg_rd",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+261,0,"dbg_csr",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+262,0,"dbg_mstatus",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+263,0,"dbg_mie",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+264,0,"dbg_mcause",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+265,0,"dbg_mscratch",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+266,0,"dbg_mtvec",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+267,0,"dbg_mepc",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+268,0,"dbg_mtval",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+269,0,"x1",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+270,0,"x2",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+271,0,"x3",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+272,0,"x4",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+273,0,"x5",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+274,0,"x6",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+275,0,"x7",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+276,0,"x8",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+277,0,"x9",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+278,0,"x10",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+279,0,"x11",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+280,0,"x12",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+281,0,"x13",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+282,0,"x14",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+283,0,"x15",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+284,0,"x16",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+285,0,"x17",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+286,0,"x18",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+287,0,"x19",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+288,0,"x20",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+289,0,"x21",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+290,0,"x22",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+291,0,"x23",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+292,0,"x24",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+293,0,"x25",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+294,0,"x26",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+295,0,"x27",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+296,0,"x28",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+297,0,"x29",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+298,0,"x30",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+299,0,"x31",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+300,0,"LUI",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+301,0,"AUIPC",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+302,0,"JAL",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+303,0,"JALR",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+304,0,"BEQ",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+305,0,"BNE",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+306,0,"BLT",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+307,0,"BGE",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+308,0,"BLTU",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+309,0,"BGEU",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+310,0,"LB",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+311,0,"LH",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+312,0,"LW",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+313,0,"LBU",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+314,0,"LHU",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+315,0,"SB",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+316,0,"SH",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+317,0,"SW",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+318,0,"ADDI",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+319,0,"SLTI",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+320,0,"SLTIU",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+321,0,"XORI",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+322,0,"ORI",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+323,0,"ANDI",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+324,0,"SLLI",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+325,0,"SRLI",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+326,0,"SRAI",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+327,0,"ADD",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+328,0,"SUB",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+329,0,"SLL",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+330,0,"SLT",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+331,0,"SLTU",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+332,0,"XOR",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+333,0,"SRL",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+334,0,"SRA",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+335,0,"OR",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+336,0,"AND",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+337,0,"FENCE",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+338,0,"ECALL",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+339,0,"EBREAK",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+340,0,"CSRRW",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+341,0,"CSRRS",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+342,0,"CSRRC",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+343,0,"CSRRWI",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+344,0,"CSRRSI",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+345,0,"CSRRCI",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+346,0,"OTHER",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->popPrefix();
    tracep->popPrefix();
    tracep->pushPrefix("immdec", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+399,0,"SHARED_RFADDR_IMM_REGS",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+399,0,"W",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+391,0,"i_clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+144,0,"i_cnt_en",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+154,0,"i_cnt_done",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+118,0,"i_immdec_en",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBit(c+182,0,"i_csr_imm_en",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+117,0,"i_ctrl",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBus(c+114,0,"o_rd_addr",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+115,0,"o_rs1_addr",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+116,0,"o_rs2_addr",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+179,0,"o_csr_imm",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+140,0,"o_imm",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBit(c+69,0,"i_wb_en",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+347,0,"i_wb_rdt",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,7);
    tracep->pushPrefix("gen_immdec_w_eq_1", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+348,0,"imm31",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+349,0,"imm19_12_20",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 8,0);
    tracep->declBit(c+350,0,"imm7",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+351,0,"imm30_25",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 5,0);
    tracep->declBus(c+116,0,"imm24_20",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+114,0,"imm11_7",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBit(c+352,0,"signbit",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->popPrefix();
    tracep->popPrefix();
    tracep->pushPrefix("mem_if", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+402,0,"WITH_CSR",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+399,0,"W",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+400,0,"B",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+391,0,"i_clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+172,0,"i_bytecnt",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBus(c+187,0,"i_lsb",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBit(c+174,0,"o_misalign",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+170,0,"i_signed",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+171,0,"i_word",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+120,0,"i_half",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+410,0,"i_mdu_op",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+161,0,"i_bufreg2_q",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+133,0,"o_rd",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+80,0,"o_wb_sel",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBit(c+353,0,"signbit",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+354,0,"dat_valid",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->popPrefix();
    tracep->pushPrefix("rf_if", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+399,0,"WITH_CSR",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+399,0,"W",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+400,0,"B",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+144,0,"i_cnt_en",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+102,0,"o_wreg0",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 5,0);
    tracep->declBus(c+103,0,"o_wreg1",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 5,0);
    tracep->declBit(c+104,0,"o_wen0",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+105,0,"o_wen1",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+106,0,"o_wdata0",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+107,0,"o_wdata1",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+108,0,"o_rreg0",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 5,0);
    tracep->declBus(c+109,0,"o_rreg1",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 5,0);
    tracep->declBus(c+110,0,"i_rdata0",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+111,0,"i_rdata1",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBit(c+141,0,"i_trap",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+139,0,"i_mret",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+230,0,"i_mepc",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBit(c+125,0,"i_mtval_pc",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+160,0,"i_bufreg_q",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+175,0,"i_bad_pc",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+111,0,"o_csr_pc",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBit(c+180,0,"i_csr_en",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+181,0,"i_csr_addr",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBus(c+183,0,"i_csr",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+184,0,"o_csr",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBit(c+168,0,"i_rd_wen",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+114,0,"i_rd_waddr",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+131,0,"i_ctrl_rd",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+132,0,"i_alu_rd",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBit(c+128,0,"i_rd_alu_en",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+134,0,"i_csr_rd",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBit(c+129,0,"i_rd_csr_en",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+133,0,"i_mem_rd",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBit(c+130,0,"i_rd_mem_en",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+115,0,"i_rs1_raddr",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+110,0,"o_rs1",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+116,0,"i_rs2_raddr",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+111,0,"o_rs2",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBit(c+355,0,"rd_wen",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->pushPrefix("gen_csr", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+356,0,"rd",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+357,0,"mtval",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBit(c+358,0,"sel_rs2",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->popPrefix();
    tracep->popPrefix();
    tracep->pushPrefix("state", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+401,0,"RESET_STRATEGY",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+402,0,"WITH_CSR",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+403,0,"ALIGN",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+403,0,"MDU",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+399,0,"W",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+391,0,"i_clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+392,0,"i_rst",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+186,0,"i_new_irq",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+166,0,"i_alu_cmp",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+143,0,"o_init",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+144,0,"o_cnt_en",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+145,0,"o_cnt0to3",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+146,0,"o_cnt12to31",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+147,0,"o_cnt0",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+148,0,"o_cnt1",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+149,0,"o_cnt2",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+150,0,"o_cnt3",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+151,0,"o_cnt7",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+152,0,"o_cnt11",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+153,0,"o_cnt12",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+154,0,"o_cnt_done",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+155,0,"o_bufreg_en",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+135,0,"o_ctrl_pc_en",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+136,0,"o_ctrl_jump",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+141,0,"o_ctrl_trap",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+359,0,"i_ctrl_misalign",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+173,0,"i_sh_done",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+172,0,"o_mem_bytecnt",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBit(c+174,0,"i_mem_misalign",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+120,0,"i_bne_or_bge",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+121,0,"i_cond_branch",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+185,0,"i_dbus_en",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+122,0,"i_two_stage_op",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+125,0,"i_branch_op",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+126,0,"i_shift_op",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+119,0,"i_sh_right",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+360,0,"i_alu_rd_sel1",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+128,0,"i_rd_alu_en",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+123,0,"i_e_op",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+127,0,"i_rd_op",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+410,0,"i_mdu_op",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+410,0,"o_mdu_valid",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+410,0,"i_mdu_ready",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+99,0,"o_dbus_cyc",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+70,0,"i_dbus_ack",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+68,0,"o_ibus_cyc",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+69,0,"i_ibus_ack",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+73,0,"o_rf_rreq",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+72,0,"o_rf_wreq",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+74,0,"i_rf_ready",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+168,0,"o_rf_rd_en",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+361,0,"init_done",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+362,0,"misalign_trap_sync",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+363,0,"o_cnt",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 4,2);
    tracep->declBus(c+364,0,"cnt_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBit(c+365,0,"ibus_cyc",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+366,0,"take_branch",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+367,0,"last_init",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+368,0,"trap_pending",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->pushPrefix("gen_cnt_w_eq_1", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+364,0,"cnt_lsb",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->popPrefix();
    tracep->pushPrefix("gen_csr", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+362,0,"misalign_trap_sync_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->popPrefix();
    tracep->popPrefix();
    tracep->popPrefix();
    tracep->pushPrefix("mux", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+402,0,"sim",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+415,0,"sim_sig_adr",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+416,0,"sim_halt_adr",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+391,0,"i_clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+392,0,"i_rst",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+88,0,"i_wb_cpu_adr",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+79,0,"i_wb_cpu_dat",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+80,0,"i_wb_cpu_sel",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBit(c+83,0,"i_wb_cpu_we",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+99,0,"i_wb_cpu_stb",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+100,0,"o_wb_cpu_rdt",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+70,0,"o_wb_cpu_ack",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+88,0,"o_wb_mem_adr",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+79,0,"o_wb_mem_dat",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+80,0,"o_wb_mem_sel",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBit(c+83,0,"o_wb_mem_we",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+101,0,"o_wb_mem_stb",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+81,0,"i_wb_mem_rdt",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+71,0,"i_wb_mem_ack",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+88,0,"o_wb_ext_adr",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+79,0,"o_wb_ext_dat",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+80,0,"o_wb_ext_sel",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBit(c+83,0,"o_wb_ext_we",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+89,0,"o_wb_ext_stb",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+90,0,"i_wb_ext_rdt",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+91,0,"i_wb_ext_ack",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+369,0,"sig_en",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+370,0,"halt_en",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+371,0,"sim_ack",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+372,0,"ext",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->pushPrefix("genblk1", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+33,0,"f",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::INTEGER, false,-1, 31,0);
    tracep->declArray(c+34,0,"signature_file",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 1023,0);
    tracep->popPrefix();
    tracep->popPrefix();
    tracep->pushPrefix("rf_ram_if", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+406,0,"width",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+399,0,"W",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+401,0,"reset_strategy",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+417,0,"csr_regs",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+400,0,"B",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+418,0,"raw",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+399,0,"l2w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+407,0,"aw",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+391,0,"i_clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+392,0,"i_rst",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+72,0,"i_wreq",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+73,0,"i_rreq",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+74,0,"o_ready",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+102,0,"i_wreg0",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 5,0);
    tracep->declBus(c+103,0,"i_wreg1",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 5,0);
    tracep->declBit(c+104,0,"i_wen0",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+105,0,"i_wen1",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+106,0,"i_wdata0",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+107,0,"i_wdata1",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+108,0,"i_rreg0",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 5,0);
    tracep->declBus(c+109,0,"i_rreg1",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 5,0);
    tracep->declBus(c+110,0,"o_rdata0",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+111,0,"o_rdata1",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBus(c+92,0,"o_waddr",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 9,0);
    tracep->declBus(c+93,0,"o_wdata",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBit(c+94,0,"o_wen",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+95,0,"o_raddr",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 9,0);
    tracep->declBit(c+96,0,"o_ren",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+97,0,"i_rdata",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBus(c+406,0,"ratio",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+405,0,"CMSB",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+399,0,"l2r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+373,0,"rgnt",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+374,0,"rcnt",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBit(c+375,0,"rtrig1",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+376,0,"wcnt",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+377,0,"wdata0_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBus(c+378,0,"wdata1_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBit(c+379,0,"wen0_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+380,0,"wen1_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+375,0,"wtrig0",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+381,0,"wtrig1",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+382,0,"wreg",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 5,0);
    tracep->declBit(c+381,0,"rtrig0",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+383,0,"rreg",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 5,0);
    tracep->declBus(c+384,0,"rdata0",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBus(c+385,0,"rdata1",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 0,0);
    tracep->declBit(c+96,0,"rgate",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+386,0,"rreq_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->popPrefix();
    tracep->popPrefix();
    tracep->pushPrefix("gpio", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+391,0,"i_wb_clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+82,0,"i_wb_dat",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+83,0,"i_wb_we",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+84,0,"i_wb_cyc",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+85,0,"o_wb_rdt",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+77,0,"o_gpio",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->popPrefix();
    tracep->pushPrefix("rf_ram", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+406,0,"width",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+405,0,"csr_regs",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+419,0,"depth",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+391,0,"i_clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+92,0,"i_waddr",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 9,0);
    tracep->declBus(c+93,0,"i_wdata",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBit(c+94,0,"i_wen",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+95,0,"i_raddr",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 9,0);
    tracep->declBit(c+96,0,"i_ren",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+97,0,"o_rdata",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBus(c+387,0,"rdata",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBit(c+388,0,"regzero",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->popPrefix();
    tracep->pushPrefix("servant_mux", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+391,0,"i_clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+392,0,"i_rst",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+88,0,"i_wb_cpu_adr",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+79,0,"i_wb_cpu_dat",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+80,0,"i_wb_cpu_sel",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBit(c+83,0,"i_wb_cpu_we",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+89,0,"i_wb_cpu_cyc",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+90,0,"o_wb_cpu_rdt",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+91,0,"o_wb_cpu_ack",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+82,0,"o_wb_gpio_dat",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+83,0,"o_wb_gpio_we",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+84,0,"o_wb_gpio_cyc",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+85,0,"i_wb_gpio_rdt",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+79,0,"o_wb_timer_dat",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+83,0,"o_wb_timer_we",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+86,0,"o_wb_timer_cyc",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+87,0,"i_wb_timer_rdt",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+400,0,"sim",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+389,0,"s",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->popPrefix();
    tracep->pushPrefix("timer", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+420,0,"WIDTH",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+401,0,"RESET_STRATEGY",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+400,0,"DIVIDER",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+391,0,"i_clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+392,0,"i_rst",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+78,0,"o_irq",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+79,0,"i_wb_dat",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+83,0,"i_wb_we",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+86,0,"i_wb_cyc",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+87,0,"o_wb_dat",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+421,0,"HIGH",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+87,0,"mtime",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+390,0,"mtimecmp",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+87,0,"mtimeslice",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->popPrefix();
}

VL_ATTR_COLD void Vservant_sim___024root__trace_init_sub__TOP__servant_sim__dut__ram__0(Vservant_sim___024root* vlSelf, VerilatedVcd* tracep) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vservant_sim___024root__trace_init_sub__TOP__servant_sim__dut__ram__0\n"); );
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    const int c = vlSymsp->__Vm_baseCode;
    tracep->declBus(c+398,0,"depth",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+404,0,"aw",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+401,0,"RESET_STRATEGY",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+397,0,"memfile",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBit(c+391,0,"i_wb_clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+392,0,"i_wb_rst",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+396,0,"i_wb_adr",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 12,2);
    tracep->declBus(c+79,0,"i_wb_dat",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+80,0,"i_wb_sel",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBit(c+66,0,"i_wb_we",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+67,0,"i_wb_cyc",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+81,0,"o_wb_rdt",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+76,0,"o_wb_ack",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+75,0,"we",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBus(c+396,0,"addr",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 10,0);
}

VL_ATTR_COLD void Vservant_sim___024root__trace_init_top(Vservant_sim___024root* vlSelf, VerilatedVcd* tracep) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vservant_sim___024root__trace_init_top\n"); );
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    Vservant_sim___024root__trace_init_sub__TOP__0(vlSelf, tracep);
}

VL_ATTR_COLD void Vservant_sim___024root__trace_const_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
VL_ATTR_COLD void Vservant_sim___024root__trace_full_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void Vservant_sim___024root__trace_chg_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void Vservant_sim___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/);

VL_ATTR_COLD void Vservant_sim___024root__trace_register(Vservant_sim___024root* vlSelf, VerilatedVcd* tracep) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vservant_sim___024root__trace_register\n"); );
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    tracep->addConstCb(&Vservant_sim___024root__trace_const_0, 0, vlSelf);
    tracep->addFullCb(&Vservant_sim___024root__trace_full_0, 0, vlSelf);
    tracep->addChgCb(&Vservant_sim___024root__trace_chg_0, 0, vlSelf);
    tracep->addCleanupCb(&Vservant_sim___024root__trace_cleanup, vlSelf);
}

VL_ATTR_COLD void Vservant_sim___024root__trace_const_0_sub_0(Vservant_sim___024root* vlSelf, VerilatedVcd::Buffer* bufp);

VL_ATTR_COLD void Vservant_sim___024root__trace_const_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vservant_sim___024root__trace_const_0\n"); );
    // Body
    Vservant_sim___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vservant_sim___024root*>(voidSelf);
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    Vservant_sim___024root__trace_const_0_sub_0((&vlSymsp->TOP), bufp);
}

VL_ATTR_COLD void Vservant_sim___024root__trace_const_0_sub_0(Vservant_sim___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vservant_sim___024root__trace_const_0_sub_0\n"); );
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode);
    bufp->fullCData(oldp+397,(0U),8);
    bufp->fullIData(oldp+398,(0x00002000U),32);
    bufp->fullIData(oldp+399,(1U),32);
    bufp->fullIData(oldp+400,(0U),32);
    bufp->fullIData(oldp+401,(0x4d494e49U),32);
    bufp->fullBit(oldp+402,(1U));
    bufp->fullBit(oldp+403,(0U));
    bufp->fullIData(oldp+404,(0x0000000dU),32);
    bufp->fullIData(oldp+405,(4U),32);
    bufp->fullIData(oldp+406,(2U),32);
    bufp->fullIData(oldp+407,(0x0000000aU),32);
    bufp->fullIData(oldp+408,(0U),32);
    bufp->fullIData(oldp+409,(0x00000024U),32);
    bufp->fullBit(oldp+410,(0U));
    bufp->fullCData(oldp+411,(0U),2);
    bufp->fullCData(oldp+412,(1U),2);
    bufp->fullCData(oldp+413,(2U),2);
    bufp->fullCData(oldp+414,(3U),2);
    bufp->fullIData(oldp+415,(0x80000000U),32);
    bufp->fullIData(oldp+416,(0x90000000U),32);
    bufp->fullIData(oldp+417,(4U),32);
    bufp->fullIData(oldp+418,(6U),32);
    bufp->fullIData(oldp+419,(0x00000240U),32);
    bufp->fullIData(oldp+420,(0x00000020U),32);
    bufp->fullIData(oldp+421,(0x0000001fU),32);
}

VL_ATTR_COLD void Vservant_sim___024root__trace_full_0_sub_0(Vservant_sim___024root* vlSelf, VerilatedVcd::Buffer* bufp);

VL_ATTR_COLD void Vservant_sim___024root__trace_full_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vservant_sim___024root__trace_full_0\n"); );
    // Body
    Vservant_sim___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vservant_sim___024root*>(voidSelf);
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    Vservant_sim___024root__trace_full_0_sub_0((&vlSymsp->TOP), bufp);
}

VL_ATTR_COLD void Vservant_sim___024root__trace_full_0_sub_0(Vservant_sim___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vservant_sim___024root__trace_full_0_sub_0\n"); );
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode);
    bufp->fullWData(oldp+1,(vlSymsp->TOP__servant_sim.__PVT__firmware_file),1024);
    bufp->fullIData(oldp+33,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__mux__DOT__genblk1__DOT__f),32);
    bufp->fullWData(oldp+34,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__mux__DOT__genblk1__DOT__signature_file),1024);
    bufp->fullBit(oldp+66,((1U & ((~ (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_ibus_cyc)) 
                                  & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode) 
                                     >> 3U)))));
    bufp->fullBit(oldp+67,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__arbiter__DOT__o_wb_mem_stb));
    bufp->fullBit(oldp+68,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_ibus_cyc));
    bufp->fullBit(oldp+69,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trig_irq));
    bufp->fullBit(oldp+70,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__i_load));
    bufp->fullBit(oldp+71,(((~ (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_ibus_cyc)) 
                            & (IData)(vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_ack))));
    bufp->fullBit(oldp+72,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__i_wreq));
    bufp->fullBit(oldp+73,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__i_rreq));
    bufp->fullBit(oldp+74,(((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__i_wreq) 
                            | (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rgnt))));
    bufp->fullCData(oldp+75,(vlSymsp->TOP__servant_sim__dut__ram.__PVT__we),4);
    bufp->fullBit(oldp+76,(vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_ack));
    bufp->fullBit(oldp+77,(vlSymsp->TOP__servant_sim__dut.__PVT__q));
    bufp->fullBit(oldp+78,(vlSymsp->TOP__servant_sim__dut.__PVT__timer_irq));
    bufp->fullIData(oldp+79,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_dat),32);
    bufp->fullCData(oldp+80,(((((2U & (((3U == (3U 
                                                & vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1)) 
                                        | (((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                                            >> 1U) 
                                           | ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                                              & (vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                                 >> 1U)))) 
                                       << 1U)) | (1U 
                                                  & ((2U 
                                                      == 
                                                      (3U 
                                                       & vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1)) 
                                                     | ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                                                        >> 1U)))) 
                               << 2U) | ((2U & (((1U 
                                                  == 
                                                  (3U 
                                                   & vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1)) 
                                                 | (((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                                                     >> 1U) 
                                                    | ((~ 
                                                        (vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                                         >> 1U)) 
                                                       & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3)))) 
                                                << 1U)) 
                                         | (0U == (3U 
                                                   & vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1))))),4);
    bufp->fullIData(oldp+81,(vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt),32);
    bufp->fullBit(oldp+82,((1U & vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dlo)));
    bufp->fullBit(oldp+83,((1U & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode) 
                                  >> 3U))));
    bufp->fullBit(oldp+84,(((~ (vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                >> 0x0000001fU)) & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__mux__DOT__o_wb_ext_stb))));
    bufp->fullBit(oldp+85,(vlSymsp->TOP__servant_sim__dut.__PVT__wb_gpio_rdt));
    bufp->fullBit(oldp+86,(((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__mux__DOT__o_wb_ext_stb) 
                            & (vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                               >> 0x0000001fU))));
    bufp->fullIData(oldp+87,(vlSymsp->TOP__servant_sim__dut.__PVT__timer__DOT__mtime),32);
    bufp->fullIData(oldp+88,((0xfffffffcU & vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1)),32);
    bufp->fullBit(oldp+89,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__mux__DOT__o_wb_ext_stb));
    bufp->fullIData(oldp+90,(((vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                               >> 0x0000001fU) ? vlSymsp->TOP__servant_sim__dut.__PVT__timer__DOT__mtime
                               : (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__wb_gpio_rdt))),32);
    bufp->fullBit(oldp+91,(vlSymsp->TOP__servant_sim__dut.__PVT__wb_ext_ack));
    bufp->fullSData(oldp+92,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__o_waddr),10);
    bufp->fullCData(oldp+93,((3U & ((1U & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rcnt))
                                     ? (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__wdata1_r)
                                     : (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__wdata0_r)))),2);
    bufp->fullBit(oldp+94,((((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rtrig1) 
                             & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__wen0_r)) 
                            | ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rcnt) 
                               & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__wen1_r)))));
    bufp->fullSData(oldp+95,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__o_raddr),10);
    bufp->fullBit(oldp+96,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rgate));
    bufp->fullCData(oldp+97,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__i_rdata),2);
    bufp->fullIData(oldp+98,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__wb_ibus_adr),32);
    bufp->fullBit(oldp+99,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_dbus_cyc));
    bufp->fullIData(oldp+100,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__i_dat),32);
    bufp->fullBit(oldp+101,(((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_dbus_cyc) 
                             & ((0U == (vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                        >> 0x0000001eU)) 
                                & (IData)(vlSymsp->TOP__servant_sim__dut.cpu__DOT__mux__DOT____VdfgRegularize_h2b1522d7_0_0)))));
    bufp->fullCData(oldp+102,(((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trap)
                                ? 0x23U : (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7))),6);
    bufp->fullCData(oldp+103,(((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trap)
                                ? 0x22U : (0x00000020U 
                                           | (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_csr_addr)))),6);
    bufp->fullBit(oldp+104,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__rf_if__DOT__o_wen0));
    bufp->fullBit(oldp+105,(((0U != (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb)) 
                             & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_csr_en) 
                                | (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trap)))));
    bufp->fullBit(oldp+106,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__rf_if__DOT__o_wdata0));
    bufp->fullBit(oldp+107,((1U & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trap)
                                    ? vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__wb_ibus_adr
                                    : (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__o_csr_in)))));
    bufp->fullCData(oldp+108,((0x0000001fU & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm19_12_20) 
                                              >> 4U))),6);
    bufp->fullCData(oldp+109,((((IData)(vlSymsp->TOP__servant_sim__dut.cpu__DOT__cpu__DOT__rf_if__DOT____VdfgRegularize_h1739b917_0_0) 
                                << 5U) | ((0x0000001cU 
                                           & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm24_20) 
                                              & ((- (IData)(
                                                            (1U 
                                                             & (~ (IData)(vlSymsp->TOP__servant_sim__dut.cpu__DOT__cpu__DOT__rf_if__DOT____VdfgRegularize_h1739b917_0_0))))) 
                                                 << 2U))) 
                                          | (3U & (
                                                   (((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_mret) 
                                                     << 1U) 
                                                    | (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trap)) 
                                                   | (((- (IData)((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_csr_en))) 
                                                       & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_csr_addr)) 
                                                      | ((- (IData)(
                                                                    (1U 
                                                                     & (~ (IData)(vlSymsp->TOP__servant_sim__dut.cpu__DOT__cpu__DOT__rf_if__DOT____VdfgRegularize_h1739b917_0_0))))) 
                                                         & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm24_20)))))))),6);
    bufp->fullBit(oldp+110,((1U & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rdata0))));
    bufp->fullBit(oldp+111,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__i_rs2));
    bufp->fullIData(oldp+112,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1),32);
    bufp->fullCData(oldp+113,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3),3);
    bufp->fullCData(oldp+114,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7),5);
    bufp->fullCData(oldp+115,((0x0000001fU & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm19_12_20) 
                                              >> 4U))),5);
    bufp->fullCData(oldp+116,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm24_20),5);
    bufp->fullCData(oldp+117,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_immdec_ctrl),4);
    bufp->fullCData(oldp+118,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_immdec_en),4);
    bufp->fullBit(oldp+119,((1U & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                                   >> 2U))));
    bufp->fullBit(oldp+120,((1U & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3))));
    bufp->fullBit(oldp+121,((1U & (~ (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode)))));
    bufp->fullBit(oldp+122,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_two_stage_op));
    bufp->fullBit(oldp+123,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_e_op));
    bufp->fullBit(oldp+124,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__op20));
    bufp->fullBit(oldp+125,((1U & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode) 
                                   >> 4U))));
    bufp->fullBit(oldp+126,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_shift_op));
    bufp->fullBit(oldp+127,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_rd_op));
    bufp->fullBit(oldp+128,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_rd_alu_en));
    bufp->fullBit(oldp+129,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_rd_csr_en));
    bufp->fullBit(oldp+130,((IData)((0U == (5U & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode))))));
    bufp->fullBit(oldp+131,((((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__i_utype) 
                              & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__o_bad_pc)) 
                             | ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__pc_plus_4) 
                                & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__i_jal_or_jalr)))));
    bufp->fullBit(oldp+132,((1U & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__o_q) 
                                   | (((0U == (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3)) 
                                       & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__alu__DOT__result_add)) 
                                      | ((IData)(((
                                                   (2U 
                                                    == 
                                                    (6U 
                                                     & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3))) 
                                                   & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__alu__DOT__cmp_r)) 
                                                  & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt0))) 
                                         | (((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                                             >> 2U) 
                                            & (((~ (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3)) 
                                                & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_op_b) 
                                                   ^ (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rdata0))) 
                                               | (((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                                                   >> 1U) 
                                                  & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_op_b) 
                                                     & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rdata0)))))))))));
    bufp->fullBit(oldp+133,(((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__mem_if__DOT__dat_valid)
                              ? (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_q)
                              : ((~ ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                                     >> 2U)) & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__mem_if__DOT__signbit)))));
    bufp->fullBit(oldp+134,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__o_q));
    bufp->fullBit(oldp+135,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__i_pc_en));
    bufp->fullBit(oldp+136,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__jump));
    bufp->fullBit(oldp+137,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__i_jal_or_jalr));
    bufp->fullBit(oldp+138,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__i_utype));
    bufp->fullBit(oldp+139,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_mret));
    bufp->fullBit(oldp+140,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_imm));
    bufp->fullBit(oldp+141,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trap));
    bufp->fullBit(oldp+142,(((0U == (7U & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode))) 
                             | ((3U == (3U & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode))) 
                                | (((IData)(vlSymsp->TOP__servant_sim__dut.cpu__DOT__cpu__DOT__decode__DOT____VdfgRegularize_h6d71b89f_0_4) 
                                    & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__op20)) 
                                   | (0U == (3U & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode) 
                                                   >> 3U))))))));
    bufp->fullBit(oldp+143,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_init));
    bufp->fullBit(oldp+144,((0U != (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb))));
    bufp->fullBit(oldp+145,((0U == (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt))));
    bufp->fullBit(oldp+146,((IData)((((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt) 
                                      >> 2U) | (3U 
                                                == 
                                                (3U 
                                                 & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt)))))));
    bufp->fullBit(oldp+147,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt0));
    bufp->fullBit(oldp+148,(((0U == (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt)) 
                             & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb) 
                                >> 1U))));
    bufp->fullBit(oldp+149,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__i_cnt2));
    bufp->fullBit(oldp+150,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_cnt3));
    bufp->fullBit(oldp+151,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__i_cnt7));
    bufp->fullBit(oldp+152,(((2U == (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt)) 
                             & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb) 
                                >> 3U))));
    bufp->fullBit(oldp+153,(((3U == (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt)) 
                             & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb))));
    bufp->fullBit(oldp+154,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt_done));
    bufp->fullBit(oldp+155,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_en));
    bufp->fullBit(oldp+156,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__imm30));
    bufp->fullBit(oldp+157,((1U & ((~ ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode) 
                                       >> 4U)) | (IData)(
                                                         (1U 
                                                          == 
                                                          (3U 
                                                           & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode))))))));
    bufp->fullBit(oldp+158,((1U & (~ ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode) 
                                      >> 2U)))));
    bufp->fullBit(oldp+159,((((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode) 
                              >> 4U) & ((0U == (3U 
                                                & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode))) 
                                        | (3U == (3U 
                                                  & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode)))))));
    bufp->fullBit(oldp+160,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__o_q));
    bufp->fullBit(oldp+161,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_q));
    bufp->fullBit(oldp+162,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__alu__DOT__i_sub));
    bufp->fullCData(oldp+163,((3U & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3))),2);
    bufp->fullBit(oldp+164,((0U == (3U & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                                          >> 1U)))));
    bufp->fullBit(oldp+165,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__alu__DOT__i_cmp_sig));
    bufp->fullBit(oldp+166,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__alu__DOT__o_cmp));
    bufp->fullCData(oldp+167,(((4U & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3)) 
                               | (((1U == (3U & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                                                 >> 1U))) 
                                   << 1U) | (0U == (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3))))),3);
    bufp->fullBit(oldp+168,(((~ (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_init)) 
                             & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_rd_op))));
    bufp->fullBit(oldp+169,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_op_b));
    bufp->fullBit(oldp+170,((1U & (~ ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                                      >> 2U)))));
    bufp->fullBit(oldp+171,((1U & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                                   >> 1U))));
    bufp->fullCData(oldp+172,((3U & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt) 
                                     >> 1U))),2);
    bufp->fullBit(oldp+173,((1U & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dat_shamt) 
                                   >> 5U))));
    bufp->fullBit(oldp+174,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__mem_if__DOT__o_misalign));
    bufp->fullBit(oldp+175,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__o_bad_pc));
    bufp->fullBit(oldp+176,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_mstatus_en));
    bufp->fullBit(oldp+177,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_mie_en));
    bufp->fullBit(oldp+178,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_mcause_en));
    bufp->fullBit(oldp+179,((1U & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm19_12_20) 
                                   >> 4U))));
    bufp->fullBit(oldp+180,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_csr_en));
    bufp->fullCData(oldp+181,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_csr_addr),2);
    bufp->fullBit(oldp+182,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_csr_imm_en));
    bufp->fullBit(oldp+183,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__o_csr_in));
    bufp->fullBit(oldp+184,(((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_csr_en) 
                             & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__i_rs2))));
    bufp->fullBit(oldp+185,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_dbus_en));
    bufp->fullBit(oldp+186,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__new_irq));
    bufp->fullCData(oldp+187,((3U & vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1)),2);
    bufp->fullBit(oldp+188,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__alu__DOT__result_add));
    bufp->fullBit(oldp+189,(((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__alu__DOT__cmp_r) 
                             & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt0))));
    bufp->fullBit(oldp+190,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__alu__DOT__cmp_r));
    bufp->fullBit(oldp+191,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__alu__DOT__add_cy));
    bufp->fullBit(oldp+192,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__alu__DOT__add_cy_r));
    bufp->fullBit(oldp+193,(((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__alu__DOT__i_cmp_sig) 
                             & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rdata0))));
    bufp->fullBit(oldp+194,(((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__alu__DOT__i_cmp_sig) 
                             & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_op_b))));
    bufp->fullBit(oldp+195,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__alu__DOT__add_b));
    bufp->fullBit(oldp+196,((1U & (((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__alu__DOT__i_cmp_sig) 
                                    & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rdata0)) 
                                   + ((~ ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__alu__DOT__i_cmp_sig) 
                                          & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_op_b))) 
                                      + (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__alu__DOT__add_cy))))));
    bufp->fullBit(oldp+197,(((~ (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__alu__DOT__result_add)) 
                             & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__alu__DOT__cmp_r) 
                                | (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt0)))));
    bufp->fullBit(oldp+198,((1U & (((~ (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3)) 
                                    & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_op_b) 
                                       ^ (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rdata0))) 
                                   | (((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                                       >> 1U) & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_op_b) 
                                                 & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rdata0)))))));
    bufp->fullCData(oldp+199,((7U & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dhi))),3);
    bufp->fullBit(oldp+200,((1U & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_carry_and_sum_a0) 
                                   >> 1U))));
    bufp->fullBit(oldp+201,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_cr_in_a1));
    bufp->fullCData(oldp+202,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_carry_and_sum_a0),2);
    bufp->fullBit(oldp+203,(((((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode) 
                               >> 4U) & ((0U == (3U 
                                                 & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode))) 
                                         | (3U == (3U 
                                                   & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode))))) 
                             & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt0))));
    bufp->fullBit(oldp+204,((((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_carry_and_sum_a0) 
                              >> 1U) & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_en))));
    bufp->fullIData(oldp+205,(((((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_en)
                                  ? ((0x20000000U & 
                                      (((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_init)
                                         ? (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_carry_and_sum_a0)
                                         : ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__imm30) 
                                            & (vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                               >> 0x0000001fU))) 
                                       << 0x0000001dU)) 
                                     | (vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                        >> 3U)) : (vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                                   >> 2U)) 
                                << 2U) | (3U & (((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_init)
                                                  ? (IData)(vlSymsp->TOP__servant_sim__dut.__VdfgRegularize_hd8275ffe_1_0)
                                                  : (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_en))
                                                 ? 
                                                ((2U 
                                                  & (((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_init)
                                                       ? (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_carry_and_sum_a0)
                                                       : 
                                                      (vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                                       >> 2U)) 
                                                     << 1U)) 
                                                 | (1U 
                                                    & (vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                                       >> 1U)))
                                                 : vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1)))),32);
    bufp->fullCData(oldp+206,((7U & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_en)
                                      ? ((vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                          >> 1U) & 
                                         (- (IData)(
                                                    (1U 
                                                     & (~ (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt_done))))))
                                      : (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_tail_a1)))),3);
    bufp->fullCData(oldp+207,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_tail_a1),3);
    bufp->fullIData(oldp+208,(((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_en)
                                ? ((((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_init)
                                      ? (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_carry_and_sum_a0)
                                      : ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__imm30) 
                                         & (vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                            >> 0x0000001fU))) 
                                    << 0x0000001fU) 
                                   | (vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                      >> 1U)) : vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1)),32);
    bufp->fullCData(oldp+209,((((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt0) 
                                & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_en))
                                ? (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_carry_and_sum_a0)
                                : (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_lsb_a1))),2);
    bufp->fullCData(oldp+210,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_lsb_a1),2);
    bufp->fullSData(oldp+211,(((0x000003f8U & (vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                               << 3U)) 
                               | (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_tail_a1))),10);
    bufp->fullBit(oldp+212,((1U & (((0x000003f8U & 
                                     (vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                      << 3U)) | (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_tail_a1)) 
                                   >> ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_shift_op)
                                        ? (7U & ((4U 
                                                  & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3))
                                                  ? 
                                                 ((IData)(3U) 
                                                  + 
                                                  (3U 
                                                   & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dhi)))
                                                  : 
                                                 (3U 
                                                  & (~ (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dhi)))))
                                        : 3U)))));
    bufp->fullBit(oldp+213,((1U & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_carry_and_sum_a0))));
    bufp->fullBit(oldp+214,((0x000003ffU & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_en) 
                                            & (((0x000003f8U 
                                                 & (vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                                    << 3U)) 
                                                | (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_tail_a1)) 
                                               >> ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_shift_op)
                                                    ? 
                                                   (7U 
                                                    & ((4U 
                                                        & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3))
                                                        ? 
                                                       ((IData)(3U) 
                                                        + 
                                                        (3U 
                                                         & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dhi)))
                                                        : 
                                                       (3U 
                                                        & (~ (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dhi)))))
                                                    : 3U))))));
    bufp->fullCData(oldp+215,(((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_shift_op)
                                ? (7U & ((4U & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3))
                                          ? ((IData)(3U) 
                                             + (3U 
                                                & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dhi)))
                                          : (3U & (~ (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dhi)))))
                                : 3U)),3);
    bufp->fullCData(oldp+216,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dhi),8);
    bufp->fullIData(oldp+217,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dlo),24);
    bufp->fullBit(oldp+218,((1U & ((IData)((0U == (3U 
                                                   & vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1))) 
                                   | ((IData)((0U == 
                                               (6U 
                                                & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt)))) 
                                      | (((~ ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt) 
                                              >> 2U)) 
                                          & (~ (vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                                >> 1U))) 
                                         | (((~ ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt) 
                                                 >> 2U)) 
                                             & (~ vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1)) 
                                            | ((~ ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt) 
                                                   >> 1U)) 
                                               & (~ 
                                                  (vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                                   >> 1U))))))))));
    bufp->fullBit(oldp+219,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__shift_en));
    bufp->fullBit(oldp+220,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__cnt_en));
    bufp->fullCData(oldp+221,((((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_op_b) 
                                << 7U) | ((0x00000040U 
                                           & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dhi) 
                                              >> 1U)) 
                                          | (0x0000003fU 
                                             & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dhi) 
                                                - (IData)(1U)))))),8);
    bufp->fullCData(oldp+222,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dat_shamt),8);
    bufp->fullBit(oldp+223,(((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_mret) 
                             | (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trap))));
    bufp->fullBit(oldp+224,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__pc_plus_4));
    bufp->fullBit(oldp+225,((1U & (((1U & vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__wb_ibus_adr) 
                                    + ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__i_cnt2) 
                                       + (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__pc_plus_4_cy_r))) 
                                   >> 1U))));
    bufp->fullBit(oldp+226,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__pc_plus_4_cy_r));
    bufp->fullBit(oldp+227,((1U & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__offset_a) 
                                   + ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__offset_b) 
                                      + (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__pc_plus_offset_cy_r))))));
    bufp->fullBit(oldp+228,((1U & (((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__offset_a) 
                                    + ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__offset_b) 
                                       + (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__pc_plus_offset_cy_r))) 
                                   >> 1U))));
    bufp->fullBit(oldp+229,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__pc_plus_offset_cy_r));
    bufp->fullBit(oldp+230,((1U & vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__wb_ibus_adr)));
    bufp->fullBit(oldp+231,((((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_mret) 
                              | (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trap))
                              ? ((~ (IData)(vlSymsp->TOP__servant_sim__dut.__VdfgRegularize_hd8275ffe_1_0)) 
                                 & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__i_rs2))
                              : ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__jump)
                                  ? (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__o_bad_pc)
                                  : (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__pc_plus_4)))));
    bufp->fullBit(oldp+232,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__offset_a));
    bufp->fullBit(oldp+233,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__offset_b));
    bufp->fullIData(oldp+234,((vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt 
                               >> 2U)),30);
    bufp->fullCData(oldp+235,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode),5);
    bufp->fullBit(oldp+236,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__op21));
    bufp->fullBit(oldp+237,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__op22));
    bufp->fullBit(oldp+238,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__op26));
    bufp->fullBit(oldp+239,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__imm25));
    bufp->fullBit(oldp+240,(((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__op20) 
                             | ((~ (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__op21)) 
                                & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__op26)))));
    bufp->fullBit(oldp+241,((1U & (~ ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode) 
                                      >> 4U)))));
    bufp->fullBit(oldp+242,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mstatus_mie));
    bufp->fullBit(oldp+243,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mstatus_mpie));
    bufp->fullBit(oldp+244,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mie_mtie));
    bufp->fullBit(oldp+245,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mcause31));
    bufp->fullCData(oldp+246,(((((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mcause3_0__BRA__3__KET__) 
                                 << 3U) | ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mcause3_0__BRA__2__KET__) 
                                           << 2U)) 
                               | (((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mcause3_0__BRA__1__KET__) 
                                   << 1U) | (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mcause3_0__BRA__0__KET__)))),4);
    bufp->fullBit(oldp+247,(((0U == (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt))
                              ? (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mcause3_0__BRA__0__KET__)
                              : ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt_done) 
                                 & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mcause31)))));
    bufp->fullBit(oldp+248,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__timer_irq_r));
    bufp->fullBit(oldp+249,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__d));
    bufp->fullBit(oldp+250,((((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_cnt3) 
                              & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mstatus_mie)) 
                             | (((2U == (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt)) 
                                 & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb) 
                                    >> 3U)) | ((3U 
                                                == (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt)) 
                                               & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb))))));
    bufp->fullBit(oldp+251,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__timer_irq));
    bufp->fullBit(oldp+252,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__update_rd));
    bufp->fullBit(oldp+253,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__update_mscratch));
    bufp->fullBit(oldp+254,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__update_mtvec));
    bufp->fullBit(oldp+255,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__update_mepc));
    bufp->fullBit(oldp+256,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__update_mtval));
    bufp->fullBit(oldp+257,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__update_mstatus));
    bufp->fullBit(oldp+258,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__update_mie));
    bufp->fullBit(oldp+259,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__update_mcause));
    bufp->fullIData(oldp+260,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_rd),32);
    bufp->fullIData(oldp+261,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_csr),32);
    bufp->fullIData(oldp+262,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_mstatus),32);
    bufp->fullIData(oldp+263,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_mie),32);
    bufp->fullIData(oldp+264,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_mcause),32);
    bufp->fullIData(oldp+265,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_mscratch),32);
    bufp->fullIData(oldp+266,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_mtvec),32);
    bufp->fullIData(oldp+267,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_mepc),32);
    bufp->fullIData(oldp+268,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_mtval),32);
    bufp->fullIData(oldp+269,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x1),32);
    bufp->fullIData(oldp+270,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x2),32);
    bufp->fullIData(oldp+271,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x3),32);
    bufp->fullIData(oldp+272,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x4),32);
    bufp->fullIData(oldp+273,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x5),32);
    bufp->fullIData(oldp+274,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x6),32);
    bufp->fullIData(oldp+275,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x7),32);
    bufp->fullIData(oldp+276,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x8),32);
    bufp->fullIData(oldp+277,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x9),32);
    bufp->fullIData(oldp+278,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x10),32);
    bufp->fullIData(oldp+279,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x11),32);
    bufp->fullIData(oldp+280,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x12),32);
    bufp->fullIData(oldp+281,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x13),32);
    bufp->fullIData(oldp+282,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x14),32);
    bufp->fullIData(oldp+283,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x15),32);
    bufp->fullIData(oldp+284,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x16),32);
    bufp->fullIData(oldp+285,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x17),32);
    bufp->fullIData(oldp+286,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x18),32);
    bufp->fullIData(oldp+287,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x19),32);
    bufp->fullIData(oldp+288,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x20),32);
    bufp->fullIData(oldp+289,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x21),32);
    bufp->fullIData(oldp+290,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x22),32);
    bufp->fullIData(oldp+291,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x23),32);
    bufp->fullIData(oldp+292,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x24),32);
    bufp->fullIData(oldp+293,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x25),32);
    bufp->fullIData(oldp+294,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x26),32);
    bufp->fullIData(oldp+295,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x27),32);
    bufp->fullIData(oldp+296,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x28),32);
    bufp->fullIData(oldp+297,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x29),32);
    bufp->fullIData(oldp+298,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x30),32);
    bufp->fullIData(oldp+299,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x31),32);
    bufp->fullBit(oldp+300,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__LUI));
    bufp->fullBit(oldp+301,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__AUIPC));
    bufp->fullBit(oldp+302,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__JAL));
    bufp->fullBit(oldp+303,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__JALR));
    bufp->fullBit(oldp+304,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__BEQ));
    bufp->fullBit(oldp+305,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__BNE));
    bufp->fullBit(oldp+306,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__BLT));
    bufp->fullBit(oldp+307,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__BGE));
    bufp->fullBit(oldp+308,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__BLTU));
    bufp->fullBit(oldp+309,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__BGEU));
    bufp->fullBit(oldp+310,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__LB));
    bufp->fullBit(oldp+311,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__LH));
    bufp->fullBit(oldp+312,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__LW));
    bufp->fullBit(oldp+313,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__LBU));
    bufp->fullBit(oldp+314,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__LHU));
    bufp->fullBit(oldp+315,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SB));
    bufp->fullBit(oldp+316,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SH));
    bufp->fullBit(oldp+317,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SW));
    bufp->fullBit(oldp+318,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__ADDI));
    bufp->fullBit(oldp+319,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SLTI));
    bufp->fullBit(oldp+320,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SLTIU));
    bufp->fullBit(oldp+321,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__XORI));
    bufp->fullBit(oldp+322,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__ORI));
    bufp->fullBit(oldp+323,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__ANDI));
    bufp->fullBit(oldp+324,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SLLI));
    bufp->fullBit(oldp+325,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SRLI));
    bufp->fullBit(oldp+326,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SRAI));
    bufp->fullBit(oldp+327,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__ADD));
    bufp->fullBit(oldp+328,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SUB));
    bufp->fullBit(oldp+329,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SLL));
    bufp->fullBit(oldp+330,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SLT));
    bufp->fullBit(oldp+331,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SLTU));
    bufp->fullBit(oldp+332,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__XOR));
    bufp->fullBit(oldp+333,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SRL));
    bufp->fullBit(oldp+334,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SRA));
    bufp->fullBit(oldp+335,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__OR));
    bufp->fullBit(oldp+336,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__AND));
    bufp->fullBit(oldp+337,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__FENCE));
    bufp->fullBit(oldp+338,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__ECALL));
    bufp->fullBit(oldp+339,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__EBREAK));
    bufp->fullBit(oldp+340,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__CSRRW));
    bufp->fullBit(oldp+341,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__CSRRS));
    bufp->fullBit(oldp+342,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__CSRRC));
    bufp->fullBit(oldp+343,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__CSRRWI));
    bufp->fullBit(oldp+344,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__CSRRSI));
    bufp->fullBit(oldp+345,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__CSRRCI));
    bufp->fullBit(oldp+346,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__OTHER));
    bufp->fullIData(oldp+347,((vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt 
                               >> 7U)),25);
    bufp->fullBit(oldp+348,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm31));
    bufp->fullSData(oldp+349,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm19_12_20),9);
    bufp->fullBit(oldp+350,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm7));
    bufp->fullCData(oldp+351,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm30_25),6);
    bufp->fullBit(oldp+352,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__signbit));
    bufp->fullBit(oldp+353,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__mem_if__DOT__signbit));
    bufp->fullBit(oldp+354,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__mem_if__DOT__dat_valid));
    bufp->fullBit(oldp+355,((((~ (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_init)) 
                              & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_rd_op)) 
                             & (0U != (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7)))));
    bufp->fullBit(oldp+356,(((((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__o_q) 
                               | (((0U == (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3)) 
                                   & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__alu__DOT__result_add)) 
                                  | ((IData)((((2U 
                                                == 
                                                (6U 
                                                 & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3))) 
                                               & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__alu__DOT__cmp_r)) 
                                              & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt0))) 
                                     | (((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                                         >> 2U) & (
                                                   ((~ (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3)) 
                                                    & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_op_b) 
                                                       ^ (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rdata0))) 
                                                   | (((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                                                       >> 1U) 
                                                      & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_op_b) 
                                                         & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rdata0)))))))) 
                              & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_rd_alu_en)) 
                             | (((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__o_q) 
                                 & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_rd_csr_en)) 
                                | ((((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__mem_if__DOT__dat_valid)
                                      ? (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_q)
                                      : ((~ ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                                             >> 2U)) 
                                         & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__mem_if__DOT__signbit))) 
                                    & (IData)((0U == 
                                               (5U 
                                                & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode))))) 
                                   | (((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__i_utype) 
                                       & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__o_bad_pc)) 
                                      | ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__pc_plus_4) 
                                         & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__i_jal_or_jalr))))))));
    bufp->fullBit(oldp+357,(((0x00000010U & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode))
                              ? (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__o_bad_pc)
                              : (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__o_q))));
    bufp->fullBit(oldp+358,((1U & (~ (IData)(vlSymsp->TOP__servant_sim__dut.cpu__DOT__cpu__DOT__rf_if__DOT____VdfgRegularize_h1739b917_0_0)))));
    bufp->fullBit(oldp+359,((1U & (vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                   >> 1U))));
    bufp->fullBit(oldp+360,((1U == (3U & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                                          >> 1U)))));
    bufp->fullBit(oldp+361,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__init_done));
    bufp->fullBit(oldp+362,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_csr__DOT__misalign_trap_sync_r));
    bufp->fullCData(oldp+363,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt),3);
    bufp->fullCData(oldp+364,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb),4);
    bufp->fullBit(oldp+365,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__ibus_cyc));
    bufp->fullBit(oldp+366,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__take_branch));
    bufp->fullBit(oldp+367,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__last_init));
    bufp->fullBit(oldp+368,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__state__DOT__trap_pending));
    bufp->fullBit(oldp+369,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__mux__DOT__sig_en));
    bufp->fullBit(oldp+370,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__mux__DOT__halt_en));
    bufp->fullBit(oldp+371,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__mux__DOT__sim_ack));
    bufp->fullBit(oldp+372,((0U != (vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                    >> 0x0000001eU))));
    bufp->fullBit(oldp+373,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rgnt));
    bufp->fullCData(oldp+374,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rcnt),5);
    bufp->fullBit(oldp+375,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rtrig1));
    bufp->fullCData(oldp+376,((0x0000001fU & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rcnt) 
                                              - (IData)(4U)))),5);
    bufp->fullCData(oldp+377,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__wdata0_r),2);
    bufp->fullCData(oldp+378,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__wdata1_r),3);
    bufp->fullBit(oldp+379,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__wen0_r));
    bufp->fullBit(oldp+380,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__wen1_r));
    bufp->fullBit(oldp+381,((1U & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rcnt))));
    bufp->fullCData(oldp+382,(((1U & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rcnt))
                                ? ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trap)
                                    ? 0x22U : (0x00000020U 
                                               | (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_csr_addr)))
                                : ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trap)
                                    ? 0x23U : (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7)))),6);
    bufp->fullCData(oldp+383,(((1U & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rcnt))
                                ? (((IData)(vlSymsp->TOP__servant_sim__dut.cpu__DOT__cpu__DOT__rf_if__DOT____VdfgRegularize_h1739b917_0_0) 
                                    << 5U) | ((0x0000001cU 
                                               & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm24_20) 
                                                  & ((- (IData)(
                                                                (1U 
                                                                 & (~ (IData)(vlSymsp->TOP__servant_sim__dut.cpu__DOT__cpu__DOT__rf_if__DOT____VdfgRegularize_h1739b917_0_0))))) 
                                                     << 2U))) 
                                              | (3U 
                                                 & ((((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_mret) 
                                                      << 1U) 
                                                     | (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trap)) 
                                                    | (((- (IData)((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_csr_en))) 
                                                        & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_csr_addr)) 
                                                       | ((- (IData)(
                                                                     (1U 
                                                                      & (~ (IData)(vlSymsp->TOP__servant_sim__dut.cpu__DOT__cpu__DOT__rf_if__DOT____VdfgRegularize_h1739b917_0_0))))) 
                                                          & (IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm24_20)))))))
                                : (0x0000001fU & ((IData)(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm19_12_20) 
                                                  >> 4U)))),6);
    bufp->fullCData(oldp+384,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rdata0),2);
    bufp->fullBit(oldp+385,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rdata1));
    bufp->fullBit(oldp+386,(vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__rf_ram_if__DOT__rreq_r));
    bufp->fullCData(oldp+387,(vlSymsp->TOP__servant_sim__dut.__PVT__rf_ram__DOT__rdata),2);
    bufp->fullBit(oldp+388,(vlSymsp->TOP__servant_sim__dut.__PVT__rf_ram__DOT__regzero));
    bufp->fullCData(oldp+389,((vlSymsp->TOP__servant_sim__dut.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                               >> 0x0000001eU)),2);
    bufp->fullIData(oldp+390,(vlSymsp->TOP__servant_sim__dut.__PVT__timer__DOT__mtimecmp),32);
    bufp->fullBit(oldp+391,(vlSelfRef.wb_clk));
    bufp->fullBit(oldp+392,(vlSelfRef.wb_rst));
    bufp->fullIData(oldp+393,(vlSelfRef.pc_adr),32);
    bufp->fullBit(oldp+394,(vlSelfRef.pc_vld));
    bufp->fullBit(oldp+395,(vlSelfRef.q));
    bufp->fullSData(oldp+396,((0x000007ffU & (vlSelfRef.pc_adr 
                                              >> 2U))),11);
}
