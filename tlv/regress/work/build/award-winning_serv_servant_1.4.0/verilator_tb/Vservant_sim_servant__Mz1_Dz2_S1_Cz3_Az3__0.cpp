// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vservant_sim.h for the primary calling header

#include "Vservant_sim__pch.h"

void Vservant_sim_servant__Mz1_Dz2_S1_Cz3_Az3___ico_sequent__TOP__servant_sim__dut__0(Vservant_sim_servant__Mz1_Dz2_S1_Cz3_Az3* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vservant_sim_servant__Mz1_Dz2_S1_Cz3_Az3___ico_sequent__TOP__servant_sim__dut__0\n"); );
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_ibus_cyc 
        = ((~ (IData)(vlSymsp->TOP.wb_rst)) & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__ibus_cyc));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trig_irq 
        = ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_ibus_cyc) 
           & (IData)(vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_ack));
    vlSelfRef.__PVT__cpu__DOT__arbiter__DOT__o_wb_mem_stb 
        = (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_dbus_cyc) 
            & ((0U == (vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                       >> 0x0000001eU)) & (IData)(vlSelfRef.cpu__DOT__mux__DOT____VdfgRegularize_h2b1522d7_0_0))) 
           | (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_ibus_cyc));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__i_load 
        = ((IData)(vlSelfRef.__PVT__wb_ext_ack) | (
                                                   ((~ (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_ibus_cyc)) 
                                                    & (IData)(vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_ack)) 
                                                   | (IData)(vlSelfRef.__PVT__cpu__DOT__mux__DOT__sim_ack)));
    vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__i_rreq 
        = ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trig_irq) 
           | ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__trap_pending) 
              & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__last_init)));
    vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__i_wreq 
        = (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_shift_op) 
            & ((4U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3))
                ? (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dat_shamt) 
                    >> 5U) & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__last_init) 
                              | (IData)(vlSelfRef.cpu__DOT__cpu__DOT__state__DOT____VdfgRegularize_h76bd994c_0_1)))
                : (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__last_init))) 
           | ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__i_load) 
              | ((((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode) 
                   >> 4U) & ((~ (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__trap_pending)) 
                             & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__last_init))) 
                 | ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_rd_alu_en) 
                    & (IData)(((2U == (6U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3))) 
                               & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__last_init)))))));
}

void Vservant_sim_servant__Mz1_Dz2_S1_Cz3_Az3___nba_sequent__TOP__servant_sim__dut__0(Vservant_sim_servant__Mz1_Dz2_S1_Cz3_Az3* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vservant_sim_servant__Mz1_Dz2_S1_Cz3_Az3___nba_sequent__TOP__servant_sim__dut__0\n"); );
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ cpu__DOT__cpu__DOT__decode__DOT____VdfgRegularize_h6d71b89f_0_11;
    cpu__DOT__cpu__DOT__decode__DOT____VdfgRegularize_h6d71b89f_0_11 = 0;
    CData/*0:0*/ cpu__DOT__cpu__DOT__decode__DOT____VdfgRegularize_h6d71b89f_0_12;
    cpu__DOT__cpu__DOT__decode__DOT____VdfgRegularize_h6d71b89f_0_12 = 0;
    CData/*0:0*/ cpu__DOT__cpu__DOT__decode__DOT____VdfgRegularize_h6d71b89f_0_13;
    cpu__DOT__cpu__DOT__decode__DOT____VdfgRegularize_h6d71b89f_0_13 = 0;
    CData/*0:0*/ __Vdly__wb_ext_ack;
    __Vdly__wb_ext_ack = 0;
    IData/*31:0*/ __Vdly__timer__DOT__mtime;
    __Vdly__timer__DOT__mtime = 0;
    CData/*0:0*/ __Vdly__cpu__DOT__mux__DOT__sim_ack;
    __Vdly__cpu__DOT__mux__DOT__sim_ack = 0;
    CData/*1:0*/ __Vdly__cpu__DOT__rf_ram_if__DOT__wdata0_r;
    __Vdly__cpu__DOT__rf_ram_if__DOT__wdata0_r = 0;
    CData/*2:0*/ __Vdly__cpu__DOT__rf_ram_if__DOT__wdata1_r;
    __Vdly__cpu__DOT__rf_ram_if__DOT__wdata1_r = 0;
    CData/*4:0*/ __Vdly__cpu__DOT__rf_ram_if__DOT__rcnt;
    __Vdly__cpu__DOT__rf_ram_if__DOT__rcnt = 0;
    CData/*2:0*/ __Vdly__cpu__DOT__cpu__DOT__state__DOT__o_cnt;
    __Vdly__cpu__DOT__cpu__DOT__state__DOT__o_cnt = 0;
    CData/*3:0*/ __Vdly__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb;
    __Vdly__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb = 0;
    SData/*8:0*/ __Vdly__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm19_12_20;
    __Vdly__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm19_12_20 = 0;
    CData/*5:0*/ __Vdly__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm30_25;
    __Vdly__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm30_25 = 0;
    CData/*4:0*/ __Vdly__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7;
    __Vdly__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7 = 0;
    IData/*23:0*/ __Vdly__cpu__DOT__cpu__DOT__bufreg2__DOT__dlo;
    __Vdly__cpu__DOT__cpu__DOT__bufreg2__DOT__dlo = 0;
    CData/*0:0*/ __Vdly__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mstatus_mie;
    __Vdly__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mstatus_mie = 0;
    IData/*31:0*/ __Vdly__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_rd;
    __Vdly__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_rd = 0;
    IData/*31:0*/ __Vdly__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_csr;
    __Vdly__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_csr = 0;
    CData/*1:0*/ __VdlyVal__rf_ram__DOT__memory__v0;
    __VdlyVal__rf_ram__DOT__memory__v0 = 0;
    SData/*9:0*/ __VdlyDim0__rf_ram__DOT__memory__v0;
    __VdlyDim0__rf_ram__DOT__memory__v0 = 0;
    CData/*0:0*/ __VdlySet__rf_ram__DOT__memory__v0;
    __VdlySet__rf_ram__DOT__memory__v0 = 0;
    // Body
    __Vdly__cpu__DOT__rf_ram_if__DOT__wdata0_r = vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__wdata0_r;
    __Vdly__timer__DOT__mtime = vlSelfRef.__PVT__timer__DOT__mtime;
    __Vdly__wb_ext_ack = vlSelfRef.__PVT__wb_ext_ack;
    __Vdly__cpu__DOT__rf_ram_if__DOT__rcnt = vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__rcnt;
    __Vdly__cpu__DOT__mux__DOT__sim_ack = vlSelfRef.__PVT__cpu__DOT__mux__DOT__sim_ack;
    __Vdly__cpu__DOT__rf_ram_if__DOT__wdata1_r = vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__wdata1_r;
    __Vdly__cpu__DOT__cpu__DOT__bufreg2__DOT__dlo = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dlo;
    __Vdly__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_rd 
        = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_rd;
    __VdlySet__rf_ram__DOT__memory__v0 = 0U;
    __Vdly__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mstatus_mie 
        = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mstatus_mie;
    __Vdly__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb 
        = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb;
    __Vdly__cpu__DOT__cpu__DOT__state__DOT__o_cnt = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt;
    __Vdly__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm30_25 
        = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm30_25;
    __Vdly__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm19_12_20 
        = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm19_12_20;
    __Vdly__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7 
        = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7;
    __Vdly__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_csr 
        = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_csr;
    __Vdly__cpu__DOT__rf_ram_if__DOT__wdata0_r = (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__rf_if__DOT__o_wdata0) 
                                                   << 1U) 
                                                  | (1U 
                                                     & ((IData)(vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__wdata0_r) 
                                                        >> 1U)));
    __Vdly__timer__DOT__mtime = ((IData)(1U) + vlSelfRef.__PVT__timer__DOT__mtime);
    __Vdly__wb_ext_ack = 0U;
    if (((IData)(vlSelfRef.__PVT__cpu__DOT__mux__DOT__o_wb_ext_stb) 
         & (~ (IData)(vlSelfRef.__PVT__wb_ext_ack)))) {
        __Vdly__wb_ext_ack = 1U;
    }
    __Vdly__cpu__DOT__mux__DOT__sim_ack = 0U;
    if (vlSymsp->TOP.wb_rst) {
        __Vdly__timer__DOT__mtime = 0U;
        __Vdly__wb_ext_ack = 0U;
    }
    if (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_dbus_cyc) 
         & (~ (IData)(vlSelfRef.__PVT__cpu__DOT__mux__DOT__sim_ack)))) {
        if (VL_UNLIKELY((((IData)(vlSelfRef.__PVT__cpu__DOT__mux__DOT__sig_en) 
                          & (0U != vlSelfRef.__PVT__cpu__DOT__mux__DOT__genblk1__DOT__f))))) {
            VL_FWRITEF_NX(vlSelfRef.__PVT__cpu__DOT__mux__DOT__genblk1__DOT__f,"%c",0,
                          8,(0x000000ffU & vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_dat));
        } else if (VL_UNLIKELY((vlSelfRef.__PVT__cpu__DOT__mux__DOT__halt_en))) {
            VL_WRITEF_NX("Test complete\n",0);
            VL_FINISH_MT("src/award-winning_serv_servile_1.4.0/servile/servile_mux.v", 87, "");
        }
        __Vdly__cpu__DOT__mux__DOT__sim_ack = ((IData)(vlSelfRef.__PVT__cpu__DOT__mux__DOT__sig_en) 
                                               | (IData)(vlSelfRef.__PVT__cpu__DOT__mux__DOT__halt_en));
    }
    __Vdly__cpu__DOT__rf_ram_if__DOT__wdata1_r = ((4U 
                                                   & (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trap)
                                                        ? vlSelfRef.__PVT__cpu__DOT__cpu__DOT__wb_ibus_adr
                                                        : (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__o_csr_in)) 
                                                      << 2U)) 
                                                  | (3U 
                                                     & ((IData)(vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__wdata1_r) 
                                                        >> 1U)));
    vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__rdata0 
        = (1U & ((IData)(vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__rdata0) 
                 >> 1U));
    if (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__shift_en) 
         | (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__i_load))) {
        __Vdly__cpu__DOT__cpu__DOT__bufreg2__DOT__dlo 
            = (0x00ffffffU & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__i_load)
                               ? vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__i_dat
                               : ((0x00800000U & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dhi) 
                                                  << 0x00000017U)) 
                                  | (0x007fffffU & 
                                     (vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dlo 
                                      >> 1U)))));
    }
    if ((((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trig_irq) 
          | (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt_done)) 
         | (IData)(vlSymsp->TOP.wb_rst))) {
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_csr__DOT__misalign_trap_sync_r 
            = ((~ ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trig_irq) 
                   | (IData)(vlSymsp->TOP.wb_rst))) 
               & (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__trap_pending) 
                   & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_init)) 
                  | (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_csr__DOT__misalign_trap_sync_r)));
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__ibus_cyc 
            = ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__i_pc_en) 
               | (IData)(vlSymsp->TOP.wb_rst));
    }
    if (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__i_pc_en) 
         | (IData)(vlSymsp->TOP.wb_rst))) {
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__wb_ibus_adr 
            = ((IData)(vlSymsp->TOP.wb_rst) ? 0U : 
               (((((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_mret) 
                   | (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trap))
                   ? ((~ (IData)(vlSelfRef.__VdfgRegularize_hd8275ffe_1_0)) 
                      & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__i_rs2))
                   : ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__jump)
                       ? (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__o_bad_pc)
                       : (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__pc_plus_4))) 
                 << 0x0000001fU) | (vlSelfRef.__PVT__cpu__DOT__cpu__DOT__wb_ibus_adr 
                                    >> 1U)));
    }
    if ((((IData)(vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__rtrig1) 
          & (IData)(vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__wen0_r)) 
         | ((IData)(vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__rcnt) 
            & (IData)(vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__wen1_r)))) {
        vlSelfRef.rf_ram__DOT____Vlvbound_h155a5e26__0 
            = (3U & ((1U & (IData)(vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__rcnt))
                      ? (IData)(vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__wdata1_r)
                      : (IData)(vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__wdata0_r)));
        if ((0x023fU >= (IData)(vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__o_waddr))) {
            __VdlyVal__rf_ram__DOT__memory__v0 = vlSelfRef.rf_ram__DOT____Vlvbound_h155a5e26__0;
            __VdlyDim0__rf_ram__DOT__memory__v0 = vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__o_waddr;
            __VdlySet__rf_ram__DOT__memory__v0 = 1U;
        }
    }
    if ((1U & (IData)(vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__rcnt))) {
        vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__rdata0 
            = vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__i_rdata;
        vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__wen0_r 
            = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__rf_if__DOT__o_wen0;
        vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__wen1_r 
            = ((0U != (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb)) 
               & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_csr_en) 
                  | (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trap)));
    }
    if (((((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trap) 
           & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt_done)) 
          | (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_mstatus_en) 
              & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_cnt3)) 
             & (0U != (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb)))) 
         | (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_mret))) {
        __Vdly__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mstatus_mie 
            = ((~ (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trap)) 
               & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_mret)
                   ? (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mstatus_mpie)
                   : (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__o_csr_in)));
    }
    __Vdly__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb 
        = ((0x0000000eU & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb) 
                           << 1U)) | (1U & ((((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb) 
                                              >> 3U) 
                                             & (~ (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt_done))) 
                                            | ((IData)(vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__i_wreq) 
                                               | (IData)(vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__rgnt)))));
    __Vdly__cpu__DOT__cpu__DOT__state__DOT__o_cnt = 
        (7U & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt) 
               + (1U & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb) 
                        >> 3U))));
    if (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trig_irq) 
         | ((0U != (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb)) 
            & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_immdec_en) 
               >> 1U)))) {
        __Vdly__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm19_12_20 
            = ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trig_irq)
                ? ((0x000001feU & (vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt 
                                   >> 0x0000000bU)) 
                   | (1U & (vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt 
                            >> 0x00000014U))) : ((0x00000100U 
                                                  & (((8U 
                                                       & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_immdec_ctrl))
                                                       ? (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__signbit)
                                                       : (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm24_20)) 
                                                     << 8U)) 
                                                 | (0x000000ffU 
                                                    & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm19_12_20) 
                                                       >> 1U))));
    }
    if (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trig_irq) 
         | ((0U != (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb)) 
            & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_immdec_en) 
               >> 3U)))) {
        __Vdly__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm30_25 
            = (0x0000003fU & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trig_irq)
                               ? (vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt 
                                  >> 0x00000019U) : 
                              ((0x00000020U & (((4U 
                                                 & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_immdec_ctrl))
                                                 ? (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm7)
                                                 : 
                                                ((2U 
                                                  & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_immdec_ctrl))
                                                  ? (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__signbit)
                                                  : (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm19_12_20))) 
                                               << 5U)) 
                               | (0x0000001fU & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm30_25) 
                                                 >> 1U)))));
    }
    if (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trig_irq) 
         | ((0U != (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb)) 
            & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_immdec_en) 
               >> 2U)))) {
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm24_20 
            = (0x0000001fU & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trig_irq)
                               ? (vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt 
                                  >> 0x00000014U) : 
                              ((0x00000010U & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm30_25) 
                                               << 4U)) 
                               | (0x0000000fU & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm24_20) 
                                                 >> 1U)))));
    }
    if (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trig_irq) 
         | ((0U != (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb)) 
            & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_immdec_en)))) {
        __Vdly__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7 
            = (0x0000001fU & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trig_irq)
                               ? (vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt 
                                  >> 7U) : ((0x00000010U 
                                             & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm30_25) 
                                                << 4U)) 
                                            | (0x0000000fU 
                                               & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7) 
                                                  >> 1U)))));
    }
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_tail_a1 
        = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_tail_a0;
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_lsb_a1 
        = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_lsb_a0;
    if (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_mie_en) 
         & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__i_cnt7))) {
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mie_mtie 
            = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__o_csr_in;
    }
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__pc_plus_4_cy_r 
        = ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__i_pc_en) 
           & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__pc_plus_4_cy));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__pc_plus_offset_cy_r 
        = ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__i_pc_en) 
           & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__pc_plus_offset_cy));
    if (vlSelfRef.__PVT__cpu__DOT__cpu__DOT__mem_if__DOT__dat_valid) {
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__mem_if__DOT__signbit 
            = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_q;
    }
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_cr_in_a1 
        = (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_carry_and_sum_a0) 
            >> 1U) & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_en));
    vlSelfRef.__PVT__rf_ram__DOT__regzero = (1U & (~ 
                                                   (0U 
                                                    != 
                                                    (0x0000003fU 
                                                     & ((IData)(vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__o_raddr) 
                                                        >> 4U)))));
    vlSelfRef.__PVT__rf_ram__DOT__rdata = ((IData)(vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__rgate)
                                            ? ((0x023fU 
                                                >= (IData)(vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__o_raddr))
                                                ? vlSelfRef.__PVT__rf_ram__DOT__memory
                                               [vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__o_raddr]
                                                : 0U)
                                            : 0U);
    if (vlSelfRef.__PVT__cpu__DOT__cpu__DOT__rf_if__DOT__o_wen0) {
        __Vdly__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_rd 
            = (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__rf_if__DOT__o_wdata0) 
                << 0x0000001fU) | (vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_rd 
                                   >> 1U));
    }
    if (vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__update_rd) {
        if ((0x00000010U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7))) {
            if ((8U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7))) {
                if ((4U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7))) {
                    if ((2U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7))) {
                        if ((1U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7))) {
                            vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x31 
                                = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_rd;
                        } else {
                            vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x30 
                                = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_rd;
                        }
                    } else if ((1U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7))) {
                        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x29 
                            = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_rd;
                    } else {
                        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x28 
                            = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_rd;
                    }
                } else if ((2U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7))) {
                    if ((1U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7))) {
                        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x27 
                            = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_rd;
                    } else {
                        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x26 
                            = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_rd;
                    }
                } else if ((1U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7))) {
                    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x25 
                        = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_rd;
                } else {
                    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x24 
                        = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_rd;
                }
            } else if ((4U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7))) {
                if ((2U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7))) {
                    if ((1U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7))) {
                        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x23 
                            = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_rd;
                    } else {
                        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x22 
                            = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_rd;
                    }
                } else if ((1U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7))) {
                    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x21 
                        = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_rd;
                } else {
                    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x20 
                        = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_rd;
                }
            } else if ((2U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7))) {
                if ((1U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7))) {
                    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x19 
                        = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_rd;
                } else {
                    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x18 
                        = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_rd;
                }
            } else if ((1U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7))) {
                vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x17 
                    = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_rd;
            } else {
                vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x16 
                    = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_rd;
            }
        } else if ((8U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7))) {
            if ((4U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7))) {
                if ((2U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7))) {
                    if ((1U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7))) {
                        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x15 
                            = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_rd;
                    } else {
                        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x14 
                            = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_rd;
                    }
                } else if ((1U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7))) {
                    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x13 
                        = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_rd;
                } else {
                    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x12 
                        = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_rd;
                }
            } else if ((2U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7))) {
                if ((1U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7))) {
                    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x11 
                        = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_rd;
                } else {
                    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x10 
                        = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_rd;
                }
            } else if ((1U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7))) {
                vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x9 
                    = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_rd;
            } else {
                vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x8 
                    = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_rd;
            }
        } else if ((4U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7))) {
            if ((2U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7))) {
                if ((1U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7))) {
                    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x7 
                        = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_rd;
                } else {
                    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x6 
                        = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_rd;
                }
            } else if ((1U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7))) {
                vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x5 
                    = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_rd;
            } else {
                vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x4 
                    = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_rd;
            }
        } else if ((2U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7))) {
            if ((1U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7))) {
                vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x3 
                    = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_rd;
            } else {
                vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x2 
                    = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_rd;
            }
        } else if ((1U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7))) {
            vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__x1 
                = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_rd;
        }
    }
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__alu__DOT__add_cy_r = 0U;
    if ((0U != (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb))) {
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__alu__DOT__cmp_r 
            = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__alu__DOT__o_cmp;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__alu__DOT__add_cy_r 
            = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__alu__DOT__add_cy;
        __Vdly__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_csr 
            = (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__o_csr_in) 
                << 0x0000001fU) | (vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_csr 
                                   >> 1U));
    } else {
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__alu__DOT__add_cy_r 
            = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__alu__DOT__i_sub;
    }
    if (vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__update_mscratch) {
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_mscratch 
            = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_csr;
    }
    if (vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__update_mtvec) {
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_mtvec 
            = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_csr;
    }
    if (vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__update_mepc) {
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_mepc 
            = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_csr;
    }
    if (vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__update_mtval) {
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_mtval 
            = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_csr;
    }
    if (vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__update_mstatus) {
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_mstatus 
            = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_csr;
    }
    if (vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__update_mie) {
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_mie 
            = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_csr;
    }
    if (vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__update_mcause) {
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_mcause 
            = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_csr;
    }
    vlSelfRef.__PVT__wb_gpio_rdt = vlSelfRef.__PVT__q;
    vlSelfRef.__PVT__timer_irq = VL_LTES_III(32, 0U, 
                                             (vlSelfRef.__PVT__timer__DOT__mtime 
                                              - vlSelfRef.__PVT__timer__DOT__mtimecmp));
    if (((((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_mcause_en) 
           & (0U != (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb))) 
          & (0U == (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt))) 
         | ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trap) 
            & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt_done)))) {
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mcause3_0__BRA__0__KET__ 
            = (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__new_irq) 
                | (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_e_op)) 
               | ((~ (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trap)) 
                  & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mcause3_0__BRA__1__KET__)));
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mcause3_0__BRA__1__KET__ 
            = (1U & ((((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__new_irq) 
                       | (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_e_op)) 
                      | (IData)((8U == (0x18U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode))))) 
                     | ((~ (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trap)) 
                        & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mcause3_0__BRA__2__KET__))));
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mcause3_0__BRA__2__KET__ 
            = (1U & (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__new_irq) 
                      | (~ ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode) 
                            >> 4U))) | ((~ (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trap)) 
                                        & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mcause3_0__BRA__3__KET__))));
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mcause3_0__BRA__3__KET__ 
            = (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_e_op) 
                & (~ (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__op20))) 
               | ((~ (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trap)) 
                  & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__o_csr_in)));
    }
    if ((((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_mcause_en) 
          & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt_done)) 
         | (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trap))) {
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mcause31 
            = ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trap)
                ? (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__new_irq)
                : (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__o_csr_in));
    }
    vlSelfRef.__PVT__wb_ext_ack = __Vdly__wb_ext_ack;
    if (vlSymsp->TOP.wb_rst) {
        __Vdly__cpu__DOT__mux__DOT__sim_ack = 0U;
    }
    vlSelfRef.__PVT__cpu__DOT__mux__DOT__sim_ack = __Vdly__cpu__DOT__mux__DOT__sim_ack;
    vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__wdata1_r 
        = __Vdly__cpu__DOT__rf_ram_if__DOT__wdata1_r;
    vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__wdata0_r 
        = __Vdly__cpu__DOT__rf_ram_if__DOT__wdata0_r;
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm30_25 
        = __Vdly__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm30_25;
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm19_12_20 
        = __Vdly__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm19_12_20;
    if (__VdlySet__rf_ram__DOT__memory__v0) {
        vlSelfRef.__PVT__rf_ram__DOT__memory[__VdlyDim0__rf_ram__DOT__memory__v0] 
            = __VdlyVal__rf_ram__DOT__memory__v0;
    }
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_rd 
        = __Vdly__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_rd;
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7 
        = __Vdly__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7;
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_csr 
        = __Vdly__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__dbg_csr;
    vlSelfRef.__PVT__timer__DOT__mtime = __Vdly__timer__DOT__mtime;
    if ((((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__shift_en) 
          | (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__cnt_en)) 
         | (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__i_load))) {
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dhi 
            = (0x000000ffU & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__i_load)
                               ? (vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__i_dat 
                                  >> 0x18U) : ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dat_shamt) 
                                               & (0x000000dfU 
                                                  | (0x00000020U 
                                                     & ((~ 
                                                         (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_shift_op) 
                                                           & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__i_cnt7)) 
                                                          & (~ (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__cnt_en)))) 
                                                        << 5U))))));
    }
    if (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trap) 
         & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt_done))) {
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mstatus_mpie 
            = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mstatus_mie;
    }
    vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__rgnt 
        = vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__rreq_r;
    if (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trig_irq) 
         | (0U != (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb)))) {
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm7 
            = (1U & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trig_irq)
                      ? (vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt 
                         >> 7U) : (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__signbit)));
    }
    if (((0x0000001fU == (IData)(vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__rcnt)) 
         | (IData)(vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__i_rreq))) {
        vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__rgate 
            = vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__i_rreq;
    }
    __Vdly__cpu__DOT__rf_ram_if__DOT__rcnt = (0x0000001fU 
                                              & ((IData)(1U) 
                                                 + (IData)(vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__rcnt)));
    if (((IData)(vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__i_rreq) 
         | (IData)(vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__i_wreq))) {
        __Vdly__cpu__DOT__rf_ram_if__DOT__rcnt = ((IData)(vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__i_wreq) 
                                                  << 1U);
    }
    if (vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__rtrig1) {
        vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__rdata1 
            = (1U & ((IData)(vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__i_rdata) 
                     >> 1U));
    }
    vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__i_rdata 
        = ((~ (- (IData)((IData)(vlSelfRef.__PVT__rf_ram__DOT__regzero)))) 
           & (IData)(vlSelfRef.__PVT__rf_ram__DOT__rdata));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_ibus_cyc 
        = ((~ (IData)(vlSymsp->TOP.wb_rst)) & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__ibus_cyc));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__update_rd 
        = ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt_done) 
           & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__rf_if__DOT__o_wen0));
    vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__rtrig1 
        = (1U & (IData)(vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__rcnt));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__i_rs2 
        = (1U & ((IData)(vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__rtrig1)
                  ? (IData)(vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__i_rdata)
                  : (IData)(vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__rdata1)));
    if (vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trig_irq) {
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__imm25 
            = (1U & (vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt 
                     >> 0x00000019U));
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__OTHER = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__CSRRCI = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__CSRRSI = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__CSRRWI = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__CSRRC = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__CSRRS = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__CSRRW = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__EBREAK = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__ECALL = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__FENCE = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__AND = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__OR = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SRA = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SRL = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__XOR = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SLTU = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SLT = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SLL = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SUB = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__BLTU = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__LH = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__LB = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__BLT = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__BGEU = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__BGE = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__BNE = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__BEQ = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__JALR = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__JAL = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__AUIPC = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__LUI = 0U;
        if (((((((((0x00000037U == (0x0000007fU & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt)) 
                   | (0x00000017U == (0x0000007fU & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                  | (0x0000006fU == (0x0000007fU & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                 | (0x00000067U == (0x0000707fU & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                | (0x00000063U == (0x0000707fU & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
               | (0x00001063U == (0x0000707fU & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
              | (0x00004063U == (0x0000707fU & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
             | (0x00005063U == (0x0000707fU & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt)))) {
            if ((0x00000037U != (0x0000007fU & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                if ((0x00000017U != (0x0000007fU & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                    if ((0x0000006fU != (0x0000007fU 
                                         & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                        if ((0x00000067U != (0x0000707fU 
                                             & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                            if ((0x00000063U != (0x0000707fU 
                                                 & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                if ((0x00001063U != 
                                     (0x0000707fU & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                    if ((0x00004063U 
                                         == (0x0000707fU 
                                             & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__BLT = 1U;
                                    }
                                    if ((0x00004063U 
                                         != (0x0000707fU 
                                             & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__BGE = 1U;
                                    }
                                }
                                if ((0x00001063U == 
                                     (0x0000707fU & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__BNE = 1U;
                                }
                            }
                            if ((0x00000063U == (0x0000707fU 
                                                 & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__BEQ = 1U;
                            }
                        }
                        if ((0x00000067U == (0x0000707fU 
                                             & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                            vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__JALR = 1U;
                        }
                    }
                    if ((0x0000006fU == (0x0000007fU 
                                         & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__JAL = 1U;
                    }
                }
                if ((0x00000017U == (0x0000007fU & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__AUIPC = 1U;
                }
            }
            if ((0x00000037U == (0x0000007fU & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__LUI = 1U;
            }
        }
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__LW = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__LBU = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__LHU = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SB = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SH = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SW = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__ADDI = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SLTI = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SLTIU = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__XORI = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__ORI = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__ANDI = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SLLI = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SRLI = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SRAI = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__ADD = 0U;
        if ((1U & (~ ((((((((0x00000037U == (0x0000007fU 
                                             & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt)) 
                            | (0x00000017U == (0x0000007fU 
                                               & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                           | (0x0000006fU == (0x0000007fU 
                                              & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                          | (0x00000067U == (0x0000707fU 
                                             & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                         | (0x00000063U == (0x0000707fU 
                                            & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                        | (0x00001063U == (0x0000707fU 
                                           & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                       | (0x00004063U == (0x0000707fU 
                                          & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                      | (0x00005063U == (0x0000707fU 
                                         & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt)))))) {
            if ((1U & (~ ((((((((0x00006063U == (0x0000707fU 
                                                 & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt)) 
                                | (0x00007063U == (0x0000707fU 
                                                   & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                               | (3U == (0x0000707fU 
                                         & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                              | (0x00001003U == (0x0000707fU 
                                                 & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                             | (0x00002003U == (0x0000707fU 
                                                & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                            | (0x00004003U == (0x0000707fU 
                                               & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                           | (0x00005003U == (0x0000707fU 
                                              & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                          | (0x00000023U == (0x0000707fU 
                                             & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt)))))) {
                if ((1U & (~ ((((((((0x00001023U == 
                                     (0x0000707fU & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt)) 
                                    | (0x00002023U 
                                       == (0x0000707fU 
                                           & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                                   | (0x00000013U == 
                                      (0x0000707fU 
                                       & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                                  | (0x00002013U == 
                                     (0x0000707fU & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                                 | (0x00003013U == 
                                    (0x0000707fU & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                                | (0x00004013U == (0x0000707fU 
                                                   & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                               | (0x00006013U == (0x0000707fU 
                                                  & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                              | (0x00007013U == (0x0000707fU 
                                                 & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt)))))) {
                    if ((1U & (~ ((((((((0x00001013U 
                                         == (0xfe00707fU 
                                             & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt)) 
                                        | (0x00005013U 
                                           == (0xfe00707fU 
                                               & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                                       | (0x40005013U 
                                          == (0xfe00707fU 
                                              & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                                      | (0x00000033U 
                                         == (0xfe00707fU 
                                             & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                                     | (0x40000033U 
                                        == (0xfe00707fU 
                                            & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                                    | (0x00001033U 
                                       == (0xfe00707fU 
                                           & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                                   | (0x00002033U == 
                                      (0xfe00707fU 
                                       & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                                  | (0x00003033U == 
                                     (0xfe00707fU & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt)))))) {
                        if ((1U & (~ ((((((((0x00004033U 
                                             == (0x0000707fU 
                                                 & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt)) 
                                            | (0x00005033U 
                                               == (0xfe00707fU 
                                                   & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                                           | (0x40005033U 
                                              == (0xfe00707fU 
                                                  & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                                          | (0x00006033U 
                                             == (0x0000707fU 
                                                 & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                                         | (0x00007033U 
                                            == (0x0000707fU 
                                                & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                                        | (0x0000000fU 
                                           == (0x0000707fU 
                                               & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                                       | (0x00000073U 
                                          == vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt)) 
                                      | (0x00100073U 
                                         == vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))))) {
                            if ((0x00001073U != (0x0000707fU 
                                                 & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                if ((0x00002073U != 
                                     (0x0000707fU & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                    if ((0x00003073U 
                                         != (0x0000707fU 
                                             & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                        if ((0x00005073U 
                                             != (0x0000707fU 
                                                 & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                            if ((0x00006073U 
                                                 != 
                                                 (0x0000707fU 
                                                  & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                                if (
                                                    (0x00007073U 
                                                     != 
                                                     (0x0000707fU 
                                                      & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                                    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__OTHER = 1U;
                                                }
                                                if (
                                                    (0x00007073U 
                                                     == 
                                                     (0x0000707fU 
                                                      & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                                    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__CSRRCI = 1U;
                                                }
                                            }
                                            if ((0x00006073U 
                                                 == 
                                                 (0x0000707fU 
                                                  & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                                vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__CSRRSI = 1U;
                                            }
                                        }
                                        if ((0x00005073U 
                                             == (0x0000707fU 
                                                 & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                            vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__CSRRWI = 1U;
                                        }
                                    }
                                    if ((0x00003073U 
                                         == (0x0000707fU 
                                             & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__CSRRC = 1U;
                                    }
                                }
                                if ((0x00002073U == 
                                     (0x0000707fU & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__CSRRS = 1U;
                                }
                            }
                            if ((0x00001073U == (0x0000707fU 
                                                 & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__CSRRW = 1U;
                            }
                        }
                        if (((((((((0x00004033U == 
                                    (0x0000707fU & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt)) 
                                   | (0x00005033U == 
                                      (0xfe00707fU 
                                       & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                                  | (0x40005033U == 
                                     (0xfe00707fU & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                                 | (0x00006033U == 
                                    (0x0000707fU & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                                | (0x00007033U == (0x0000707fU 
                                                   & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                               | (0x0000000fU == (0x0000707fU 
                                                  & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                              | (0x00000073U == vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt)) 
                             | (0x00100073U == vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                            if ((0x00004033U != (0x0000707fU 
                                                 & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                if ((0x00005033U != 
                                     (0xfe00707fU & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                    if ((0x40005033U 
                                         != (0xfe00707fU 
                                             & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                        if ((0x00006033U 
                                             != (0x0000707fU 
                                                 & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                            if ((0x00007033U 
                                                 != 
                                                 (0x0000707fU 
                                                  & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                                if (
                                                    (0x0000000fU 
                                                     != 
                                                     (0x0000707fU 
                                                      & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                                    if (
                                                        (0x00000073U 
                                                         != vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt)) {
                                                        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__EBREAK = 1U;
                                                    }
                                                    if (
                                                        (0x00000073U 
                                                         == vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt)) {
                                                        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__ECALL = 1U;
                                                    }
                                                }
                                                if (
                                                    (0x0000000fU 
                                                     == 
                                                     (0x0000707fU 
                                                      & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                                    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__FENCE = 1U;
                                                }
                                            }
                                            if ((0x00007033U 
                                                 == 
                                                 (0x0000707fU 
                                                  & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                                vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__AND = 1U;
                                            }
                                        }
                                        if ((0x00006033U 
                                             == (0x0000707fU 
                                                 & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                            vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__OR = 1U;
                                        }
                                    }
                                    if ((0x40005033U 
                                         == (0xfe00707fU 
                                             & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SRA = 1U;
                                    }
                                }
                                if ((0x00005033U == 
                                     (0xfe00707fU & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SRL = 1U;
                                }
                            }
                            if ((0x00004033U == (0x0000707fU 
                                                 & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__XOR = 1U;
                            }
                        }
                    }
                    if (((((((((0x00001013U == (0xfe00707fU 
                                                & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt)) 
                               | (0x00005013U == (0xfe00707fU 
                                                  & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                              | (0x40005013U == (0xfe00707fU 
                                                 & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                             | (0x00000033U == (0xfe00707fU 
                                                & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                            | (0x40000033U == (0xfe00707fU 
                                               & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                           | (0x00001033U == (0xfe00707fU 
                                              & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                          | (0x00002033U == (0xfe00707fU 
                                             & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                         | (0x00003033U == (0xfe00707fU 
                                            & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt)))) {
                        if ((0x00001013U != (0xfe00707fU 
                                             & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                            if ((0x00005013U != (0xfe00707fU 
                                                 & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                if ((0x40005013U != 
                                     (0xfe00707fU & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                    if ((0x00000033U 
                                         != (0xfe00707fU 
                                             & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                        if ((0x40000033U 
                                             != (0xfe00707fU 
                                                 & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                            if ((0x00001033U 
                                                 != 
                                                 (0xfe00707fU 
                                                  & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                                if (
                                                    (0x00002033U 
                                                     != 
                                                     (0xfe00707fU 
                                                      & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                                    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SLTU = 1U;
                                                }
                                                if (
                                                    (0x00002033U 
                                                     == 
                                                     (0xfe00707fU 
                                                      & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                                    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SLT = 1U;
                                                }
                                            }
                                            if ((0x00001033U 
                                                 == 
                                                 (0xfe00707fU 
                                                  & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                                vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SLL = 1U;
                                            }
                                        }
                                        if ((0x40000033U 
                                             == (0xfe00707fU 
                                                 & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                            vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SUB = 1U;
                                        }
                                    }
                                    if ((0x00000033U 
                                         == (0xfe00707fU 
                                             & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__ADD = 1U;
                                    }
                                }
                                if ((0x40005013U == 
                                     (0xfe00707fU & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SRAI = 1U;
                                }
                            }
                            if ((0x00005013U == (0xfe00707fU 
                                                 & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SRLI = 1U;
                            }
                        }
                        if ((0x00001013U == (0xfe00707fU 
                                             & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                            vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SLLI = 1U;
                        }
                    }
                }
                if (((((((((0x00001023U == (0x0000707fU 
                                            & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt)) 
                           | (0x00002023U == (0x0000707fU 
                                              & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                          | (0x00000013U == (0x0000707fU 
                                             & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                         | (0x00002013U == (0x0000707fU 
                                            & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                        | (0x00003013U == (0x0000707fU 
                                           & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                       | (0x00004013U == (0x0000707fU 
                                          & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                      | (0x00006013U == (0x0000707fU 
                                         & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                     | (0x00007013U == (0x0000707fU 
                                        & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt)))) {
                    if ((0x00001023U == (0x0000707fU 
                                         & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SH = 1U;
                    }
                    if ((0x00001023U != (0x0000707fU 
                                         & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                        if ((0x00002023U == (0x0000707fU 
                                             & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                            vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SW = 1U;
                        }
                        if ((0x00002023U != (0x0000707fU 
                                             & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                            if ((0x00000013U == (0x0000707fU 
                                                 & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__ADDI = 1U;
                            }
                            if ((0x00000013U != (0x0000707fU 
                                                 & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                if ((0x00002013U == 
                                     (0x0000707fU & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SLTI = 1U;
                                }
                                if ((0x00002013U != 
                                     (0x0000707fU & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                    if ((0x00003013U 
                                         == (0x0000707fU 
                                             & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SLTIU = 1U;
                                    }
                                    if ((0x00003013U 
                                         != (0x0000707fU 
                                             & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                        if ((0x00004013U 
                                             == (0x0000707fU 
                                                 & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                            vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__XORI = 1U;
                                        }
                                        if ((0x00004013U 
                                             != (0x0000707fU 
                                                 & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                            if ((0x00006013U 
                                                 == 
                                                 (0x0000707fU 
                                                  & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                                vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__ORI = 1U;
                                            }
                                            if ((0x00006013U 
                                                 != 
                                                 (0x0000707fU 
                                                  & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                                vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__ANDI = 1U;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            if (((((((((0x00006063U == (0x0000707fU 
                                        & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt)) 
                       | (0x00007063U == (0x0000707fU 
                                          & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                      | (3U == (0x0000707fU & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                     | (0x00001003U == (0x0000707fU 
                                        & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                    | (0x00002003U == (0x0000707fU 
                                       & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                   | (0x00004003U == (0x0000707fU & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                  | (0x00005003U == (0x0000707fU & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) 
                 | (0x00000023U == (0x0000707fU & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt)))) {
                if ((0x00006063U == (0x0000707fU & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__BLTU = 1U;
                }
                if ((0x00006063U != (0x0000707fU & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                    if ((0x00007063U != (0x0000707fU 
                                         & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                        if ((3U != (0x0000707fU & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                            if ((0x00001003U == (0x0000707fU 
                                                 & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__LH = 1U;
                            }
                            if ((0x00001003U != (0x0000707fU 
                                                 & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                if ((0x00002003U == 
                                     (0x0000707fU & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__LW = 1U;
                                }
                                if ((0x00002003U != 
                                     (0x0000707fU & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                    if ((0x00004003U 
                                         == (0x0000707fU 
                                             & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__LBU = 1U;
                                    }
                                    if ((0x00004003U 
                                         != (0x0000707fU 
                                             & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                        if ((0x00005003U 
                                             == (0x0000707fU 
                                                 & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                            vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__LHU = 1U;
                                        }
                                        if ((0x00005003U 
                                             != (0x0000707fU 
                                                 & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                                            vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__SB = 1U;
                                        }
                                    }
                                }
                            }
                        }
                        if ((3U == (0x0000707fU & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                            vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__LB = 1U;
                        }
                    }
                    if ((0x00007063U == (0x0000707fU 
                                         & vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt))) {
                        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__BGEU = 1U;
                    }
                }
            }
        }
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__op22 
            = (1U & (vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt 
                     >> 0x00000016U));
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__imm30 
            = (1U & (vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt 
                     >> 0x0000001eU));
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__op26 
            = (1U & (vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt 
                     >> 0x0000001aU));
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__op21 
            = (1U & (vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt 
                     >> 0x00000015U));
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm31 
            = (vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt 
               >> 0x0000001fU);
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3 
            = (7U & (vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt 
                     >> 0x0000000cU));
    }
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__d 
        = (1U & ((4U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3))
                  ? ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm19_12_20) 
                     >> 4U) : (IData)(vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__rdata0)));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__alu__DOT__i_cmp_sig 
        = (1U & (~ (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                     >> 1U) & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                               | ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                                  >> 2U)))));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__update_mie 
        = ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt_done) 
           & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_mie_en));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__update_mstatus 
        = ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt_done) 
           & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_mstatus_en));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__update_mcause 
        = ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt_done) 
           & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_mcause_en));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__update_mscratch 
        = (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt_done) 
            & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_csr_en)) 
           & (0U == (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_csr_addr)));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__update_mtvec 
        = (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt_done) 
            & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_csr_en)) 
           & (1U == (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_csr_addr)));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__update_mepc 
        = (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt_done) 
            & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_csr_en)) 
           & (2U == (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_csr_addr)));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_debug__DOT__debug__DOT__update_mtval 
        = (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt_done) 
            & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_csr_en)) 
           & (3U == (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_csr_addr)));
    if ((((~ (vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
              >> 0x0000001fU)) & (IData)(vlSelfRef.__PVT__cpu__DOT__mux__DOT__o_wb_ext_stb)) 
         & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode) 
            >> 3U))) {
        vlSelfRef.__PVT__q = (1U & vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dlo);
    }
    if ((((IData)(vlSelfRef.__PVT__cpu__DOT__mux__DOT__o_wb_ext_stb) 
          & (vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
             >> 0x0000001fU)) & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode) 
                                 >> 3U))) {
        vlSelfRef.__PVT__timer__DOT__mtimecmp = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_dat;
    }
    if (vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trig_irq) {
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__new_irq 
            = ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__timer_irq) 
               & (~ (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__timer_irq_r)));
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode 
            = (0x0000001fU & (vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt 
                              >> 2U));
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__timer_irq_r 
            = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__timer_irq;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__op20 
            = (1U & (vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt 
                     >> 0x00000014U));
    }
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mstatus_mie 
        = __Vdly__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mstatus_mie;
    if (vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt_done) {
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__init_done 
            = ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_init) 
               & (~ (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__init_done)));
    }
    if (vlSymsp->TOP.wb_rst) {
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__init_done = 0U;
        __Vdly__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb = 0U;
        __Vdly__cpu__DOT__cpu__DOT__state__DOT__o_cnt = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mie_mtie = 0U;
    }
    if (vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt_done) {
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__jump = 
            ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_init) 
             & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__take_branch));
    }
    if (vlSymsp->TOP.wb_rst) {
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__jump = 0U;
        vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__rgnt = 0U;
        vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__rgate = 0U;
        __Vdly__cpu__DOT__rf_ram_if__DOT__rcnt = 0U;
        vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__rcnt 
            = __Vdly__cpu__DOT__rf_ram_if__DOT__rcnt;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dlo 
            = __Vdly__cpu__DOT__cpu__DOT__bufreg2__DOT__dlo;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt 
            = __Vdly__cpu__DOT__cpu__DOT__state__DOT__o_cnt;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb 
            = __Vdly__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb;
        vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__rreq_r 
            = vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__i_rreq;
        vlSelfRef.__PVT__timer__DOT__mtimecmp = 0U;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__new_irq = 0U;
        vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__rreq_r = 0U;
    } else {
        vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__rcnt 
            = __Vdly__cpu__DOT__rf_ram_if__DOT__rcnt;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dlo 
            = __Vdly__cpu__DOT__cpu__DOT__bufreg2__DOT__dlo;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt 
            = __Vdly__cpu__DOT__cpu__DOT__state__DOT__o_cnt;
        vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb 
            = __Vdly__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb;
        vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__rreq_r 
            = vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__i_rreq;
    }
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
        = vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a0;
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__mem_if__DOT__dat_valid 
        = (1U & (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                  >> 1U) | ((0U == (3U & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt) 
                                          >> 1U))) 
                            | ((~ ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt) 
                                   >> 2U)) & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3)))));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__i_cnt7 
        = ((1U == (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt)) 
           & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb) 
              >> 3U));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__i_cnt2 
        = ((0U == (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt)) 
           & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb) 
              >> 2U));
    vlSelfRef.cpu__DOT__cpu__DOT__state__DOT____VdfgRegularize_h76bd994c_0_1 
        = ((~ (0U != (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb))) 
           & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__init_done));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_cnt3 
        = ((0U == (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt)) 
           & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb) 
              >> 3U));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt0 
        = ((0U == (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt)) 
           & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt_done 
        = ((7U == (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt)) 
           & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb) 
              >> 3U));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__timer_irq 
        = ((IData)(vlSelfRef.__PVT__timer_irq) & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mie_mtie) 
                                                  & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mstatus_mie)));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__pc_plus_4_cy 
        = (1U & (((1U & vlSelfRef.__PVT__cpu__DOT__cpu__DOT__wb_ibus_adr) 
                  + ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__i_cnt2) 
                     + (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__pc_plus_4_cy_r))) 
                 >> 1U));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__pc_plus_4 
        = (1U & (vlSelfRef.__PVT__cpu__DOT__cpu__DOT__wb_ibus_adr 
                 + ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__i_cnt2) 
                    + (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__pc_plus_4_cy_r))));
    vlSelfRef.__VdfgRegularize_hd8275ffe_1_0 = ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt0) 
                                                | ((0U 
                                                    == (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt)) 
                                                   & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb) 
                                                      >> 1U)));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_q 
        = (((3U == (3U & vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1)) 
            & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dhi)) 
           | (((2U == (3U & vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1)) 
               & (vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dlo 
                  >> 0x00000010U)) | (((1U == (3U & vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1)) 
                                       & (vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dlo 
                                          >> 8U)) | 
                                      ((0U == (3U & vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1)) 
                                       & vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dlo))));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__mem_if__DOT__o_misalign 
        = (1U & ((vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                  & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                     | ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                        >> 1U))) | ((vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                     & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3)) 
                                    >> 1U)));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_immdec_ctrl 
        = ((((2U & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode) 
                    >> 3U)) | (IData)((0x10U == (0x11U 
                                                 & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode))))) 
            << 2U) | ((((0U == (3U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode))) 
                        | (0U == (3U & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode) 
                                        >> 1U)))) << 1U) 
                      | (8U == (0x0000000fU & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode)))));
    vlSelfRef.__PVT__cpu__DOT__mux__DOT__halt_en = 
        (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode) 
          >> 3U) & (0x24000000U == (vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                    >> 2U)));
    vlSelfRef.__PVT__cpu__DOT__mux__DOT__sig_en = (
                                                   (0U 
                                                    != vlSelfRef.__PVT__cpu__DOT__mux__DOT__genblk1__DOT__f) 
                                                   & (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode) 
                                                       >> 3U) 
                                                      & (0x20000000U 
                                                         == 
                                                         (vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                                          >> 2U))));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_rd_alu_en 
        = (IData)((4U == (0x15U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode))));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__i_jal_or_jalr 
        = (IData)((0x11U == (0x11U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode))));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_dbus_en 
        = (IData)((0U == (0x14U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode))));
    cpu__DOT__cpu__DOT__decode__DOT____VdfgRegularize_h6d71b89f_0_11 
        = (IData)((5U == (5U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode))));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__alu__DOT__i_sub 
        = (1U & (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                  >> 1U) | ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                            | ((((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode) 
                                 >> 3U) & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__imm30)) 
                               | ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode) 
                                  >> 4U)))));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_shift_op 
        = (1U & ((~ ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                     >> 1U)) & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode) 
                                >> 2U)));
    cpu__DOT__cpu__DOT__decode__DOT____VdfgRegularize_h6d71b89f_0_13 
        = (IData)((0U == (0x11U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode))));
    vlSelfRef.cpu__DOT__cpu__DOT__decode__DOT____VdfgRegularize_h6d71b89f_0_4 
        = (IData)((0x14U == (0x14U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode))));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_csr_addr 
        = ((((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__op20) 
             & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__op26)) 
            << 1U) | (1U & ((~ (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__op26)) 
                            | (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__op21))));
    vlSelfRef.cpu__DOT__mux__DOT____VdfgRegularize_h2b1522d7_0_0 
        = (1U & (~ ((IData)(vlSelfRef.__PVT__cpu__DOT__mux__DOT__sig_en) 
                    | (IData)(vlSelfRef.__PVT__cpu__DOT__mux__DOT__halt_en))));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_rd_op 
        = (1U & (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode) 
                  >> 2U) | ((~ ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode) 
                                >> 2U)) & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__i_jal_or_jalr) 
                                           | (IData)(
                                                     (0U 
                                                      == 
                                                      (9U 
                                                       & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode))))))));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_dbus_cyc 
        = ((IData)(vlSelfRef.cpu__DOT__cpu__DOT__state__DOT____VdfgRegularize_h76bd994c_0_1) 
           & ((~ (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__mem_if__DOT__o_misalign)) 
              & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_dbus_en)));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__i_utype 
        = ((~ ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode) 
               >> 4U)) & (IData)(cpu__DOT__cpu__DOT__decode__DOT____VdfgRegularize_h6d71b89f_0_11));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_two_stage_op 
        = (1U & ((~ ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode) 
                     >> 2U)) | ((IData)(((1U == (3U 
                                                 & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3))) 
                                         & (IData)(cpu__DOT__cpu__DOT__decode__DOT____VdfgRegularize_h6d71b89f_0_13))) 
                                | (IData)(((2U == (6U 
                                                   & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3))) 
                                           & (IData)(cpu__DOT__cpu__DOT__decode__DOT____VdfgRegularize_h6d71b89f_0_13))))));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_mret 
        = ((IData)(vlSelfRef.cpu__DOT__cpu__DOT__decode__DOT____VdfgRegularize_h6d71b89f_0_4) 
           & ((~ (0U != (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3))) 
              & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__op21)));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__offset_a 
        = (((0U == (7U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode))) 
            | ((3U == (3U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode))) 
               | (((IData)(vlSelfRef.cpu__DOT__cpu__DOT__decode__DOT____VdfgRegularize_h6d71b89f_0_4) 
                   & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__op20)) 
                  | (0U == (3U & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode) 
                                  >> 3U)))))) & vlSelfRef.__PVT__cpu__DOT__cpu__DOT__wb_ibus_adr);
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_e_op 
        = ((IData)(vlSelfRef.cpu__DOT__cpu__DOT__decode__DOT____VdfgRegularize_h6d71b89f_0_4) 
           & ((~ (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__op21)) 
              & (~ (0U != (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3)))));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_rd_csr_en 
        = ((IData)(vlSelfRef.cpu__DOT__cpu__DOT__decode__DOT____VdfgRegularize_h6d71b89f_0_4) 
           & (0U != (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3)));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_csr_imm_en 
        = ((IData)(vlSelfRef.cpu__DOT__cpu__DOT__decode__DOT____VdfgRegularize_h6d71b89f_0_4) 
           & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
              >> 2U));
    vlSelfRef.__PVT__cpu__DOT__mux__DOT__o_wb_ext_stb 
        = ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_dbus_cyc) 
           & ((IData)(vlSelfRef.cpu__DOT__mux__DOT____VdfgRegularize_h2b1522d7_0_0) 
              & (0U != (vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                        >> 0x0000001eU))));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_init 
        = ((~ ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__new_irq) 
               | (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__init_done))) 
           & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_two_stage_op));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trap 
        = ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_e_op) 
           | ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__new_irq) 
              | (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_csr__DOT__misalign_trap_sync_r)));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_mcause_en 
        = ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_rd_csr_en) 
           & ((~ (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__op20)) 
              & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__op21)));
    cpu__DOT__cpu__DOT__decode__DOT____VdfgRegularize_h6d71b89f_0_12 
        = ((~ (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__op26)) 
           & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_rd_csr_en));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_csr_en 
        = ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_rd_csr_en) 
           & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__op20) 
              | ((~ (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__op21)) 
                 & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__op26))));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_immdec_en 
        = ((((IData)((1U != (0x1dU & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode)))) 
             << 3U) | (((IData)(vlSelfRef.cpu__DOT__cpu__DOT__decode__DOT____VdfgRegularize_h6d71b89f_0_4) 
                        | (8U != (9U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode)))) 
                       << 2U)) | ((((1U == (3U & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode) 
                                                  >> 1U))) 
                                    | ((IData)(cpu__DOT__cpu__DOT__decode__DOT____VdfgRegularize_h6d71b89f_0_11) 
                                       | (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_csr_imm_en))) 
                                   << 1U) | (1U & (~ (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_rd_op)))));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__signbit 
        = ((~ (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_csr_imm_en)) 
           & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm31));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_imm 
        = (1U & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt_done)
                  ? (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__signbit)
                  : ((8U == (0x0000000fU & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode)))
                      ? (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7)
                      : (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm24_20))));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__i_pc_en 
        = ((~ (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_init)) 
           & (0U != (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb)));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__shift_en 
        = ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_shift_op)
            ? ((0U != (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb)) 
               & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_init) 
                  & (0U == (6U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt)))))
            : ((0U != (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb)) 
               & ((IData)((0U == (3U & vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1))) 
                  | ((IData)((0U == (6U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt)))) 
                     | (((~ ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt) 
                             >> 2U)) & (~ (vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                           >> 1U))) 
                        | (((~ ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt) 
                                >> 2U)) & (~ vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1)) 
                           | ((~ ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt) 
                                  >> 1U)) & (~ (vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                                >> 1U)))))))));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__last_init 
        = ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt_done) 
           & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_init));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__cnt_en 
        = ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_shift_op) 
           & ((~ (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_init)) 
              | ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt_done) 
                 & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                    >> 2U))));
    vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__o_waddr 
        = ((((1U & (IData)(vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__rcnt))
              ? ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trap)
                  ? 0x22U : (0x00000020U | (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_csr_addr)))
              : ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trap)
                  ? 0x23U : (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7))) 
            << 4U) | (0x0000000fU & (((IData)(vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__rcnt) 
                                      - (IData)(4U)) 
                                     >> 1U)));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__rf_if__DOT__o_wen0 
        = ((0U != (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb)) 
           & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trap) 
              | (((~ (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_init)) 
                  & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_rd_op)) 
                 & (0U != (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm11_7)))));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_mie_en 
        = ((IData)(cpu__DOT__cpu__DOT__decode__DOT____VdfgRegularize_h6d71b89f_0_12) 
           & ((~ (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__op20)) 
              & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__op22)));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_mstatus_en 
        = ((IData)(cpu__DOT__cpu__DOT__decode__DOT____VdfgRegularize_h6d71b89f_0_12) 
           & ((~ (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__op22)) 
              & (~ (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__op20))));
    vlSelfRef.cpu__DOT__cpu__DOT__rf_if__DOT____VdfgRegularize_h1739b917_0_0 
        = ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trap) 
           | ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_csr_en) 
              | (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_mret)));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__o_q 
        = (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_mstatus_en) 
            & ((0U != (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb)) 
               & (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_cnt3) 
                   & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mstatus_mie)) 
                  | (((2U == (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt)) 
                      & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb) 
                         >> 3U)) | ((3U == (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt)) 
                                    & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb)))))) 
           | (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_csr_en) 
               & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__i_rs2)) 
              | ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_mcause_en) 
                 & ((0U != (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb)) 
                    & ((0U == (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt))
                        ? (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mcause3_0__BRA__0__KET__)
                        : ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt_done) 
                           & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__mcause31)))))));
    vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__o_raddr 
        = ((((1U & (IData)(vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__rcnt))
              ? (((IData)(vlSelfRef.cpu__DOT__cpu__DOT__rf_if__DOT____VdfgRegularize_h1739b917_0_0) 
                  << 5U) | ((0x0000001cU & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm24_20) 
                                            & ((- (IData)(
                                                          (1U 
                                                           & (~ (IData)(vlSelfRef.cpu__DOT__cpu__DOT__rf_if__DOT____VdfgRegularize_h1739b917_0_0))))) 
                                               << 2U))) 
                            | (3U & ((((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_mret) 
                                       << 1U) | (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trap)) 
                                     | (((- (IData)((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_csr_en))) 
                                         & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_csr_addr)) 
                                        | ((- (IData)(
                                                      (1U 
                                                       & (~ (IData)(vlSelfRef.cpu__DOT__cpu__DOT__rf_if__DOT____VdfgRegularize_h1739b917_0_0))))) 
                                           & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm24_20)))))))
              : (0x0000001fU & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__immdec__DOT__gen_immdec_w_eq_1__DOT__imm19_12_20) 
                                >> 4U))) << 4U) | (0x0000000fU 
                                                   & ((IData)(vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__rcnt) 
                                                      >> 1U)));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_carry_and_sum_a0 
        = (3U & ((1U & ((IData)(vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__rdata0) 
                        & ((~ ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode) 
                               >> 4U)) | (IData)((1U 
                                                  == 
                                                  (3U 
                                                   & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode))))))) 
                 + (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_imm) 
                     & ((~ ((((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode) 
                              >> 4U) & ((0U == (3U 
                                                & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode))) 
                                        | (3U == (3U 
                                                  & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode))))) 
                            & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt0))) 
                        & (~ ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode) 
                              >> 2U)))) + (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_cr_in_a1))));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_op_b 
        = ((8U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode))
            ? (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__i_rs2)
            : (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_imm));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__o_csr_in 
        = ((1U == (3U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3)))
            ? (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__d)
            : ((2U == (3U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3)))
                ? ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__o_q) 
                   | (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__d))
                : ((3U == (3U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3)))
                    ? ((~ (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__d)) 
                       & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__o_q))
                    : ((0U == (3U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3))) 
                       & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__o_q)))));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__alu__DOT__add_b 
        = ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_op_b) 
           ^ (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__alu__DOT__i_sub));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dat_shamt 
        = ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__cnt_en)
            ? (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_op_b) 
                << 7U) | ((0x00000040U & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dhi) 
                                          >> 1U)) | 
                          (0x0000003fU & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dhi) 
                                          - (IData)(1U)))))
            : (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_op_b) 
                << 7U) | (0x0000007fU & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dhi) 
                                         >> 1U))));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__alu__DOT__add_cy 
        = (1U & (((1U & (IData)(vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__rdata0)) 
                  + ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__alu__DOT__add_b) 
                     + (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__alu__DOT__add_cy_r))) 
                 >> 1U));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__alu__DOT__result_add 
        = (1U & ((IData)(vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__rdata0) 
                 + ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__alu__DOT__add_b) 
                    + (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__alu__DOT__add_cy_r))));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_en 
        = (((0U != (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__gen_cnt_w_eq_1__DOT__cnt_lsb)) 
            & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_init) 
               | (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trap) 
                   | ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode) 
                      >> 4U)) & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_two_stage_op)))) 
           | ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_shift_op) 
              & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__init_done) 
                 & (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dat_shamt) 
                     >> 5U) | ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                               >> 2U)))));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__alu__DOT__o_cmp 
        = (1U & ((0U == (3U & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                               >> 1U))) ? ((~ (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__alu__DOT__result_add)) 
                                           & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__alu__DOT__cmp_r) 
                                              | (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt0)))
                  : (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__alu__DOT__i_cmp_sig) 
                      & (IData)(vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__rdata0)) 
                     + ((~ ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__alu__DOT__i_cmp_sig) 
                            & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_op_b))) 
                        + (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__alu__DOT__add_cy)))));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_lsb_a0 
        = (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt0) 
            & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_en))
            ? (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_carry_and_sum_a0)
            : (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_lsb_a1));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_tail_a0 
        = (7U & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_en)
                  ? ((vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                      >> 1U) & (- (IData)((1U & (~ (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt_done))))))
                  : (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_tail_a1)));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a0 
        = ((((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_en)
              ? ((0x20000000U & (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_init)
                                   ? (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_carry_and_sum_a0)
                                   : ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__imm30) 
                                      & (vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                         >> 0x0000001fU))) 
                                 << 0x0000001dU)) | 
                 (vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                  >> 3U)) : (vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                             >> 2U)) << 2U) | (3U & 
                                               (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_init)
                                                  ? (IData)(vlSelfRef.__VdfgRegularize_hd8275ffe_1_0)
                                                  : (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_en))
                                                 ? 
                                                ((2U 
                                                  & (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_init)
                                                       ? (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_carry_and_sum_a0)
                                                       : 
                                                      (vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                                       >> 2U)) 
                                                     << 1U)) 
                                                 | (1U 
                                                    & (vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                                       >> 1U)))
                                                 : vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1)));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__o_q 
        = (vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
           & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_en));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__take_branch 
        = (IData)((((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode) 
                    >> 4U) & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode) 
                              | ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__alu__DOT__o_cmp) 
                                 ^ (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3)))));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__offset_b 
        = ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__i_utype)
            ? ((((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt) 
                 >> 2U) | (3U == (3U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_cnt)))) 
               & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_imm))
            : (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__o_q));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__trap_pending 
        = (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__take_branch) 
            & (vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
               >> 1U)) | ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_dbus_en) 
                          & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__mem_if__DOT__o_misalign)));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__pc_plus_offset_cy 
        = (1U & (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__offset_a) 
                  + ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__offset_b) 
                     + (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__pc_plus_offset_cy_r))) 
                 >> 1U));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__o_bad_pc 
        = (1U & ((~ (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt0)) 
                 & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__offset_a) 
                    + ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__offset_b) 
                       + (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__pc_plus_offset_cy_r)))));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__rf_if__DOT__o_wdata0 
        = ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trap)
            ? ((0x00000010U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode))
                ? (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__o_bad_pc)
                : (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__o_q))
            : ((((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__o_q) 
                 | (((0U == (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3)) 
                     & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__alu__DOT__result_add)) 
                    | ((IData)((((2U == (6U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3))) 
                                 & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__alu__DOT__cmp_r)) 
                                & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_cnt0))) 
                       | (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                           >> 2U) & (((~ (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3)) 
                                      & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_op_b) 
                                         ^ (IData)(vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__rdata0))) 
                                     | (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                                         >> 1U) & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_op_b) 
                                                   & (IData)(vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__rdata0)))))))) 
                & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_rd_alu_en)) 
               | (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__o_q) 
                   & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_rd_csr_en)) 
                  | ((((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__mem_if__DOT__dat_valid)
                        ? (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_q)
                        : ((~ ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3) 
                               >> 2U)) & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__mem_if__DOT__signbit))) 
                      & (IData)((0U == (5U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode))))) 
                     | (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__i_utype) 
                         & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__o_bad_pc)) 
                        | ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__pc_plus_4) 
                           & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__ctrl__DOT__i_jal_or_jalr)))))));
}

void Vservant_sim_servant__Mz1_Dz2_S1_Cz3_Az3___nba_sequent__TOP__servant_sim__dut__1(Vservant_sim_servant__Mz1_Dz2_S1_Cz3_Az3* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+        Vservant_sim_servant__Mz1_Dz2_S1_Cz3_Az3___nba_sequent__TOP__servant_sim__dut__1\n"); );
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__PVT__cpu__DOT__arbiter__DOT__o_wb_mem_stb 
        = (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_dbus_cyc) 
            & ((0U == (vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                       >> 0x0000001eU)) & (IData)(vlSelfRef.cpu__DOT__mux__DOT____VdfgRegularize_h2b1522d7_0_0))) 
           | (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_ibus_cyc));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__o_dat 
        = (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dhi) 
            << 0x00000018U) | vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dlo);
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__i_load 
        = ((IData)(vlSelfRef.__PVT__wb_ext_ack) | (
                                                   ((~ (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_ibus_cyc)) 
                                                    & (IData)(vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_ack)) 
                                                   | (IData)(vlSelfRef.__PVT__cpu__DOT__mux__DOT__sim_ack)));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trig_irq 
        = ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__o_ibus_cyc) 
           & (IData)(vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_ack));
    vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__i_dat 
        = ((0U != (vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                   >> 0x0000001eU)) ? ((vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__L0_data_a1 
                                        >> 0x0000001fU)
                                        ? vlSelfRef.__PVT__timer__DOT__mtime
                                        : (IData)(vlSelfRef.__PVT__wb_gpio_rdt))
            : vlSymsp->TOP__servant_sim__dut__ram.__PVT__o_wb_rdt);
    vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__i_wreq 
        = (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg__DOT__i_shift_op) 
            & ((4U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3))
                ? (((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__dat_shamt) 
                    >> 5U) & ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__last_init) 
                              | (IData)(vlSelfRef.cpu__DOT__cpu__DOT__state__DOT____VdfgRegularize_h76bd994c_0_1)))
                : (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__last_init))) 
           | ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__bufreg2__DOT__i_load) 
              | ((((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__opcode) 
                   >> 4U) & ((~ (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__trap_pending)) 
                             & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__last_init))) 
                 | ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__o_rd_alu_en) 
                    & (IData)(((2U == (6U & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__decode__DOT__funct3))) 
                               & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__last_init)))))));
    vlSelfRef.__PVT__cpu__DOT__rf_ram_if__DOT__i_rreq 
        = ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__gen_csr__DOT__csr__DOT__i_trig_irq) 
           | ((IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__trap_pending) 
              & (IData)(vlSelfRef.__PVT__cpu__DOT__cpu__DOT__state__DOT__last_init)));
}
