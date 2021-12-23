<img align="right" src="https://svg.wavedrom.com/{signal:[{wave:'0.P...'},{wave:'023450',data:'S E R V'}]}"/>

# SERV

[![LibreCores](https://www.librecores.org/olofk/serv/badge.svg?style=flat)](https://www.librecores.org/olofk/serv)
[![Join the chat at https://gitter.im/librecores/serv](https://badges.gitter.im/librecores/serv.svg)](https://gitter.im/librecores/serv?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![CI status](https://github.com/olofk/serv/workflows/CI/badge.svg)](https://github.com/olofk/serv/actions?query=workflow%3ACI)
[![Documentation Status](https://readthedocs.org/projects/serv/badge/?version=latest)](https://serv.readthedocs.io/en/latest/?badge=latest)

SERV is an award-winning bit-serial RISC-V core

If you want to know more about SERV, what a bit-serial CPU is and what it's good for, I recommend starting out by watching the fantastic short SERV movies
* [introduction to SERV](https://www.award-winning.me/serv-introduction/)
* [SERV : RISC-V for a fistful of gates](https://www.award-winning.me/serv-for-a-fistful-of-gates/)
* [Bit by bit - How to fit 8 RISC V cores in a $38 FPGA board (presentation from the Zürich 2019 RISC-V workshop)](https://www.youtube.com/watch?v=xjIxORBRaeQ)

There's also an official [SERV user manual](https://serv.readthedocs.io/en/latest/#) with fancy block diagrams, timing diagrams and an in-depth description of how some things work.

## Prerequisites

Create a directory to keep all the different parts of the project together. We
will refer to this directory as `$WORKSPACE` from now on. All commands will be run from this directory unless otherwise stated.

Install FuseSoC

`pip install fusesoc`

Add the FuseSoC standard library

`fusesoc library add fusesoc_cores https://github.com/fusesoc/fusesoc-cores`

The FuseSoC standard library already contain a version of SERV, but if we want to make changes to SERV, run the bundled example or use the Zephyr support, it is better to add SERV as a separate library into the workspace

`fusesoc library add serv https://github.com/olofk/serv`

The SERV repo will now be available in $WORKSPACE/fusesoc_libraries/serv. To save some typing, we will refer to that directory as `$SERV`.

We are now ready to do our first exercises with SERV

If [Verilator](https://www.veripool.org/wiki/verilator) is installed, we can use that as a linter to check the SERV source code

`fusesoc run --target=lint serv`

If everything worked, the output should look like

    INFO: Preparing ::serv:1.2.0
    INFO: Setting up project

    INFO: Building simulation model
    INFO: Running

## Running pre-built test software

Build and run the single threaded zephyr hello world example with verilator (should be stopped with Ctrl-C):

    fusesoc run --target=verilator_tb servant --uart_baudrate=57600 --firmware=$SERV/sw/zephyr_hello.hex

..or... the multithreaded version

    fusesoc run --target=verilator_tb servant --uart_baudrate=57600 --firmware=$SERV/sw/zephyr_hello_mt.hex --memsize=16384

Both should yield an output ending with

    ***** Booting Zephyr OS zephyr-v1.14.1-4-gc7c2d62513fe *****
    Hello World! service

For a more advanced example, we can also run the Dining philosophers demo

    fusesoc run --target=verilator_tb servant --uart_baudrate=57600 --firmware=$SERV/sw/zephyr_phil.hex --memsize=32768

...or... the synchronization example

    fusesoc run --target=verilator_tb servant --uart_baudrate=57600 --firmware=$SERV/sw/zephyr_sync.hex --memsize=16384

Other applications can be tested by compiling and converting to bin and then hex e.g. with makehex.py found in `$SERV/sw`

## Run RISC-V compliance tests

Build the verilator model (if not already done)

    fusesoc run --target=verilator_tb --build servant --memsize=8388608

To build the verilator model with MDU (for M extension compliance tests):

    fusesoc run --target=verilator_tb --flag=mdu --build servant --memsize=8388608

To build the verilator model with C extension (for Compressed extension compliance tests):

    fusesoc run --target=verilator_tb --build servant --memsize=8388608 --compressed=1

Download the tests repo

    git clone --branch 2.7.4 https://github.com/riscv-non-isa/riscv-arch-test.git

To run the RISC-V compliance tests, we need to supply the SERV-specific support files and point the test suite to where it can find a target to run (i.e. the previously built Verilator model)

Run the compliance tests

    cd riscv-arch-test && make TARGETDIR=$SERV/riscv-target RISCV_TARGET=serv RISCV_DEVICE=I TARGET_SIM=$WORKSPACE/build/servant_1.2.0/verilator_tb-verilator/Vservant_sim

The above will run all tests in the rv32i test suite. Since SERV also implement the `M`, `C`, `privilege` and `Zifencei` extensions, these can also be tested by choosing any of them instead of `I` as the `RISCV_DEVICE` variable.

## Run on hardware

The servant SoC has been ported to an increasing number of different FPGA boards. To see all currently supported targets run

    fusesoc core show servant

By default, these targets have the program memory preloaded with a small Zephyr hello world example that writes its output on a UART pin. Don't forget to install the appropriate toolchain (e.g. icestorm, Vivado, Quartus...) and add to your PATH

Some targets also depend on functionality in the FuseSoC base library (fusesoc-cores). Running `fusesoc library list` should tell you if fusesoc-cores is already available. If not, add it to your workspace with

    fusesoc library add fusesoc-cores https://github.com/fusesoc/fusesoc-cores

Now we're ready to build. Note, for all the cases below, it's possible to run with `--memfile=$SERV/sw/blinky.hex`
(or any other suitable program) as the last argument to preload the LED blink example
instead of hello world.

### TinyFPGA BX

Pin A6 is used for UART output with 115200 baud rate.

    fusesoc run --target=tinyfpga_bx servant
    tinyprog --program build/servant_1.0.1/tinyfpga_bx-icestorm/servant_1.0.1.bin

### Icebreaker

Pin 9 is used for UART output with 57600 baud rate.

    fusesoc run --target=icebreaker servant

### Nexys 2

Pmod pin JA1 is conntected to UART tx with 57600 baud rate. A USB to TTL connector is used to display to hello world message on the serial monitor. 
(To use blinky.hex change L15 to J14 (led[0]) in data/nexys_2.ucf).

    fusesoc run --target=nexys_2_500 servant --uart_baudrate=57600 --firmware=$SERV/sw/zephyr_hello.hex

### ICE-V Wireless

Pin 9 is used for UART output with 57600 baud rate.

    fusesoc run --target=icev_wireless servant

    iceprog build/servant_1.2.0/icestick-icestorm/servant_1.2.0.bin


### iCESugar

Pin 6 is used for UART output with 115200 baud rate. Thanks to the onboard
debugger, you can just connect the USB Type-C connector to the PC, and a
serial console will show up.

    fusesoc run --target=icesugar servant

### OrangeCrab R0.2

Pin D1 is used for UART output with 115200 baud rate.

    fusesoc run --target=orangecrab_r0.2 servant
    dfu-util -d 1209:5af0 -D build/servant_1.2.0/orangecrab_r0.2-trellis/servant_1.2.0.bit

### Arty A7 35T

Pin D10 (uart_rxd_out) is used for UART output with 57600 baud rate (to use
blinky.hex change D10 to H5 (led[4]) in data/arty_a7_35t.xdc).

    fusesoc run --target=arty_a7_35t servant

### Chameleon96 (Arrow 96 CV SoC Board)

FPGA Pin W14 (1V8, pin 5 low speed connector) is used for UART Tx output with 115200 baud rate. No reset key. Yellow Wifi led is q output.

    fusesoc run --target=chameleon96 servant

### DE0 Nano

FPGA Pin D11 (Connector JP1, pin 38) is used for UART output with 57600 baud rate. DE0 Nano needs an external 3.3V UART to connect to this pin

    fusesoc run --target=de0_nano servant

### DE10 Nano

FPGA Pin Y15 (Connector JP7, pin 1) is used for UART output with 57600 baud rate. DE10 Nano needs an external 3.3V UART to connect to this pin

    fusesoc run --target=de10_nano servant

### DECA development kit

FPGA Pin W18 (Pin 3 P8 connector) is used for UART output with 57600 baud rate. Key 0 is reset and Led 0 q output.

    fusesoc run --target=deca servant

### EBAZ4205 'Development' Board

Pin B20 is used for UART output with 57600 baud rate. To use `blinky.hex`
change B20 to W14 (red led) in `data/ebaz4205.xdc` file).

    fusesoc run --target=ebaz4205 servant

    fusesoc run --target=ebaz4205 servant --memfile=$SERV/sw/blinky.hex

Reference: https://github.com/fusesoc/blinky#ebaz4205-development-board

### SoCKit development kit

FPGA Pin F14 (HSTC GPIO addon connector J2, pin 2) is used for UART output with 57600 baud rate.

    fusesoc run --target=sockit servant

### Saanlima Pipistrello (Spartan6 LX45)

Pin A10 (usb_data<1>) is used for UART output with 57600 baud rate (to use
blinky.hex change A10 to V16 (led[0]) in data/pipistrello.ucf).

    fusesoc run --target=pipistrello servant

### Alhambra II

Pin 61 is used for UART output with 115200 baud rate. This pin is connected to a FT2232H chip in board, that manages the communications between the FPGA and the computer.

    fusesoc run --target=alhambra servant
    iceprog -d i:0x0403:0x6010:0 build/servant_1.0.1/alhambra-icestorm/servant_1.0.1.bin

### iCEstick

Pin 95 is used as the GPIO output which is connected to the board's green LED. Due to this board's limited Embedded BRAM, programs with a maximum of 7168 bytes can be loaded. The default program for this board is blinky.hex.

    fusesoc run --target=icestick servant
    iceprog build/servant_1.2.0/icestick-icestorm/servant_1.2.0.bin

### Nandland Go Board

Pin 56 is used as the GPIO output which is connected to the board's LED1. Due to this board's limited Embedded BRAM, programs with a maximum of 7168 bytes can be loaded. The default program for this board is blinky.hex.

    fusesoc run --target=go_board servant
    iceprog build/servant_1.2.0/go_board-icestorm/servant_1.2.0.bin

### Alinx ax309 (Spartan6 LX9)

Pin D12 (the on-board RS232 TX pin) is used for UART output with 115200 baud rate and wired to Pin P4 (LED0).

    fusesoc run --target=ax309 servant

## Other targets

The above targets are run on the servant SoC, but there are some targets defined for the CPU itself. Verilator can be run in lint mode to check for design problems by running

    fusesoc run --target=lint serv

It's also possible to just synthesise for different targets to check resource usage and such. To do that for the iCE40 devices, run

    fusesoc run --tool=icestorm serv --pnr=none

...or to synthesize with vivado for Xilinx targets, run

    fusesoc run --tool=vivado serv --pnr=none

This will synthesize for the default Vivado part. To synthesise for a specific device, run e.g.

    fusesoc run --tool=vivado serv --pnr=none --part=xc7a100tcsg324-1

## Zephyr support

SERV, or rather the Servant SoC, can run the [Zephyr RTOS](https://www.zephyrproject.org). The Servant-specific drivers and BSP is located in the zephyr subdirectory of the SERV repository. In order to use Zephyr on Servant, a project directory structure must be set up that allows Zephyr to load the Servant-specific files as a module.

First, the Zephyr SDK and the "west" build too must be installed. The [Zephyr getting started guide](https://docs.zephyrproject.org/latest/getting_started/index.html) describes these steps in more detail.

Assuming that SERV was installed into `$WORKSPACE/fusesoc_libraries/serv` as per the prerequisites, run the following command to make the workspace also work as a Zephyr workspace.

    west init

Specify the SERV repository as the manifest repository, meaning it will be the main entry point when Zephyr is looking for modules.

    west config manifest.path $SERV

Get the right versions of all Zephyr submodules

    west update

It should now be possible to build Zephyr applications for the Servant SoC within the workspace. This can be tested e.g. by building the Zephyr Hello world samples application

    cd zephyr/samples/hello_world
    west build -b service

After a successful build, Zephyr will create an elf and a bin file of the application in `build/zephyr/zephyr.{elf,bin}`. The bin file can be converted to a verilog hex file, which in turn can be preloaded to FPGA on-chip memories and run on a target board, or loaded into simulated RAM model when running simulations.

To convert the newly built hello world example into a Verilog hex file, run

    python3 $SERV/sw/makehex.py zephyr/samples/hello_world/build/zephyr/zephyr.bin 4096 > hello.hex

4096 is the number of 32-bit words to write and must be at least the size of the application binary. `hello.hex` is the resulting hex file. Running a simulation can now be done as described in [Running pre-built test software](#running-pre-built-test-software), e.g.

    fusesoc run --target=verilator_tb servant --uart_baudrate=57600 --firmware=/path/to/hello.hex

Or to create an FPGA image with the application preloaded to on-chip RAM, e.g. for a Nexys A7 board, run

    fusesoc run --target=nexys_a7 servant --memfile=/path/to/hello.hex

## Good to know

Don't feed serv any illegal instructions after midnight. Many logic expressions are hand-optimized using the old-fashioned method with Karnaugh maps on paper, and shamelessly take advantage of the fact that some opcodes aren't supposed to appear. As serv was written with 4-input LUT FPGAs as target, and opcodes are 5 bits, this can save quite a bit of resources in the decoder.

The bus interface is kind of Wishbone, but with most signals removed. There's an important difference though. Don't send acks on the instruction or data buses unless serv explicitly asks for something by raising its cyc signal. Otherwise serv becomes very confused.

Don't go changing the clock frequency on a whim when running Zephyr. Or well, it's ok I guess, but since the UART is bitbanged, this will change the baud rate as well. As of writing, the UART is running at 115200 baud rate when the CPU is 32 MHz. There are two NOPs in the driver to slow it down a bit, so if those are removed I think it could achieve baud rate 115200 on a 24MHz clock.. in case someone wants to try

## TODO

- Applications have to be preloaded to RAM at compile-time
- Make it faster and smaller
