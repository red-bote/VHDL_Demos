# Counter Demo and VHDL Simulation Demo

This demo builds a simple counter circuit in a new Vivado project. The [project wiki](https://github.com/red-bote/VHDL_Demos/wiki) has a set of instructions to create a new Vivado project. 

This tutorial makes use of example code from Xilinx which is documented in UG687 [XST User Guide for Virtex-6, Spartan-6, and 7 Series Devices UG687](https://docs.xilinx.com/v/u/en-US/xst_v6s6). It's an old publication published for the previous ISE tool, and those devices are out of production but the code examples are useful and relevant in Vivado project. Unfortunately there is no direct official link, however, the code archive nay still be posted [in the AMD Xilinx support forum](https://support.xilinx.com/s/question/0D52E00006hpNo9SAE/xstugexamples-disappeared?language=en_US). Alternatively, the *XSTUG Examples* files have been made available [on github](https://github.com/thomasrussellmurphy/xilinx_xstug_examples).

The new Vivado project should have:

new Vivado project:
- Create new top-level *counters_top*
- Add Files *counters_1.vhd* from "xstug_examples"
- Add _Basys3.xdc_ constraints file
- I/O Port Definitions _clk_, _reset_, _led_

