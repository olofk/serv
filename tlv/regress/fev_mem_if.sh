#!/usr/bin/env bash
# Formal Equivalence Verification for serv_mem_if TLV conversion.
# Gold: rtl/serv_mem_if.v  (original RTL)
# Gate: tlv/verilog/serv_mem_if.v  (SandPiper-generated)
# Tests W=1 and W=4.
set -euo pipefail

PROJ=/workspace/proj
LOG=$PROJ/tlv/regress/work_mem_if/log

mkdir -p "$LOG"

for W in 1 4; do
  echo "=== FEV W=$W ==="
  yosys <<YS 2>&1 | tee "$LOG/fev_w${W}.log"
    read_verilog -sv $PROJ/rtl/serv_mem_if.v
    hierarchy -top serv_mem_if -chparam W $W
    proc; opt; rename serv_mem_if gold
    design -stash gold
    read_verilog -sv -I $PROJ/tlv/verilog $PROJ/tlv/verilog/serv_mem_if.v
    hierarchy -top serv_mem_if -chparam W $W
    proc; opt; opt_clean -purge; rename serv_mem_if gate
    design -stash gate
    design -copy-from gold -as gold gold
    design -copy-from gate -as gate gate
    equiv_make gold gate equiv
    cd equiv
    equiv_add -try \signbit_gold \PIPE_signbit_a1_gate
    cd ..
    prep -top equiv
    techmap; opt; equiv_struct; equiv_simple; equiv_simple; equiv_induct -seq 32 equiv
    equiv_status -assert equiv
YS
  if grep -q "Equivalence successfully proven" "$LOG/fev_w${W}.log"; then
    echo "=== FEV W=$W: PASSED ==="
  else
    echo "=== FEV W=$W: FAILED ===" >&2
    exit 1
  fi
done

echo ""
echo "=== FEV complete: all cases passed ==="
