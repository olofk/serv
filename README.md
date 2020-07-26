<img align="right" src="https://svg.wavedrom.com/{signal:[{wave:'0.P...'},{wave:'023450',data:'S E R V'}]}"/>

# SERV

SERV is an award-winning bit-serial RISC-V core

If you want to know more about SERV, what a bit-serial CPU is and what it's good for, I recommend starting out by watching the movies [introduction to SERV](https://diode.zone/videos/watch/0230a518-e207-4cf6-b5e2-69cc09411013) and the [presentation from the Zürich 2019 RISC-V workshop](https://www.youtube.com/watch?v=xjIxORBRaeQ)

## Prerequisites

Create a directory to keep all the different parts of the project together. We
will refer to this directory as `$SERV` from now on.

Download the main serv repo

`cd $SERV && git clone https://github.com/olofk/serv`

Install FuseSoC

`pip install fusesoc`

Initialize the FuseSoC standard libraries

`fusesoc init`

Create a workspace directory for FuseSoC

`mkdir $SERV/workspace`

Register the serv repo as a core library

`cd $SERV/workspace && fusesoc library add serv $SERV`

Check that the CPU passes the linter

`cd $SERV/workspace && fusesoc run --target=lint serv`

## Running test software

Build and run the single threaded zephyr hello world example with verilator (should be stopped with Ctrl-C):

    cd $SERV/workspace
    fusesoc run --target=verilator_tb servant --uart_baudrate=57600 --firmware=$SERV/serv/sw/zephyr_hello.hex

..or... the multithreaded version

    fusesoc run --target=verilator_tb servant --uart_baudrate=57600 --firmware=$SERV/serv/sw/zephyr_hello_mt.hex --memsize=16384

...or... the philosophers example

    fusesoc run --target=verilator_tb servant --uart_baudrate=57600 --firmware=$SERV/serv/sw/zephyr_phil.hex --memsize=32768

...or... the synchronization example

    fusesoc run --target=verilator_tb servant --uart_baudrate=57600 --firmware=$SERV/serv/sw/zephyr_sync.hex --memsize=16384

Other applications can be tested by compiling and converting to bin and then hex e.g. with makehex.py found in `$SERV/serv/riscv-target/serv`

## Run the compliance tests

Build the verilator model (if not already done)

`cd $SERV/workspace && fusesoc run --target=verilator_tb --setup --build servant`

Download the tests repo

`cd $SERV && git clone https://github.com/riscv/riscv-compliance`

Run the compliance tests

`cd $SERV/riscv-compliance && make TARGETDIR=$SERV/serv/riscv-target RISCV_TARGET=serv RISCV_DECICE=rv32i RISCV_ISA=rv32i TARGET_SIM=$SERV/workspace/build/servant_1.0.1/verilator_tb-verilator/Vservant_sim`

## Run on hardware

The servant SoC has been ported to a number of different FPGA boards. To see all currently supported targets run

    fusesoc core show servant

By default, these targets have the program memory preloaded with a small Zephyr hello world example that writes its output on a UART pin. Don't forget to install the appropriate toolchain (e.g. icestorm, Vivado, Quartus...) and add to your PATH

Some targets also depend on functionality in the FuseSoC base library (fusesoc-cores). Running `fusesoc library list` should tell you if fusesoc-cores is already available. If not, add it to your workspace with

    fusesoc library add fusesoc-cores https://github.com/fusesoc/fusesoc-cores

Now we're ready to build. Note, for all the cases below, it's possible to run with `--memfile=$SERV/sw/blinky.hex`
(or any other suitable program) as the last argument to preload the LED blink example
instead of hello world.

### TinyFPGA BX

Pin A6 is used for UART output with 115200 baud rate.

    cd $SERV/workspace
    fusesoc run --target=tinyfpga_bx servant
    tinyprog --program build/servant_1.0.1/tinyfpga_bx-icestorm/servant_1.0.1.bin

### Icebreaker

Pin 9 is used for UART output with 57600 baud rate.

    cd $SERV/workspace
    fusesoc run --target=icebreaker servant

### OrangeCrab R0.2

Pin D1 is used for UART output with 115200 baud rate.

    cd $SERV/workspace
    fusesoc run --target=orangecrab_r0.2 servant
    dfu-util -d 1209:5af0 -D build/servant_1.0.2/orangecrab_r0.2-trellis/servant_1.0.2.bit

### Arty A7 35T

Pin D10 (uart_rxd_out) is used for UART output with 57600 baud rate (to use
blinky.hex change D10 to H5 (led[4]) in data/arty_a7_35t.xdc).

    cd $SERV/workspace
    fusesoc run --target=arty_a7_35t servant

### Saanlima Pipistrello (Spartan6 LX45)

Pin A10 (usb_data<1>) is used for UART output with 57600 baud rate (to use
blinky.hex change A10 to V16 (led[0]) in data/pipistrello.ucf).

    cd $SERV/workspace
    fusesoc run --target=pipistrello servant

### Alhambra II

Pin 61 is used for UART output with 115200 baud rate. This pin is connected to a FT2232H chip in board, that manages the communications between the FPGA and the computer.

    cd $SERV/workspace
    fusesoc run --target=alhambra servant
    iceprog -d i:0x0403:0x6010:0 build/servant_1.0.1/alhambra-icestorm/servant_1.0.1.bin

## Other targets

The above targets are run on the servant SoC, but there are some targets defined for the CPU itself. Verilator can be run in lint mode to check for design problems by running

    fusesoc run --target=lint serv

It's also possible to just synthesise for different targets to check resource usage and such. To do that for the iCE40 devices, run

    fusesoc run --tool=icestorm serv --pnr=none

...or to synthesize with vivado for Xilinx targets, run

    fusesoc run --tool=vivado serv --pnr=none

This will synthesize for the default Vivado part. To synthesise for a specific device, run e.g.

    fusesoc run --tool=vivado serv --pnr=none --part=xc7a100tcsg324-1


## Good to know

Don't feed serv any illegal instructions after midnight. Many logic expressions are hand-optimized using the old-fashioned method with Karnaugh maps on paper, and shamelessly take advantage of the fact that some opcodes aren't supposed to appear. As serv was written with 4-input LUT FPGAs as target, and opcodes are 5 bits, this can save quite a bit of resources in the decoder.

The bus interface is kind of Wishbone, but with most signals removed. There's an important difference though. Don't send acks on the instruction or data buses unless serv explicitly asks for something by raising its cyc signal. Otherwise serv becomes very confused.

Don't go changing the clock frequency on a whim when running Zephyr. Or well, it's ok I guess, but since the UART is bitbanged, this will change the baud rate as well. As of writing, the UART is running at 115200 baud rate when the CPU is 32 MHz. There are two NOPs in the driver to slow it down a bit, so if those are removed I think it could achieve baud rate 115200 on a 24MHz clock.. in case someone wants to try

## TODO

- Applications have to be preloaded to RAM at compile-time
- Store bootloader and register file together in a RAM
- Make it faster and smaller
