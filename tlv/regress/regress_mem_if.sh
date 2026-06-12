#!/usr/bin/env bash
# Regression for serv_mem_if TLV conversion.
# Runs: sandpiper compile, fusesoc lint W=1, lint W=4, hello_uart sim.
set -euo pipefail

PROJ=/workspace/proj
TLV_DIR=$PROJ/tlv
VERILOG_DIR=$TLV_DIR/verilog
RTL_DIR=$PROJ/rtl
WORK=$TLV_DIR/regress/work_mem_if
LOG=$WORK/log
SP_WORK=/tmp/sp_work_mem_if

mkdir -p "$WORK" "$LOG"
rm -rf "$SP_WORK" && mkdir -p "$SP_WORK"

# Ensure RTL is restored even if the script exits with an error.
cleanup() {
  if [ -f "$RTL_DIR/serv_mem_if.v.bak" ]; then
    cp "$RTL_DIR/serv_mem_if.v.bak" "$RTL_DIR/serv_mem_if.v"
    rm -f "$RTL_DIR/serv_mem_if.v.bak" "$RTL_DIR/serv_mem_if_gen.v"
    echo "RTL restored by cleanup trap."
  fi
}
trap cleanup EXIT

# ---- Step 1: SandPiper compile ----
echo "=== Step 1: SandPiper compile ==="
(cd "$SP_WORK" && \
  sandpiper-saas \
    -i "$TLV_DIR/serv_mem_if.tlv" \
    -o serv_mem_if.v \
    --outdir out \
    --bestsv \
    --noline) \
  2>&1 | tee "$LOG/sandpiper.log"

# Strip SandPiper header marker lines
sed -i '/^\/\/_\\/d' "$SP_WORK/out/serv_mem_if.v"

# Copy generated files to verilog output directory
cp "$SP_WORK/out/serv_mem_if.v"     "$VERILOG_DIR/serv_mem_if.v"
cp "$SP_WORK/out/serv_mem_if_gen.v" "$VERILOG_DIR/serv_mem_if_gen.v"

# ---- Step 2: Install to RTL (backup original) ----
echo "=== Step 2: Install TLV-generated files to rtl/ ==="
cp "$RTL_DIR/serv_mem_if.v" "$RTL_DIR/serv_mem_if.v.bak"
cp "$VERILOG_DIR/serv_mem_if.v"     "$RTL_DIR/serv_mem_if.v"
cp "$VERILOG_DIR/serv_mem_if_gen.v" "$RTL_DIR/serv_mem_if_gen.v"

# The gen.v is placed in the build's src/.../rtl/ directory (via serv.core
# user-type entry).  fusesoc does not auto-generate +incdir, so we supply it
# explicitly via --verilator_options.
INCDIR="+incdir+src/award-winning_serv_serv_1.4.0/rtl"

# ---- Step 3: Lint W=1 ----
echo "=== Step 3: Lint W=1 ==="
(cd "$WORK" && \
  fusesoc --cores-root "$PROJ" \
    run --target lint \
    award-winning:serv:serv:1.4.0 --W 1 \
    --verilator_options "$INCDIR") \
  2>&1 | tee "$LOG/lint_w1.log"

# ---- Step 4: Lint W=4 ----
echo "=== Step 4: Lint W=4 ==="
(cd "$WORK" && \
  fusesoc --cores-root "$PROJ" \
    run --target lint \
    award-winning:serv:serv:1.4.0 --W 4 \
    --verilator_options "$INCDIR") \
  2>&1 | tee "$LOG/lint_w4.log"

# Sim incdir (servant uses the same serv RTL directory)
SIM_INCDIR="+incdir+src/award-winning_serv_serv_1.4.0/rtl"

# ---- Step 5: Sim hello_uart ----
echo "=== Step 5: Sim hello_uart ==="
(cd "$WORK" && \
  fusesoc --cores-root "$PROJ" \
    run --target verilator_tb \
    award-winning:serv:servant:1.4.0 \
    --firmware "$PROJ/sw/hello_uart.hex" \
    --uart_baudrate 57600 \
    --verilator_options "$SIM_INCDIR") \
  2>&1 | tee "$LOG/sim_hello_uart.log"

# ---- Restore RTL ----
echo "=== Restoring original rtl/serv_mem_if.v ==="
cp "$RTL_DIR/serv_mem_if.v.bak" "$RTL_DIR/serv_mem_if.v"
rm -f "$RTL_DIR/serv_mem_if.v.bak" "$RTL_DIR/serv_mem_if_gen.v"

echo ""
echo "=== Regression complete. Logs in $LOG ==="
