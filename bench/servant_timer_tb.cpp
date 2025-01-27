#include <fcntl.h>
#include <stdint.h>
#include <signal.h>

#include "verilated_vcd_c.h"
#include "Vservant_timer_sim.h"

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

void INThandler(int signal)
{
  printf("\nCaught ctrl-c\n");
  done = true;
}

int main(int argc, char **argv, char **env)
{
  int baud_rate = 0;

  Verilated::commandArgs(argc, argv);

  Vservant_timer_sim* top = new Vservant_timer_sim;

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

  vluint64_t vcd_start = 0;
  const char *arg_vcd_start = Verilated::commandArgsPlusMatch("vcd_start=");
  if (arg_vcd_start[0])
    vcd_start = atoi(arg_vcd_start+11);

  int cur_cycle = 0;
  int last_cycle = 0;
  std::time_t last_time = std::time(nullptr);

  top->wb_clk = 0;
  top->timer_clk = 0;
  bool q = top->q;
  int clock = 0;
  top->eval();
  while (!(done || Verilated::gotFinish())) {
    top->eval();
    if (top->wb_clk) {
      clock++;
    }
    top->wb_rst = main_time < 1000;
    if (tfp) {
      tfp->dump(main_time);
    }
    if (top->wb_clk && top->pc_vld && top->pc_adr) {
      std::this_thread::sleep_for(std::chrono::milliseconds(500));
      printf("%d | %d\n", clock, top->pc_adr);
    }
    if (timeout && (main_time >= timeout)) {
      printf("Timeout: Exiting at time %lu\n", main_time);
      done = true;
    }
    top->wb_clk = !top->wb_clk;
    top->timer_clk = top->wb_clk;
    main_time+=31.25;
  }
  if (tfp) {
    tfp->close();
  }
  exit(0);
}
