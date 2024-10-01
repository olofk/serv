Overview
========

The SERV RISC-V CPU is an award-winning and highly compact processor core based on the RISC-V instruction set architecture (ISA). It is designed to be the smallest possible RISC-V compliant CPU and is particularly well-suited for embedded systems and applications where silicon area is critical.

Key Features
------------

* **ISA:** RISC-V RV32IZifencei
* **Optional ISA extensions:** C, M, Zicsr
* **Optional features:** Timer interrupts, Extension interface
* **Architecture:** Bit-serial (one bit processed per clock cycle)
* **License:** ISC (available under other commercial licenses upon request)
* **OS support:** Zephyr 3.7
* **SW support:** Compatible with standard RISC-V toolchains
* **Area:** Smallest RISC-V core available

Applications
------------

* **Embedded Systems:** Ideal for minimalistic embedded control tasks
* **IoT Devices:** Suitable for Internet of Things devices where space and power are limited
* **Education:** Excellent resource for teaching and understanding the RISC-V architecture and CPU design
* **Research:** Platform for research in minimalistic computing designs and for bringing up new fabrication processes

Area
----

.. list-table:: Area for minimal configuration [#]_
   :widths: 25 25 25 25
   :header-rows: 1

   * - Lattice iCE40
     - Altera Cyclone10LP
     - AMD Artix-7
     - CMOS
   * - 198LUT/164FF
     - 239LUT/164FF
     - 125LUT/164FF
     - 2.1kGE

.. [#] Excluding register file
