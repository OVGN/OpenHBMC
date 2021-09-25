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
- Supports AXI4 address width up to 64-bit 
- Supports all AXI4 burst types and sizes:
    - AXI4 INCR burst sizes up to 256 data beats (long transfers are automatically splitted into parts to meet maximum CS# low limitation)
    - AXI4 FIXED bursts are treated as INCR burst type
    - AXI4 WRAP bursts of  2, 4, 8, 16 data beats
- Supports HyperBUS frequency up to **200MHz**
- No need to make any kind of calibration with new DRU (data recovery module)
- Resource utilization: 781-LUT, 975-FF, 1-RAMB36E1 (RAMB36E1 = 2 x RAMB18E1)

## How to use:
1. Download and copy the OpenHBMC folder with all entire files to your local IP-repo directory.
2. Open Vivado and click Tools - Settings - IP - Repository, click "+" to add a path to your IP-repo directory, click "Refresh All".
3. Now OpenHBMC will appear in IP-catalog and may be avaliable both for standalone or block design integration.

<p align="left">
  <img src="/OpenHBMC/data/ipcore_opt_0.png">
</p>

<p align="left">
  <img src="/OpenHBMC/data/ipcore_opt_1.png">
</p>

## Status:
- Successfully passes memory test at 200MHz (i.e. < 400MB/s) on a real hardware (Spartan-7 + W956D8MBYA5I)
- Running heavy load tests, using several AXI traffic generators.

## TODO:
- ~~Achieve 200MHz HyperBus clock frequency.~~ DONE.
- ~~Add advanced RWDS strobe delay calibration procedure.~~ DONE. No more calibration needed.
- ~~Helloworld example project.~~ DONE.
- Add command queuing to maximize HyperRAM bus utilization. 
- Replace Xilinx FIFOs IP cores with custom FIFOs.
- Add AXI4-Lite slave port for configuration registers access.
- Add multi-bank (commom data bus) modes to increase memory bandwidth. Dual or Quad rank modes?
- Add HyperFlash support.
- Formal verification.

## Donations:
Your support makes such kind of projects happen! =)
<p align="left">
  <img src="/OpenHBMC/data/wallets.png">
</p>
