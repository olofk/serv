#include <fcntl.h>
#include <stdint.h>
#include <signal.h>

#include "verilated_vcd_c.h"
#include "Vservant_sim.h"

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

typedef struct {
  bool last_value;
} gpio_context_t;

void do_gpio(gpio_context_t *context, bool gpio) {
  if (context->last_value != gpio) {
    context->last_value = gpio;
    printf("%lu output q is %s\n", main_time, gpio ? "ON" : "OFF");
  }
}

typedef struct {
  uint8_t state;
  char ch;
  uint32_t baud_t;
  vluint64_t last_update;
} uart_context_t;

void uart_init(uart_context_t *context, uint32_t baud_rate) {
  context->baud_t = 1000*1000*1000/baud_rate;
  context->state = 0;
}

bool do_uart(uart_context_t *context, bool rx) {
  if (context->state == 0) {
    if (rx)
      context->state++;
  }
  else if (context->state == 1) {
    if (!rx) {
      context->last_update = main_time + context->baud_t/2;
      context->state++;
    }
  }
  else if(context->state == 2) {
    if (main_time > context->last_update) {
      context->last_update += context->baud_t;
      context->ch = 0;
      context->state++;
    }
  }
  else if (context->state < 11) {
    if (main_time > context->last_update) {
      context->last_update += context->baud_t;
      context->ch |= rx << (context->state-3);
      context->state++;
    }
  }
  else {
    if (main_time > context->last_update) {
      context->last_update += context->baud_t;
      context->state=1;
      return true;
    }
  }
  return false;
}

int main(int argc, char **argv, char **env)
{
  int baud_rate = 0;

  gpio_context_t gpio_context;
  uart_context_t uart_context;
  Verilated::commandArgs(argc, argv);

  Vservant_sim* top = new Vservant_sim;

  const char *arg = Verilated::commandArgsPlusMatch("uart_baudrate=");
  if (arg[0]) {
    baud_rate = atoi(arg+15);
    if (baud_rate) {
      uart_init(&uart_context, baud_rate);
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

  int tf = 0;
  const char *arg_trace_pc = Verilated::commandArgsPlusMatch("trace_pc=");
  if (arg_trace_pc[0])
    tf = open("trace.bin", O_WRONLY | O_CREAT | O_TRUNC, S_IRWXU);

  vluint64_t timeout = 0;
  const char *arg_timeout = Verilated::commandArgsPlusMatch("timeout=");
  if (arg_timeout[0])
    timeout = atoi(arg_timeout+9);

  vluint64_t vcd_start = 0;
  const char *arg_vcd_start = Verilated::commandArgsPlusMatch("vcd_start=");
  if (arg_vcd_start[0])
    vcd_start = atoi(arg_vcd_start+11);

  bool dump = false;
  top->wb_clk = 1;
  bool q = top->q;
  while (!(done || Verilated::gotFinish())) {
    if (tfp && !dump && (main_time > vcd_start)) {
      dump = true;
    }
    top->wb_rst = main_time < 100;
    top->eval();
    if (dump)
      tfp->dump(main_time);
    if (baud_rate) {
      if (do_uart(&uart_context, top->q))
	putchar(uart_context.ch);
    } else {
      do_gpio(&gpio_context, top->q);
    }
    if (tf && top->wb_clk && top->pc_vld)
      write(tf, (void *)&top->pc_adr, 4);
    if (timeout && (main_time >= timeout)) {
      printf("Timeout: Exiting at time %lu\n", main_time);
      done = true;
    }

    top->wb_clk = !top->wb_clk;
    main_time+=31.25;

  }
  close(tf);
  if (tfp)
    tfp->close();
  exit(0);
}
