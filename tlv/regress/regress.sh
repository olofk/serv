#!/usr/bin/env bash
#
# regress.sh - Regress SERV against TL-Verilog conversion changes.
#
# Runs SERV's own FuseSoC test targets against the (possibly converted) RTL,
# which rtl/serv_*.v symlinks pull from tlv/verilog/. Three checks:
#
#   1. lint  W=1  - Verilator lint of the serv core, 1-bit (default) datapath.
#   2. lint  W=4  - Verilator lint of the serv core, 4-bit datapath.
#   3. sim   hello_uart - Build & run the servant SoC on the bare-metal
#                  hello_uart firmware. It prints "Hi, I'm Servant!" over a
#                  bit-banged UART, then writes the sim-halt address to end
#                  the run ("Test complete"). Exercises serv_bufreg's
#                  load/store address path and shifts.
#
# On success: one PASS line per check and exit 0.
# On failure: the failing check, a short excerpt, the full-log path, exit 1.
#
# Full logs are written under tlv/regress/work/log/.
#
# Usage:  tlv/regress/regress.sh
# Run inside the project Docker container (see tlv/env/).

set -u

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJ_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
WORK="$SCRIPT_DIR/work"
LOGDIR="$WORK/log"
FW="$PROJ_ROOT/sw/hello_uart.hex"

mkdir -p "$LOGDIR"

# Local FuseSoC workspace: register the project repo as a library.
CONF="$WORK/fusesoc.conf"
cat > "$CONF" <<EOF
[library.serv]
location = $PROJ_ROOT
sync-uri = $PROJ_ROOT
sync-type = local
auto-sync = true
EOF

FUSESOC=(fusesoc --config "$CONF")
fail=0

# run_check <name> <logfile> <success-grep-regex> -- <command...>
run_check() {
  local name="$1" log="$2" want="$3"; shift 3
  [ "$1" = "--" ] && shift
  ( cd "$WORK" && "$@" ) > "$log" 2>&1
  local rc=$?
  if [ $rc -eq 0 ] && grep -qE "$want" "$log"; then
    echo "PASS  $name"
  else
    echo "FAIL  $name  (exit=$rc, expected /$want/)"
    echo "----- last lines of $log -----"
    grep -iE 'error|warning|%error|assert|fail|cannot|undefined' "$log" | head -15
    tail -15 "$log"
    echo "----- full log: $log -----"
    fail=1
  fi
}

echo "SERV conversion regression (rtl <- tlv/verilog)"

run_check "lint W=1" "$LOGDIR/lint_w1.log" 'INFO: Running' -- \
  "${FUSESOC[@]}" run --target=lint serv

run_check "lint W=4" "$LOGDIR/lint_w4.log" 'INFO: Running' -- \
  "${FUSESOC[@]}" run --target=lint serv --W=4

# Functional sim. The firmware self-halts via the sim-halt address ($finish,
# "Test complete"); --timeout is only a safety net against a broken halt path.
run_check "sim hello_uart" "$LOGDIR/sim_hello_uart.log" "Hi, I'm Servant!" -- \
  "${FUSESOC[@]}" run --target=verilator_tb servant \
    --uart_baudrate=57600 --firmware="$FW" --timeout=10000000

if [ $fail -eq 0 ]; then
  echo "ALL PASS"
else
  echo "REGRESSION FAILED"
fi
exit $fail
