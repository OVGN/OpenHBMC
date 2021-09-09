## OpenHBMC demo projects

This folder contains OpenHBMC example projects:

- mb_single_ram - Microblaze CPU with a single HyperRAM controller
- mb_dual_ram - Microblaze CPU with two HyperRAM controllers

## How to use:
1. Download entire repository.
2. Open Vivado - Tcl Console and type: `source  C:\some_your_path\OpenHBMC\examples\mb_single_ram mb_single_ram.tcl`
3. This .tcl script generate a `vivado_project` folder, which contains usual Vivado project structure for mb_single_ram demo.
4. To fit your hardware, probably some changes to constraints, input clock frequency, generated MMCM clocks should be done.
5. To lauch memory test project, open Vitis - File - Import - Vitis project exported zip file - next - add path to the project archive: `examples\mb_single_ram\src\sdk\vitis_export_archive.ide.zip`
6. Note that Vitis project do not include FPGA bitstream, that's why, first, program FPGA with bitstream in Vivado, before running memtest.



