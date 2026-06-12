# serv_mem_if TLV Conversion Tracker

## Module Summary

`rtl/serv_mem_if.v` — SERV memory interface

### Parameters
| Name | Default | Description |
|------|---------|-------------|
| WITH_CSR | 1 | Enable/disable CSR misalignment check |
| W | 1 | Datapath width (1=SERV, 4=QERV) |
| B | W-1 | Bit index of MSB |

### Ports
| Port | Direction | Width | Description |
|------|-----------|-------|-------------|
| i_clk | in | 1 | Clock |
| i_bytecnt | in | 2 | Byte counter |
| i_lsb | in | 2 | LSB of address (for alignment/sel) |
| o_misalign | out | 1 | Misalignment flag (WITH_CSR gated) |
| i_signed | in | 1 | Sign-extend load |
| i_word | in | 1 | Word operation |
| i_half | in | 1 | Half-word operation |
| i_mdu_op | in | 1 | MDU operation (bypass dat_valid) |
| i_bufreg2_q | in | W | Data from buffer register 2 |
| o_rd | out | W | Read data (sign-extended or raw) |
| o_wb_sel | out | 4 | Wishbone byte enables |

### Internal State
| Signal | Type | Description |
|--------|------|-------------|
| signbit | reg (1-bit) | Sign bit captured from last valid byte |

### Combinational Logic
| Signal | Description |
|--------|-------------|
| dat_valid | High when byte is valid (word/half/byte-lane/mdu) |

---

## Conversion Plan

### Step 0: Verbatim \SV copy (initial)
All original logic placed verbatim in the `\SV` block.
`wire clk = i_clk;` added immediately after port list.
Goal: confirm trivial FEV equivalence before any TLV conversion.

### Step 1: `$dat_valid` → TLV `@0`
Move `dat_valid` wire to TLV `$dat_valid` at `@0`.
Equivalent to original `wire dat_valid = ...`.

### Step 2: `signbit` register → TLV `$signbit`
Convert `always @(posedge i_clk) if (dat_valid) signbit <= i_bufreg2_q[B];`
to TLV: `$signbit[0:0] = $dat_valid ? i_bufreg2_q[B:B] : >>1$signbit;`
Need `equiv_add -try \signbit_gold \L0_signbit_a1_gate` in FEV.

### Step 3: `o_rd` assign → TLV
Move `assign o_rd = dat_valid ? i_bufreg2_q : {W{i_signed & signbit}};`
to TLV `$o_rd` referencing `>>1$signbit` for the registered sign bit.

### Step 4: `o_wb_sel` assigns → TLV
Move the four `o_wb_sel` bit assignments to TLV `$o_wb_sel[3:0]`.

### Step 5: `o_misalign` assign → TLV
Move `assign o_misalign = WITH_CSR & (...);` to TLV `$o_misalign`.

---

## Regression Status

| Step | Sandpiper | Lint W=1 | Lint W=4 | Sim | FEV W=1 | FEV W=4 |
|------|-----------|----------|----------|-----|---------|---------|
| 0: verbatim | PASS | PASS | PASS | PASS | PASS | PASS |
| 1+2: dat_valid+signbit | PASS | PASS | PASS | PASS | PASS | PASS |
| 3-5: o_rd+o_wb_sel+o_misalign | PASS | PASS | PASS | PASS | PASS | PASS |

---

## Issues Log

### Issue 1: fusesoc does not auto-generate `+incdir` for include files
Resolved by passing `--verilator_options "+incdir+src/award-winning_serv_serv_1.4.0/rtl"` in regress script. The `serv_mem_if_gen.v` (user-type in serv.core) is copied to the build RTL dir but verilator needs the incdir to find it via `\`include`.

### Issue 2: `clk` unused signal warning in verbatim phase
Added `lint_off -rule UNUSEDSIGNAL -file "*/serv_mem_if.v"` to `data/verilator_waiver.vlt`. Can be removed once all TLV staging registers exist (they use `clk`).

### Issue 3: `|pipe` naming produces `PIPE_*` not `L0_*`
SandPiper-SaaS 1.14 with `|pipe` pipeline scope generates `PIPE_signal_a0/a1` names (not `L0_*` as in the bufreg conversion). All SV bridge assignments use `PIPE_*` names accordingly.

### Issue 4: Output signals need `BOGUS_USE` in TLV
Since `$o_rd`, `$o_wb_sel`, `$o_misalign` are TLV signals used only via `PIPE_*` assignments in the `\SV` block, SandPiper warns they're unused. Added `` `BOGUS_USE($o_rd) `BOGUS_USE($o_wb_sel) `BOGUS_USE($o_misalign) `` in the TLV section.

### Issue 5: regress script failed to restore rtl/ on error
Added `trap cleanup EXIT` in regress_mem_if.sh to ensure `rtl/serv_mem_if.v` is always restored even if the script exits with an error.
