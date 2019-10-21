<img align="right" src="https://svg.wavedrom.com/{signal:[{wave:'0.P...'},{wave:'023450',data:'S E R V'}]}"/>

# SERV

SERV is an award-winning bit-serial RISC-V core

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

Build and run the single threaded zephyr hello world example with verilator

    cd $SERV/workspace
    fusesoc run --target=verilator_tb servant --uart_baudrate=57600 --firmware=$SERV/sw/zephyr_hello.hex

..or... the multithreaded version

    fusesoc run --target=verilator_tb servant --uart_baudrate=57600 --firmware=$SERV/sw/zephyr_hello_mt.hex --memsize=16384

...or... the philosophers example

    fusesoc run --target=verilator_tb servant --uart_baudrate=57600 --firmware=$SERV/sw/zephyr_phil.hex --memsize=32768

...or... the synchronization example

    fusesoc run --target=verilator_tb servant --uart_baudrate=57600 --firmware=$SERV/sw/zephyr_sync.hex --memsize=16384

Other applications can be tested by compiling and converting to bin and then hex e.g. with makehex.py found in `$SERV/serv/riscv-target/serv`

## Run the compliance tests

Build the verilator model (if not already done)

`cd $SERV/workspace && fusesoc run --target=verilator_tb --setup --build servant`

Download the tests repo

`cd $SERV && git clone https://github.com/riscv/riscv-compliance`

Run the compliance tests

`cd $SERV/riscv-compliance && make TARGETDIR=$SERV/serv/riscv-target RISCV_TARGET=serv RISCV_DECICE=rv32i RISCV_ISA=rv32i TARGET_SIM=$SERV/workspace/build/serv_0/verilator_tb-verilator/Vserv_wrapper`

## Run on hardware

Only supported so far is a single threaded Zephyr hello world example on the icebreaker and tinyFPGA BX boards

### TinyFPGA BX

Pin A6 is used for UART output with 115200 baud rate.

    cd $SERV/workspace
    fusesoc run --target=tinyfpga_bx servant
    tinyprog --program build/serv_0/tinyfpga_bx-icestorm/serv_0.bin

### Icebreaker

Pin 9 is used for UART output with 57600 baud rate.

    cd $SERV/workspace
    fusesoc run --target=icebreaker servant

Run with `--firmware=$SERV/sw/blinky.hex` as the last argument to run the LED blink example instead

## Other targets

The above targets are run on the servant SoC, but there are some targets defined for the CPU itself. Verilator can be run in lint mode to check for design problems by running

    fusesoc run --target=lint serv

It's also possible to just synthesise for different targets to check resource usage and such. To do that for the iCE40 devices, run

    fusesoc run --tool=icestorm serv --pnr=none

...or to synthesize with vivado for Xilinx targets, run

    fusesoc run --tool=vivado serv --pnr=none

This will synthesize for the default Vivado part. To synthesise for a specific device, run e.g.

    fusesoc run --tool=vivado serv --pnr=none --part=xc7a100tcsg324-1

At the time of writing, only the icestorm and vivado backends support running synthesis only.

## Good to know

Don't feed serv any illegal instructions after midnight. Many logic expressions are hand-optimized using the old-fashioned method with Karnaugh maps on paper, and shamelessly take advantage of the fact that some opcodes aren't supposed to appear. As serv was written with 4-input LUT FPGAs as target, and opcodes are 5 bits, this can save quite a bit of resources in the decoder.

The bus interface is kind of Wishbone, but with most signals removed. There's an important difference though. Don't send acks on the instruction or data buses unless serv explicitly asks for something by raising its cyc signal. Otherwise serv becomes very confused.

Don't go changing the clock frequency on a whim when running Zephyr. Or well, it's ok I guess, but since the UART is bitbanged, this will change the baud rate as well. As of writing, the UART is running at 115200 baud rate when the CPU is 32 MHz. There are two NOPs in the driver to slow it down a bit, so if those are removed I think it could achieve baud rate 115200 on a 24MHz clock.. in case someone wants to try

## TODO

- Applications have to be preloaded to RAM at compile-time
- Store bootloader and register file together in a RAM
- Make it faster and smaller
