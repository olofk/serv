<img align="right" src="https://svg.wavedrom.com/{signal:[{wave:'0.P...'},{wave:'023450',data:'S E R V'}]}"/>

# SERV

[![LibreCores](https://www.librecores.org/olofk/serv/badge.svg?style=flat)](https://www.librecores.org/olofk/serv)
[![Join the chat at https://gitter.im/librecores/serv](https://badges.gitter.im/librecores/serv.svg)](https://gitter.im/librecores/serv?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![CI status](https://github.com/olofk/serv/workflows/CI/badge.svg)](https://github.com/olofk/serv/actions?query=workflow%3ACI)
[![Documentation Status](https://readthedocs.org/projects/serv/badge/?version=latest)](https://serv.readthedocs.io/en/latest/?badge=latest)

SERV is an award-winning bit-serial RISC-V core

In fact, the award-winning SERV is the world's smallest RISC-V CPU. It's the perfect companion whenever you need a bit of computation and silicon real estate is at a premium.

If you want to know more about SERV, what a bit-serial CPU is and what it's good for, I recommend starting out by watching the fantastic short SERV movies
* [introduction to SERV](https://www.award-winning.me/serv-introduction/)
* [SERV : RISC-V for a fistful of gates](https://www.award-winning.me/serv-for-a-fistful-of-gates/)
* [SERV: 32-bit is the New 8-bit](https://www.award-winning.me/serv-32-bit-is-the-new-8-bit/)
* [Bit by bit - How to fit 8 RISC V cores in a $38 FPGA board (presentation from the Zürich 2019 RISC-V workshop)](https://www.youtube.com/watch?v=xjIxORBRaeQ)

All SERV videos and more can also be found [here](https://www.award-winning.me/videos/).

There's also an official [SERV user manual](https://serv.readthedocs.io/en/latest/#) with fancy block diagrams, timing diagrams and an in-depth description of how some things work.

## Getting started

:o: Create a root directory to keep all the different parts of the project together. We
will refer to this directory as `$WORKSPACE` from now on.

    $ export WORKSPACE=$(pwd)

All the following commands will be run from this directory unless otherwise stated.
- Install FuseSoC

        $ pip install fusesoc
- Add the FuseSoC standard library 

        $ fusesoc library add fusesoc_cores https://github.com/fusesoc/fusesoc-cores
- The FuseSoC standard library already contain a version of SERV, but if we want to make changes to SERV, run the bundled example or use the Zephyr support, it is better to add SERV as a separate library into the workspace


        $ fusesoc library add serv https://github.com/olofk/serv
    >:warning: The SERV repo will now be available in `$WORKSPACE/fusesoc_libraries/serv`. We will refer to that directory as `$SERV`.
- Install latest version of [Verilator](https://www.veripool.org/wiki/verilator)
- (Optional) To support RISC-V M-extension extension, Multiplication and Division unit (MDU) can be added included into the SERV as a seprate library.

        $ fusesoc library add mdu https://github.com/zeeshanrafique23/mdu
    MDU will be available in `$WORKSPACE/fusesoc_libraries/mdu`

We are now ready to do our first exercises with SERV. If everything above is done correctly,we can use Verilator as a linter to check the SERV source code.

    $ fusesoc run --target=lint serv

If everything worked, the output should look like

    INFO: Preparing ::serv:1.2.1
    INFO: Setting up project

    INFO: Building simulation model
    INFO: Running

After performing all the steps that are mentioned above, the directory structure from the `$WORKSPACE` should look like this:

    .
    $WORKSPACE
    |
    ├── build
    │   └── ...
    ├── fusesoc.conf
    └── fusesoc_libraries
        ├── fusesoc_cores
        │   └── ...
        ├── mdu
        │   └── ...
        └── serv
            └── ...


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

If the [toolchain](https://github.com/riscv-collab/riscv-gnu-toolchain) is installed, other applications can be tested by compiling the assembly prgram and converting to bin and then hex with makehex.py found in [`$SERV/sw`](/sw/). 

:bulb:RISC-V Compressed Extension can be enabled by passing `--compressed=1` parameter. 

## Verification
SERV is verified using RISC-V compliance tests for the base ISA (RV32I) and the implemented extensions (M, C, Zicsr). The instructions on running Compliance tests using RISCOF framework are given in [verif](/verif/) directory.


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

## Systems using SERV

[Servant](https://serv.readthedocs.io/en/latest/servant.html) is the reference platform for SERV. It is a very basic SoC that contains just enough runs Zephyr RTOS. Servant is intended for FPGAs and has been ported to around 20 different FPGA boards. It is also used to run the RISC-V regression test suite.

[CoreScore](https://corescore.store/) is an award-giving benchmark for FPGAs and their synthesis/P&R tools. It tests how many SERV cores that can be put into a particular FPGA.

[Observer](https://github.com/olofk/observer) is a configurable and software-programmable sensor aggregation platform for heterogenous sensors.

[Subservient](https://github.com/olofk/subservient/) is a small technology-independent SERV-based SoC intended for ASIC implementations together with a single-port SRAM.

[Litex](https://github.com/enjoy-digital/litex) is a Python-based framework for creating FPGA SoCs. SERV is one of the 30+ supported cores. A Litex-generated SoC has been used to run DooM on SERV.

## Good to know

Don't feed serv any illegal instructions after midnight. Many logic expressions are hand-optimized using the old-fashioned method with Karnaugh maps on paper, and shamelessly take advantage of the fact that some opcodes aren't supposed to appear. As serv was written with 4-input LUT FPGAs as target, and opcodes are 5 bits, this can save quite a bit of resources in the decoder.

The bus interface is kind of Wishbone, but with most signals removed. There's an important difference though. Don't send acks on the instruction or data buses unless serv explicitly asks for something by raising its cyc signal. Otherwise serv becomes very confused.

Don't go changing the clock frequency on a whim when running Zephyr. Or well, it's ok I guess, but since the UART is bitbanged, this will change the baud rate as well. As of writing, the UART is running at 115200 baud rate when the CPU is 32 MHz. There are two NOPs in the driver to slow it down a bit, so if those are removed I think it could achieve baud rate 115200 on a 24MHz clock.. in case someone wants to try

## TODO

- Applications have to be preloaded to RAM at compile-time
- Make it faster and smaller
