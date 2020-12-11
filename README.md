# OpenHBMC

OpenHBMC is an open-source AXI4-based high performance HyperBus memory controller for Xilinx 7-series FPGAs.
IP-core is packed for easy Vivado 2020.2 block design integration.

<p align="center">
  <img src="/OpenHBMC/data/ipcore_bd.png">
</p>

## Features:

- Supports HyperRAM 1.0 and HyperRAM 2.0
- Supports 3.3V & 1.8V power modes
- Supports AXI4 data width of 16/32/64-bit 
- Supports all AXI4 burst types and sizes:
    - AXI4 INCR burst sizes up to 256 data beats (long transfers are automatically splitted into parts to meet maximum CS# low limitation)
    - AXI4 FIXED bursts are treated as INCR burst type
    - AXI4 WRAP bursts of  2, 4, 8, 16 data beats
- No AXI4 read or write reordering
- Current resource utilization: 569-LUT, 790-FF, 1.5-BRAM (1.5 x RAMB36E1 = 3 x RAMB18E1)
- Minimum HyperBus clock frequency is limited to 100MHz (due to IDELAY 2.5ns limitations)

## How to use:
1. Download and copy the OpenHBMC folder with all entire files to your local IP-repo directory.
2. Open Vivado and click Tools - Settings - IP - Repository, click "+" to add a path to your IP-repo directory, click "Refresh All".
3. Now OpenHBMC will appear in IP-catalog and may be avaliable both for standalone or block design integration.

<p align="left">
  <img src="/OpenHBMC/data/ipcore_bd_opt.png">
</p>

## Status:
- Successfully passed memory test at 162.5MHz (or 325MB/s) on a real hardware (Spartan-7 + IS66WVH8M8ALL-166B1LI)
- All types of AXI4 bursts were simulated, but not all of them were verified and tested on hardware.

## TODO:
- Achieve 200MHz HyperBus clock frequency.
- Add AXI4-Lite slave port for configuration registers access.
- Add advanced RWDS strobe delay calibration procedure.
- Add multi-bank (commom data bus) modes to increase memory bandwidth. Dual or Quad rank modes?
- Add HyperFlash support.

## Donations:
Your support makes such kind of projects happen! =)
<p align="left">
  <img src="/OpenHBMC/data/wallets.png">
</p>
