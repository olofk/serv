#include <stdint.h>
#include <signal.h>

#include "verilated_vcd_c.h"
#include "Vserv_wrapper.h"

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
	uint32_t insn = 0;
	uint32_t ex_pc = 0;

	int uart_state = 0;
	char uart_ch = 0;
	Verilated::commandArgs(argc, argv);

	Vserv_wrapper* top = new Vserv_wrapper;

	const char *vcd = Verilated::commandArgsPlusMatch("vcd=");
	//if (vcd[0]) == '\0' || atoi(arg + 11) != 0)
	Verilated::traceEverOn(true);
        VerilatedVcdC* tfp = new VerilatedVcdC;
        top->trace (tfp, 99);
        tfp->open ("trace.vcd");

	signal(SIGINT, INThandler);

	top->wb_clk = 1;
	bool q = top->q;
	while (!(done || Verilated::gotFinish())) {
	  top->eval();
	  tfp->dump(main_time);
	  /*if (q != top->q) {
	    q = top->q;
	    printf("%lu output is %s\n", main_time, q ? "ON" : "OFF");
	    }*/
	  top->wb_clk = !top->wb_clk;
	  main_time+=31.25;
	}
	tfp->close();
	exit(0);
}
