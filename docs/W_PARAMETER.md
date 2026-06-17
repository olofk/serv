\# W Parameter Documentation



\## Overview

The W parameter controls the processing width of the SERV CPU. Currently, only W=1 (bit-serial) is fully supported and tested.



\## Quick Answer



\*\*Q: Can I use W>1?\*\*  

\*\*A:\*\* No, only W=1 is currently supported.



\*\*Q: Why does W parameter exist?\*\*  

\*\*A:\*\* The infrastructure for multi-bit support exists, but the implementation is incomplete.



\*\*Q: What should I use?\*\*  

\*\*A:\*\* Always use the default W=1 (bit-serial operation).



\*\*Q: Where can I find a working multi-bit version?\*\*  

\*\*A:\*\* See \[qerv](https://github.com/olofk/qerv) for a 4-bit (W=4) reference implementation.



---



\## Current Status

\-  \*\*W=1 (Bit-Serial):\*\* Fully functional and tested

\-  \*\*W>1 (Parallel):\*\* Infrastructure exists but incomplete



---



\## Parameter Definition



From `rtl/serv\_top.v` (line 11):

```verilog

module serv\_top

&nbsp; #(parameter    WITH\_CSR = 1,

&nbsp;   parameter    W = 1,           // Processing width

&nbsp;   parameter    B = W-1,          // Bus width index

&nbsp;   ...

```



\*\*Key Relationships:\*\*

\- `W` = Processing width (bits processed per clock cycle)

\- `B = W-1` = Bus width index, used throughout signal declarations as `\[B:0]`

\- Default value: `W = 1` (bit-serial operation)

\- The W parameter is passed to all major submodules: serv\_state, serv\_immdec, serv\_bufreg, serv\_ctrl, serv\_alu, etc.



---



\## Testing Results



\### Test Environment

\- \*\*Tool:\*\* Vivado 2025.1

\- \*\*Target Device:\*\* xc7a35tcpg236-1 (Artix-7)

\- \*\*Method:\*\* Synthesis with FuseSoC parameter override

\- \*\*Test Date:\*\* December 2024

\- \*\*Testing Notes:\*\* Performed by community contributor while learning SERV architecture



\### W=1 (Bit-Serial) -  RECOMMENDED



\*\*Command:\*\*

```bash

fusesoc run --tool=vivado award-winning:serv:serv --pnr=none --part=xc7a35tcpg236-1

```



\*\*Resource Usage:\*\*



| Resource | Utilization | Available | Percentage |

|----------|-------------|-----------|------------|

| Slice LUTs | 173 | 20,800 | 0.83% |

| Slice Registers | 182 | 41,600 | 0.44% |

| Block RAM Tile | 0.5 | 50 | 1% |



\*\*Status:\*\*  Fully functional with no critical warnings



\*\*Conclusion:\*\* W=1 is the \*\*only\*\* recommended configuration. This is the default, fully tested, and production-ready setting that demonstrates SERV's exceptional resource efficiency as the world's smallest RISC-V CPU.



---



\### W=2 (2-bit Parallel) -  NOT SUPPORTED



\*\*Command:\*\*

```bash

fusesoc run --tool=vivado award-winning:serv:serv --pnr=none --part=xc7a35tcpg236-1 --W=2

```



\*\*Resource Usage:\*\*



| Resource | Utilization | Available | Percentage | Change vs W=1 |

|----------|-------------|-----------|------------|---------------|

| Slice LUTs | 63 | 20,800 | 0.30% | -64% |

| Slice Registers | 80 | 41,600 | 0.19% | -56% |

| Block RAM Tile | 0.5 | 50 | 1% | No change |



\*\*Status:\*\*  Synthesizes but produces critical warnings



\*\*Critical Warnings:\*\*

```

WARNING: \[Synth 8-324] index 2 out of range \[serv\_csr.v:151]

WARNING: \[Synth 8-324] index 3 out of range \[serv\_immdec.v:137]

WARNING: \[Synth 8-324] index 2 out of range \[serv\_immdec.v:138]

WARNING: \[Synth 8-324] index 3 out of range \[serv\_immdec.v:226]

WARNING: \[Synth 8-324] index 2 out of range \[serv\_immdec.v:227]

```



\*\*Analysis:\*\* The \*\*lower\*\* resource usage is NOT an improvement. It indicates that Vivado's optimizer removed broken logic due to out-of-range bit accesses. The synthesized design would not function correctly on actual hardware.



\*\*Conclusion:\*\* W=2 is not currently supported and should not be used.



---



\## Known Issues



The following files contain hardcoded bit indices that assume W=1:



\### 1. rtl/serv\_csr.v

\- \*\*Line 151:\*\* Hardcoded index causes out-of-range access when W>1



\### 2. rtl/serv\_immdec.v

\- \*\*Lines 137, 138:\*\* Hardcoded indices 2 and 3 out of range when W>1

\- \*\*Lines 226, 227:\*\* Hardcoded indices 2 and 3 out of range when W>1



These hardcoded indices cause synthesis warnings and result in non-functional designs when W>1.



---



\## Recommendation



\*\*For all designs, use W=1 (default bit-serial operation).\*\*



Using W>1 is not recommended until the hardcoded indices in the files listed above are fixed to properly scale with the W parameter.



---



\## Design Philosophy



SERV's bit-serial architecture (W=1) is \*\*intentional by design\*\* and provides:



\- \*\*Minimal area\*\* - World's smallest RISC-V CPU (~170-200 LUTs)

\- \*\*Simple timing\*\* - Single-bit operations meet timing constraints easily

\- \*\*Predictable behavior\*\* - No complex multi-bit datapaths to debug

\- \*\*Educational value\*\* - Easier to understand and learn RISC-V architecture



Increasing W trades area efficiency for performance, which contradicts SERV's core design goal of being the smallest possible RISC-V implementation. For performance-oriented applications, consider traditional RISC-V cores or the 4-bit \[qerv](https://github.com/olofk/qerv) variant.



---



\## Parameter Override Method



To test different W values during synthesis (for experimental purposes only):

```bash

\# General format

fusesoc run --tool=vivado award-winning:serv:serv --pnr=none --part=<FPGA\_PART> --W=<VALUE>



\# Example for W=2 (not recommended for actual use)

fusesoc run --tool=vivado award-winning:serv:serv --pnr=none --part=xc7a35tcpg236-1 --W=2

```



\*\*Note:\*\* The source files remain unchanged; the `--W=` flag overrides the default parameter value during synthesis only.



---



\## Future Work



For those interested in multi-bit width support, reference implementations and ongoing work include:



\- \*\*\[qerv](https://github.com/olofk/qerv)\*\* - A 4-bit width version (W=4) that contains fixes for wider processing widths

\- Study the differences between SERV and qerv to understand what changes are needed

\- The maintainer has indicated that work is ongoing to support multiple widths in SERV



---



\## Related Issues



\- \*\*Issue #140:\*\* "Is it possible to set the processing width with the 'width'/'W' parameter?"

&nbsp; - This documentation addresses the question raised in this issue



---



\## Testing Methodology



All synthesis tests were performed using the following procedure:



1\. \*\*Clean workspace:\*\* `rm -rf build` before each test to ensure fresh synthesis

2\. \*\*Synthesis only:\*\* Used `--pnr=none` flag (no place-and-route) for faster results

3\. \*\*Resource utilization:\*\* Data collected from Vivado synthesis reports

4\. \*\*Warning capture:\*\* All synthesis warnings documented from console output

5\. \*\*Tool version:\*\* Vivado 2025.1 on Windows with MSYS2/MinGW64



---



\## Contributing



For developers interested in contributing W>1 support:



The maintainer has indicated that work is ongoing but not yet complete. If you'd like to help:



1\. \*\*Study the reference:\*\* Examine the \[qerv repository](https://github.com/olofk/qerv) to see how 4-bit width is implemented

2\. \*\*Compare implementations:\*\* Identify specific differences between SERV and qerv

3\. \*\*Propose fixes:\*\* Address the hardcoded indices in serv\_csr.v and serv\_immdec.v to scale with the W parameter

4\. \*\*Test thoroughly:\*\* Ensure changes work for W=1, W=2, and W=4 without breaking existing W=1 functionality

5\. \*\*Submit changes:\*\* Create a pull request with detailed testing results and documentation



Any contributions should maintain SERV's core design goal of minimal resource usage while extending multi-width support.



---



\## Conclusion



The W parameter infrastructure exists in SERV's codebase, but \*\*only W=1 is currently supported and tested\*\*. The default bit-serial operation (W=1) aligns with SERV's design philosophy of being the world's smallest RISC-V CPU and should be used for all implementations until multi-width support is completed.



---



\*\*Document Version:\*\* 1.0  

\*\*Last Updated:\*\* December 16, 2024  

\*\*Status:\*\* Community-contributed documentation based on synthesis testing

