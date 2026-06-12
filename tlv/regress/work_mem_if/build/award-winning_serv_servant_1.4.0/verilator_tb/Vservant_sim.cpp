// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "Vservant_sim__pch.h"
#include "verilated_vcd_c.h"

//============================================================
// Constructors

Vservant_sim::Vservant_sim(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new Vservant_sim__Syms(contextp(), _vcname__, this)}
    , wb_clk{vlSymsp->TOP.wb_clk}
    , wb_rst{vlSymsp->TOP.wb_rst}
    , pc_vld{vlSymsp->TOP.pc_vld}
    , q{vlSymsp->TOP.q}
    , pc_adr{vlSymsp->TOP.pc_adr}
    , servant_sim{vlSymsp->TOP.servant_sim}
    , rootp{&(vlSymsp->TOP)}
{
    // Register model with the context
    contextp()->addModel(this);
    contextp()->traceBaseModelCbAdd(
        [this](VerilatedTraceBaseC* tfp, int levels, int options) { traceBaseModel(tfp, levels, options); });
}

Vservant_sim::Vservant_sim(const char* _vcname__)
    : Vservant_sim(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

Vservant_sim::~Vservant_sim() {
    delete vlSymsp;
}

//============================================================
// Evaluation function

#ifdef VL_DEBUG
void Vservant_sim___024root___eval_debug_assertions(Vservant_sim___024root* vlSelf);
#endif  // VL_DEBUG
void Vservant_sim___024root___eval_static(Vservant_sim___024root* vlSelf);
void Vservant_sim___024root___eval_initial(Vservant_sim___024root* vlSelf);
void Vservant_sim___024root___eval_settle(Vservant_sim___024root* vlSelf);
void Vservant_sim___024root___eval(Vservant_sim___024root* vlSelf);

void Vservant_sim::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Vservant_sim::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    Vservant_sim___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    vlSymsp->__Vm_activity = true;
    vlSymsp->__Vm_deleter.deleteAll();
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) {
        vlSymsp->__Vm_didInit = true;
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial\n"););
        Vservant_sim___024root___eval_static(&(vlSymsp->TOP));
        Vservant_sim___024root___eval_initial(&(vlSymsp->TOP));
        Vservant_sim___024root___eval_settle(&(vlSymsp->TOP));
    }
    VL_DEBUG_IF(VL_DBG_MSGF("+ Eval\n"););
    Vservant_sim___024root___eval(&(vlSymsp->TOP));
    // Evaluate cleanup
    Verilated::endOfEval(vlSymsp->__Vm_evalMsgQp);
}

//============================================================
// Events and timing
bool Vservant_sim::eventsPending() { return false; }

uint64_t Vservant_sim::nextTimeSlot() {
    VL_FATAL_MT(__FILE__, __LINE__, "", "No delays in the design");
    return 0;
}

//============================================================
// Utilities

const char* Vservant_sim::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

void Vservant_sim___024root___eval_final(Vservant_sim___024root* vlSelf);

VL_ATTR_COLD void Vservant_sim::final() {
    Vservant_sim___024root___eval_final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* Vservant_sim::hierName() const { return vlSymsp->name(); }
const char* Vservant_sim::modelName() const { return "Vservant_sim"; }
unsigned Vservant_sim::threads() const { return 1; }
void Vservant_sim::prepareClone() const { contextp()->prepareClone(); }
void Vservant_sim::atClone() const {
    contextp()->threadPoolpOnClone();
}
std::unique_ptr<VerilatedTraceConfig> Vservant_sim::traceConfig() const {
    return std::unique_ptr<VerilatedTraceConfig>{new VerilatedTraceConfig{false, false, false}};
};

//============================================================
// Trace configuration

void Vservant_sim___024root__trace_decl_types(VerilatedVcd* tracep);

void Vservant_sim___024root__trace_init_top(Vservant_sim___024root* vlSelf, VerilatedVcd* tracep);

VL_ATTR_COLD static void trace_init(void* voidSelf, VerilatedVcd* tracep, uint32_t code) {
    // Callback from tracep->open()
    Vservant_sim___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vservant_sim___024root*>(voidSelf);
    Vservant_sim__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (!vlSymsp->_vm_contextp__->calcUnusedSigs()) {
        VL_FATAL_MT(__FILE__, __LINE__, __FILE__,
            "Turning on wave traces requires Verilated::traceEverOn(true) call before time 0.");
    }
    vlSymsp->__Vm_baseCode = code;
    tracep->pushPrefix(std::string{vlSymsp->name()}, VerilatedTracePrefixType::SCOPE_MODULE);
    Vservant_sim___024root__trace_decl_types(tracep);
    Vservant_sim___024root__trace_init_top(vlSelf, tracep);
    tracep->popPrefix();
}

VL_ATTR_COLD void Vservant_sim___024root__trace_register(Vservant_sim___024root* vlSelf, VerilatedVcd* tracep);

VL_ATTR_COLD void Vservant_sim::traceBaseModel(VerilatedTraceBaseC* tfp, int levels, int options) {
    (void)levels; (void)options;
    VerilatedVcdC* const stfp = dynamic_cast<VerilatedVcdC*>(tfp);
    if (VL_UNLIKELY(!stfp)) {
        vl_fatal(__FILE__, __LINE__, __FILE__,"'Vservant_sim::trace()' called on non-VerilatedVcdC object;"
            " use --trace-fst with VerilatedFst object, and --trace-vcd with VerilatedVcd object");
    }
    stfp->spTrace()->addModel(this);
    stfp->spTrace()->addInitCb(&trace_init, &(vlSymsp->TOP));
    Vservant_sim___024root__trace_register(&(vlSymsp->TOP), stfp->spTrace());
}
