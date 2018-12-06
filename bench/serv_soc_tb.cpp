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
  vluint64_t sample_time = 0;
	uint32_t insn = 0;
	uint32_t ex_pc = 0;
	int baud_rate = 0;
	int baud_t    = 0;
	int uart_state = 0;
	char uart_ch = 0;
	Verilated::commandArgs(argc, argv);

	Vserv_wrapper* top = new Vserv_wrapper;

	const char *arg = Verilated::commandArgsPlusMatch("uart_baudrate=");
	if (arg[0]) {
	  baud_rate = atoi(arg+15);
	  if (baud_rate) {
	    baud_t = 1000*1000*1000/baud_rate;
	  }
	}

	VerilatedVcdC * tfp = 0;
	const char *vcd = Verilated::commandArgsPlusMatch("vcd=");
	if (vcd[0]) {
	  Verilated::traceEverOn(true);
	  tfp = new VerilatedVcdC;
	  top->trace (tfp, 99);
	  tfp->open ("trace.vcd");
	}

	signal(SIGINT, INThandler);

	top->i_clk = 1;
	bool q = top->q;
	while (!(done || Verilated::gotFinish())) {
	  top->eval();
	  if (tfp)
	    tfp->dump(main_time);
	  if (baud_rate) {
	    if (uart_state == 0) {
	      if (!top->q) {
		sample_time = main_time + baud_t/2;
		uart_state++;
	      }
	    }
	    else if(uart_state == 1) {
	      if (main_time > sample_time) {
		sample_time += baud_t;
		uart_ch = 0;
		uart_state++;
	      }
	    }
	    else if (uart_state < 10) {
	      if (main_time > sample_time) {
		sample_time += baud_t;
		uart_ch |= top->q << (uart_state-2);
		uart_state++;
	      }
	    }
	    else {
	      if (main_time > sample_time) {
		sample_time += baud_t;
		putchar(uart_ch);
		uart_state=0;
	      }
	    }
	  }
	  /*else {
	    if (q != top->q) {
	      q = top->q;
	      printf("%lu output q is %s\n", main_time, q ? "ON" : "OFF");
	    }
	    }*/
	  top->i_clk = !top->i_clk;
	  main_time+=31.25;
	}
	if (tfp)
	  tfp->close();
	exit(0);
}
