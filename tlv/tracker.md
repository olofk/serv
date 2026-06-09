# serv_bufreg TL-Verilog Conversion Tracker

Incremental conversion of `rtl/serv_bufreg.v` from Verilog to TL-Verilog.
Source of truth: `tlv/serv_bufreg.tlv`. After every change run `tlv/regress/fev.sh`
(SandPiper regenerate + Yosys sequential equivalence vs `serv_bufreg_golden.v`,
for W=1 and W=4). A step is only "done" when FEV passes.

## SandPiper mechanics (learned by experiment)

For the "`\TLV` embedded inside an `\SV` module" style (module ports kept in `\SV`):

| Need | TL-Verilog | Generated Verilog |
|------|-----------|-------------------|
| Read an SV signal/port into TLV | `*sig` | `sig` |
| Define a TLV signal | `$sig[H:L] = expr;` | `assign L0_sig_a0 = expr;` (decl in `_gen.v`) |
| Previous-cycle value (flop) | `>>1$sig` | `always_ff @(posedge clk) L0_sig_a1 <= L0_sig_a0;` |
| Drive an SV output port / wire | `*o_port = $sig;` | `assign o_port = L0_sig_a0;` |

Key facts:
- TLV signal `$x` becomes an internal mangled wire (`L0_x_a0`); **never** reference
  `$x` from an `\SV` region. Cross from TLV back to SV only via `*sv_name = $x;`.
- A flop inferred by `>>1` uses a clock literally named **`clk`**. SERV's port is
  `i_clk`, so once any flop is introduced, the `\SV` must provide `wire clk = i_clk;`.
  `>>1$d` registers `$d`: result(t) = d(t-1) — matches `q <= d`.
- SandPiper auto-inserts `` `include "serv_bufreg_gen.v" `` inside the module
  once there is real TLV content. The gen file is listed in `serv.core` as
  `{is_include_file : true}` (puts its dir on the include path; not compiled
  standalone — see the step-1 issue below).
- `fev.sh` strips the leading `//_\` header lines (waiver line-number alignment,
  see project_specific_instructions.md). With TLV content the body shifts anyway;
  lint waivers are handled by `regress.sh`, not `fev.sh`.

## Conversion strategy

Convert from the leaves inward, keeping the `W==1`/`W==4` `generate` blocks in
`\SV` for as long as they need `generate` (TLV has no `generate`). Bridge signals
both ways as needed (`*name` into TLV, `*name = $x` out). Keep both W=1 and W=4
equivalent at every step.

## Steps

| # | Change | FEV | Notes |
|---|--------|-----|-------|
| 0 | Baseline: verbatim `\SV` copy | PASS | starting point |
| 1 | `o_dbus_adr`, `o_ext_rs1` → TLV (`*o_port = expr`) | PASS | also fixed `serv.core` include-file (below) |
| 2 | `clr_lsb` + `{c,q}` adder → TLV; bridge `*c`,`*q` to SV | PASS | needed stronger FEV recipe + width fix (below) |
| 3 | `c_r` carry flop → TLV (`>>1`); adder reads `$c_r` | PASS | added `wire clk = i_clk;`; dropped now-unused `wire c` |
| 4 | W-dependent `data` shift-register datapath | N/A | stays in `\SV` `generate` — TL-Verilog limitation (below) |
| 5 | Convert W-parameterized generate blocks using ternary approach | PASS | compute W=1 and W=4 paths unconditionally; select with `(W==1)?...:...`; fix FEV (below) |

## Issues / patterns

- **gen-file include (step 1).** As soon as there is real TLV content, SandPiper
  emits `` `include "serv_bufreg_gen.v" `` inside the module. Verilator (via
  FuseSoC) then failed: *Cannot find include file*. Fix: in `serv.core` mark the
  gen file `{is_include_file : true}` instead of a plain source. That (a) adds its
  directory to the include path so the `` `include `` resolves, and (b) removes it
  from the compile list — important because the gen file's body is module-scope
  declarations (`logic L0_..._a0;`), not a compilable standalone unit. FEV is
  unaffected (Yosys resolves the `` `include `` relative to the `.v` file's dir,
  and fev.sh also reads the gen file explicitly).

- **fev.sh gen-file read (step 2).** Once the gen file gained module-scope
  `logic` decls, reading it as a standalone Yosys source broke (`unexpected
  TOK_LOGIC`). Fix: fev.sh reads only the gate `.v` with `-I verilog` and lets its
  own `` `include `` pull the gen file in; the golden needs no gen file.

- **equiv_induct too weak for the W=4 dynamic shift (step 2).** After the adder
  moved to TLV, `equiv_induct` alone left `o_q[2:0]` *unproven* for W=4 (the
  dynamic part-select `muxdata[idx +: W]` becomes a `$shiftx` that defeats
  name-based cell matching; W=1 has no such mux and was fine). It was **not** a
  real bug — `q` proved equal and the W=4 datapath is identical to golden, so both
  the output and next-state functions are equal. A `miter -equiv` + `sat
  -tempinduct` from undefined init blew up (the two 32-bit `data` shift registers
  only converge after ~32 cycles of flushing) — wrong tool. Fix: strengthen the
  recipe to `techmap; opt; equiv_struct; equiv_simple; equiv_induct` — lowering
  `$shiftx` to gates lets structural matching close the proof. Verified the
  strengthened recipe still **catches** a real bug (negative control: XOR-ing a
  bit into `$c` makes FEV fail). This recipe is now in `fev.sh`.

- **WIDTHEXPAND lint (step 2).** `$clr_lsb[B:0] = *i_cnt0 & *i_clr_lsb;` relies on
  implicit zero-extension of a 1-bit RHS to W bits; Verilator `-Wall` (the lint
  target) flags WIDTHEXPAND for W=4. FEV passed but `regress.sh` lint failed.
  Pattern: when a TLV signal is wider than its expression, pad the RHS to the full
  declared width explicitly: `$clr_lsb[B:0] = {{B{1'b0}}, *i_cnt0 & *i_clr_lsb};`.
  Run `regress.sh` (lint) as well as `fev.sh` after each change.

- **First flop / clock bridge (step 3).** A TLV `>>1` flop emits `always_ff @(posedge
  clk)`. SERV's clock port is `i_clk`, so the `\SV` must declare `wire clk = i_clk;`
  once any flop is converted. Pattern for `q <= d` with a cleared field:
  `$cr_in = $c & *i_en; $c_r[B:0] = {{B{1'b0}}, >>1$cr_in};`. When a signal's last
  `\SV` consumer is converted, drop its bridge (`*sig = $sig`) and its `\SV`
  declaration, or it lints as UNDRIVEN/UNUSED (removed `wire c;` here).

- **W-parameterized `generate` cannot be converted (step 4 — stopping point).** The
  `data` shift register and the `o_lsb`/`o_q` outputs live inside a Verilog
  `generate` with two structurally **different** implementations selected by the
  elaboration parameter `W`:
  - `W==1` (default bit-serial mode, used by the functional sim): special
    `data[1:0]` handling — `data[1] <= i_init ? q : data[2]`, with a distinct
    enable `i_init ? (i_cnt0|i_cnt1) : i_en` — plus the `data[31:2]` shift.
  - `W==4` (lint-only): shift `data <= {fill, data[31:W]}` with separate `lsb`
    and `data_tail` registers and a dynamic-shift `muxout`.

  These are not unifiable into one width-generic expression (the W==1 LSB logic is
  not a special case of the W==4 shift). TL-Verilog has no `generate`, and its only
  conditional-elaboration mechanism (M5 macros) runs at SandPiper time, before the
  Verilog parameter `W` has a value — so TLV cannot emit different structure per
  `W`. A TLV `$data` would drive `data` unconditionally and **double-drive** it
  whenever the `W==4` `generate` is also elaborated. Keeping only the
  combinational next-state in TLV while leaving the register in `\SV` adds little
  and produces dead, lint-flagged logic in the unused width.

  **Decision:** leave the W-dependent datapath (`data` register + `gen_w_eq_1` /
  `gen_lsb_w_4`) in `\SV` `generate`. All width-**independent** logic — `clr_lsb`,
  the carry/sum adder (`$c`/`$q`), the `c_r` carry register, and the data-derived
  outputs `o_dbus_adr`/`o_ext_rs1` — is now TL-Verilog. This is the correct
  conversion boundary for a single file that must keep the `W` parameter and pass
  both `lint W=1` and `lint W=4`. Converting the datapath would require dropping
  `W` parameterization (committing the file to a fixed width) — a larger decision
  for the SERV maintainers, out of scope here.

- **W-parameterized generate blocks via ternary (step 5).** The approach: compute both
  the W=1 and W=4 datapath values as unconditional TLV signals, then select with
  `(W == 1) ? $w1_result : $w4_result`. Synthesis constant-folds the dead path.
  Several issues encountered:

  - **SandPiper closing-brace parse error.** TLV is indentation-sensitive. A `};` on
    its own line at statement indentation is treated as a new TLV statement, not the
    end of a concatenation. Fix: always close `{...}` on the same line as the last
    inner expression (never on a line with the same indent as `$sig = ...`).

  - **SandPiper `[{expr}+:W]` subscript.** SandPiper rejects indexed part-select
    with a concatenation base: `$muxdata[{1'b0,shift}+:W]`. Workaround: right-shift
    instead — `$muxdata >> {1'b0, shift}` extracts the same bits into `[B:0]`.
    The `>>` operator is width-safe: the result is as wide as `$muxdata` (10 bits),
    and the assign into `$muxout[B:0]` takes only the low W bits. TLV accepts this.

  - **Extra registers survive `opt` (dead-code).** For W=1, SandPiper creates DFFs
    for `$lsb` and `$data_tail` (W=4-only signals) unconditionally. After W=1
    constant-fold, `opt_clean -purge` removes them from the gate netlist before FEV.
    No issue for the proof, but the generated Verilog always contains all four
    `always_ff` blocks.

  - **`equiv_make` misses `c_r` state register (FEV root cause).** `equiv_make`'s
    `find_same_wires` only creates `$equiv` cells for signals reachable through
    *combinational* paths to primary outputs. `c_r` (the carry register) only reaches
    outputs through another register stage (`data`), so `find_same_wires` produces no
    `$equiv` cell for `c_r_gold ≡ L0_c_r_a0_gate`. Without this constraint the SAT
    solver sets the two carry registers independently, making `q_gold ≠ q_gate`, and
    the proofs for `data[31]`/`data[1]` (W=1) and `data[28:31]`/`lsb[0:1]` (W=4)
    fail. Fix: add two `equiv_add -try` calls after `equiv_make` in `fev.sh` — one
    for the W=1 gate name (`L0_c_r_a0_gate`) and one for W=4 (`L0_cr_in_a1_gate`).
    The `-try` flag silently skips the name that doesn't exist for the current `W`.
    This adds 1 extra `$equiv` cell to the 34 (W=1) or 39 (W=4) cells; all 35 / 40
    cells then prove in one `equiv_induct` pass.

  - **Width-generic W=1 expression.** The W=1 concatenation for `$data_w1` uses
    fixed bit indices (`data[31:3]`, `data[31:2]`, `data[1]`, `data[1:0]`) rather
    than parameterised `W`/`B` indices, because those would produce invalid ranges
    when W=4 (e.g. `data[B:0]` = `data[3:0]` and `data[31:W]` = `data[31:4]`). TLV
    compiles a single expression for all `W`; Yosys constant-folds the dead path.

## Result

Fully converted to TL-Verilog (FEV-proven equivalent for W=1 and W=4):
all width-independent logic *and* the W-parameterized `gen_w_eq_1` / `gen_lsb_w_4`
generate blocks. The `\SV` section now contains only the module header and
`wire clk = i_clk;`; `endmodule` is at the bottom of `\SV`.
`fev.sh` passes for both W=1 and W=4.
