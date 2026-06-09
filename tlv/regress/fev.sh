#!/usr/bin/env bash
#
# fev.sh - Formal Equivalence Verification for the serv_bufreg conversion.
#
# The conversion loop is: edit tlv/serv_bufreg.tlv -> run this script.
# It does the whole pipeline and proves the result is still correct:
#
#   1. SandPiper compiles serv_bufreg.tlv -> tlv/verilog/serv_bufreg.v (+ _gen.v),
#      then strips the leading //_\ header lines to keep line numbers aligned
#      with data/verilator_waiver.vlt (see project_specific_instructions.md).
#   2. Yosys proves the regenerated Verilog is sequentially equivalent to the
#      golden original (tlv/serv_bufreg_golden.v) via temporal induction
#      (equiv_induct), for both datapath widths W=1 and W=4.
#
# rtl/serv_bufreg.v is a symlink to the regenerated file, so a passing FEV also
# leaves the tree ready for tlv/regress/regress.sh.
#
# On success: PASS lines + exit 0.  On failure: the failing stage, an excerpt,
# the full-log path, and exit 1.  Full logs under tlv/regress/work/log/.
#
# Usage:  tlv/regress/fev.sh
# Run inside the project Docker container.

set -u

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TLV_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
LOGDIR="$SCRIPT_DIR/work/log"
mkdir -p "$LOGDIR"

MOD=serv_bufreg
TLV="$TLV_DIR/$MOD.tlv"
GOLDEN="$TLV_DIR/${MOD}_golden.v"
VDIR="$TLV_DIR/verilog"
GEN="$VDIR/${MOD}_gen.v"
GATE="$VDIR/$MOD.v"

fail=0

# ---- Stage 1: regenerate Verilog from TL-Verilog --------------------------
GENLOG="$LOGDIR/sandpiper.log"
(
  cd "$TLV_DIR" &&
  sandpiper-saas -i "$MOD.tlv" -o "$MOD.v" --outdir verilog --bestsv --noline &&
  sed -i '/^\/\/_\\/d' "verilog/$MOD.v"
) > "$GENLOG" 2>&1
if [ $? -ne 0 ]; then
  echo "FAIL  sandpiper (TL-Verilog compile)"
  tail -25 "$GENLOG"
  echo "----- full log: $GENLOG -----"
  exit 1
fi
echo "PASS  sandpiper  (regenerated verilog/$MOD.v)"

# ---- Stage 2: FEV golden vs regenerated, per datapath width ----------------
fev_one() {
  local W="$1"
  local log="$LOGDIR/fev_w$W.log"
  # Golden is the self-contained original. Gate is SandPiper output that
  # `include's MOD_gen.v (module-scope decls + macros); -I lets yosys resolve it.
  yosys -p "
    read_verilog -sv $GOLDEN
    hierarchy -top $MOD -chparam W $W
    proc; opt; rename $MOD gold
    design -stash gold
    read_verilog -sv -I $VDIR $GATE
    hierarchy -top $MOD -chparam W $W
    proc; opt; opt_clean -purge; rename $MOD gate
    design -stash gate
    design -copy-from gold -as gold gold
    design -copy-from gate -as gate gate
    equiv_make gold gate equiv
    cd equiv
    equiv_add -try \c_r_gold \L0_c_r_a0_gate
    equiv_add -try \c_r_gold \L0_cr_in_a1_gate
    cd ..
    prep -top equiv
    techmap; opt; opt_clean -purge
    equiv_struct
    equiv_simple
    equiv_simple
    equiv_induct -seq 32 equiv
    equiv_status -assert equiv
  " > "$log" 2>&1
  if [ $? -eq 0 ] && grep -q 'Equivalence successfully proven!' "$log"; then
    echo "PASS  fev W=$W"
  else
    echo "FAIL  fev W=$W"
    grep -iE 'unproven|ERROR|not equivalent|Warning|cannot' "$log" | head -15
    tail -15 "$log"
    echo "----- full log: $log -----"
    fail=1
  fi
}

echo "FEV: golden ($MOD) vs regenerated TL-Verilog output"
fev_one 1
fev_one 4

if [ $fail -eq 0 ]; then
  echo "ALL PASS"
else
  echo "FEV FAILED"
fi
exit $fail
