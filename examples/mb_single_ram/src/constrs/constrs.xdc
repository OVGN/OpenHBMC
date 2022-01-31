#----------------------------------------------------------------------------
# Project:  OpenHBMC
# Filename: constrs.xdc
# Purpose:  OpenHBMC example project constraint file for Spartan-7 FPGA
#           XC7S50-1CSG324C. Fix pin assignments, IO standard parameters
#           and clock frequency constraints to fit you hardware.
#----------------------------------------------------------------------------
# Copyright © 2020-2021, Vaagn Oganesyan <ovgn@protonmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#----------------------------------------------------------------------------




#-------------------------------------CLK------------------------------------

set_property PACKAGE_PIN F14 [get_ports clkin]
set_property IOSTANDARD LVCMOS33 [get_ports clkin]

# 27MHz clock input
create_clock -period 37.037 -name clock_clkin -waveform {0.000 18.519} [get_ports clkin]

#----------------------------------HyperRAM----------------------------------

set_property PACKAGE_PIN T1 [get_ports hram_ck_p]
set_property PACKAGE_PIN U1 [get_ports hram_ck_n]
set_property PACKAGE_PIN V5 [get_ports hram_reset_n]
set_property PACKAGE_PIN V3 [get_ports hram_cs_n]
set_property PACKAGE_PIN U2 [get_ports hram_rwds]
set_property PACKAGE_PIN M3 [get_ports {hram_dq[0]}]
set_property PACKAGE_PIN N3 [get_ports {hram_dq[1]}]
set_property PACKAGE_PIN R2 [get_ports {hram_dq[2]}]
set_property PACKAGE_PIN K2 [get_ports {hram_dq[3]}]
set_property PACKAGE_PIN K1 [get_ports {hram_dq[4]}]
set_property PACKAGE_PIN L1 [get_ports {hram_dq[5]}]
set_property PACKAGE_PIN M2 [get_ports {hram_dq[6]}]
set_property PACKAGE_PIN N1 [get_ports {hram_dq[7]}]

set_property IOSTANDARD LVCMOS18 [get_ports hram_ck_p]
set_property IOSTANDARD LVCMOS18 [get_ports hram_ck_n]
set_property IOSTANDARD LVCMOS18 [get_ports hram_reset_n]
set_property IOSTANDARD LVCMOS18 [get_ports hram_cs_n]
set_property IOSTANDARD LVCMOS18 [get_ports hram_rwds]
set_property IOSTANDARD LVCMOS18 [get_ports {hram_dq[*]}]
