#include <fcntl.h>
#include <stdint.h>
#include <signal.h>

#include "verilated_vcd_c.h"
#include "Vservant_external_sim.h"

#include <ctime>

using namespace std;

static bool done;

vluint64_t main_time = 0;       // Current simulation time
// This is a 64-bit integer to reduce wrap over issues and
// allow modulus.  You can also use a double, if you wish.

double sc_time_stamp () {       // Called by $time in Verilog
  return main_time;           // converts to double, to match
  // what SystemC does
}

void INThandler(int signal) {
  printf("\nCaught ctrl-c\n");
  done = true;
}

int reset(Vservant_external_sim *, VerilatedVcdC *);
int timer_test(Vservant_external_sim *, VerilatedVcdC *,
               vluint64_t, vluint64_t);

int main(int argc, char **argv, char **env) {
  Verilated::commandArgs(argc, argv);

  Vservant_external_sim* top = new Vservant_external_sim;

  VerilatedVcdC * tfp = 0;
  const char *vcd = Verilated::commandArgsPlusMatch("vcd=");
  if (vcd[0]) {
    Verilated::traceEverOn(true);
    tfp = new VerilatedVcdC;
    top->trace (tfp, 99);
    tfp->open ("trace.vcd");
  }

  signal(SIGINT, INThandler);

  vluint64_t timeout = 0;
  const char *arg_timeout = Verilated::commandArgsPlusMatch("timeout=");
  if (arg_timeout[0])
    timeout = atoi(arg_timeout+9);

  vluint64_t interrupt_time = 1500;
  const char *arg_interrupt_time =
    Verilated::commandArgsPlusMatch("interrupt_time=");
  if (arg_interrupt_time[0]) {
    interrupt_time = atoi(arg_interrupt_time);
  }

  vluint64_t vcd_start = 0;
  const char *arg_vcd_start = Verilated::commandArgsPlusMatch("vcd_start=");
  if (arg_vcd_start[0])
    vcd_start = atoi(arg_vcd_start+11);

  int cur_cycle = 0;
  int last_cycle = 0;
  std::time_t last_time = std::time(nullptr);

  top->wb_clk = 1;
  top->ext_irq = 0;
  bool q = top->q;
  int clock = 0;
  reset(top, tfp);
  timer_test(top, tfp, timeout, interrupt_time);
  if (tfp) {
    tfp->close();
  }
  exit(0);
}


int reset(Vservant_external_sim *top, VerilatedVcdC *tfp) {
  top->wb_rst = 1;
  for (int i = 0; i < 10; i++) {
    top->wb_clk = !top->wb_clk;
    top->eval();
  }
  top->wb_clk = !top->wb_clk;
  top->wb_rst = 0;
  return 0;
}

int timer_test(Vservant_external_sim *top, VerilatedVcdC *tfp,
               vluint64_t timeout, vluint64_t interrupt_time) {
  int clock = 0;
  while (Verilated::gotFinish()) {
    top->eval();
    if (top->wb_clk) {
      clock++;
    }
    if (tfp && top->wb_clk) {
      tfp->dump(clock);
    }
    if (clock >= interrupt_time && clock <= interrupt_time + 100) {
      if (top->ext_irq == 0) {
        printf("interrupting %d\n", clock);
      }
      top->ext_irq = 1;
    } else {
      top->ext_irq = 0;
    }
    if (top->wb_clk && top->pc_vld && top->pc_adr) {
      std::this_thread::sleep_for(std::chrono::milliseconds(500));
      printf("%d | %d\n", clock, top->pc_adr);
      if (top->mret) {
        printf("mret detected, exiting\n");
        exit(0);
      }
    }
    if (timeout && (clock >= timeout)) {
      printf("Timeout: Exiting at time %d\n", clock);
      exit(0);
    }
    top->wb_clk = !top->wb_clk;
  }
}
