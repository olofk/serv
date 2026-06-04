# SERV Conversion — Project-Specific Instructions

SERV is the world's smallest RISC-V CPU: a **bit-serial** design. The datapath is
1 bit wide by default (parameter `W=1`), so most modules process one bit per
clock and registers are gated by an enable. Keep this in mind — it is normal for
state to update only when an enable is asserted.

No vendor libraries, generated CSRs, tri-states, or latches are involved in the
modules under conversion. Logic is flip-flop based on `posedge i_clk`.

## Environment

Everything runs in the project Docker container (`tlv/env/`): SandPiper,
Verilator, Yosys (OSS CAD Suite) from the base image, **FuseSoC** added by
`Dockerfile.project`. SERV uses FuseSoC for all of its tests.

## Preparation (per module)

The conversion replaces an RTL file with a symlink to SandPiper output so SERV's
own build picks up the converted Verilog automatically.

For module `serv_<mod>`:

1. Working TL-Verilog file: `tlv/serv_<mod>.tlv`. It starts as a verbatim copy of
   the original Verilog wrapped in `\SV`, with the `\m5_TLV_version 1d: tl-x.org`
   header. Golden reference (unchanged original) for FEV: `tlv/serv_<mod>_golden.v`.
2. Generate Verilog with SandPiper into `tlv/verilog/`, then strip the two
   leading SandPiper `//_\...` header comment lines:
   ```
   cd tlv && sandpiper-saas -i serv_<mod>.tlv -o serv_<mod>.v \
       --outdir verilog --bestsv --noline
   sed -i '/^\/\/_\\/d' verilog/serv_<mod>.v
   ```
   This produces `tlv/verilog/serv_<mod>.v` and `tlv/verilog/serv_<mod>_gen.v`
   (SandPiper macro definitions such as `` `BOGUS_USE ``).

   **Why strip the header:** SERV's `data/verilator_waiver.vlt` waives
   unused-signal lint warnings (e.g. `serv_bufreg`'s `i_cnt_done`, `i_shamt`,
   used only in the `W=4` branch) **by line number** (`-lines 15`, `16`,
   `25-27`). The two-line SandPiper header would shift every line and break those
   waivers. In the initial verbatim-copy state, stripping the header keeps the
   generated Verilog line-aligned with the original so the waivers still apply.
   Once real TL-Verilog refactoring changes the line count, keep these waivers
   valid — update the `-lines` entries in `data/verilator_waiver.vlt` to the new
   port-declaration lines (or replace them with a non-line-based waiver).
3. Point the project at the generated Verilog with symlinks in `rtl/`:
   ```
   ln -sf ../tlv/verilog/serv_<mod>.v     rtl/serv_<mod>.v
   ln -sf ../tlv/verilog/serv_<mod>_gen.v rtl/serv_<mod>_gen.v
   ```
4. In `serv.core`, list `rtl/serv_<mod>_gen.v` **immediately before**
   `rtl/serv_<mod>.v` in the `core` fileset. The generated `.v` uses then
   `` `undef ``s the gen-file macros, and Verilator/Yosys share macro state across
   source files **in order**, so the gen file must come first. (Already done for
   `serv_bufreg`.)

For FEV (Yosys), read the gen file before the converted module, e.g.
`read_verilog -sv tlv/verilog/serv_<mod>_gen.v tlv/verilog/serv_<mod>.v`, and
compare against `tlv/serv_<mod>_golden.v`.

## Parameters / test configurations

`serv_bufreg` (buffer register for load/store address and shift data):

- `W`   — datapath width. Legal values **1 and 4** (separate generate branches).
          `W=1` is the default bit-serial mode; `W=4` is the 4-bit variant. Test both.
- `B`   — derived as `W-1`; never override.
- `MDU` — `[0:0]`, default `0`. When `1`, `i_mdu_op` forces `o_lsb` to 0.

The regression covers `W=1` and `W=4` via the lint target.

## Clock enabling

`i_en` is a functional clock **enable**: the `data`/`c_r` registers only update
when `i_en` (and the lsb registers under finer conditions). This is functional —
preserve it. In TL-Verilog express it with a when-condition (e.g. `?$i_en`) or by
keeping the enable in the assignment, matching the original update behavior. There
is no coarse clock gating and no tri-state logic.

## Regression

Single command (run inside the container):

```
tlv/regress/regress.sh
```

It builds a local FuseSoC workspace under `tlv/regress/work/` and runs three of
SERV's own checks against the converted RTL:

1. `lint W=1` — Verilator lint of the `serv` core, default datapath.
2. `lint W=4` — Verilator lint of the `serv` core, 4-bit datapath.
3. `sim hello_uart` — builds the `servant` SoC (`verilator_tb`) and runs the
   bare-metal `hello_uart` firmware. It prints `Hi, I'm Servant!` over a
   bit-banged UART and self-halts (`Test complete`). This exercises
   `serv_bufreg`'s load/store address path (`sb`/`sw`/`lbu`) and shifts
   (`slli`/`srli`).

Output is one `PASS`/`FAIL` line per check; on success the script prints
`ALL PASS` and exits 0. On failure it prints the failing check, an error excerpt,
and the path to the full log under `tlv/regress/work/log/`. With warm ccache a run
is ~10 s; a cold first build is 1–2 min.

### Verification collateral

The only project files touched by the conversion are the `rtl/serv_<mod>.v`
symlinks and the `serv.core` fileset entry for the gen file. SERV's testbench
(`bench/servant_tb.cpp`, `bench/servant_sim.v`) connects to the SoC's top-level
ports, not to internal `serv_bufreg` signals, so it needs no updates as internal
signal names change during conversion.
