#----------------------------------------------------------------------------
# Project:  OpenHBMC
# Filename: OpenHBMC.xdc
# Purpose:  OpenHBMC IP core constraints.
#----------------------------------------------------------------------------
# Copyright © 2020-2022, Vaagn Oganesyan <ovgn@protonmail.com>
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

# Set output false path, timings are met by design
set_false_path -to [get_ports hb_ck_p]
set_false_path -to [get_ports hb_ck_n]
set_false_path -to [get_ports hb_rwds]
set_false_path -to [get_ports hb_dq[*]]

# Set input false path. DQ[*] and RWDS are supposed to
# be fully asynchronous for the data recovery logic
set_false_path -from [get_ports hb_rwds]
set_false_path -from [get_ports hb_dq[*]]

#----------------------------------------------------------------------------

# Pack 'cs_n' and 'reset_n' registers in IOBs for best output timings
set_property IOB TRUE [get_cells -hierarchical cs_n_reg]
set_property IOB TRUE [get_cells -hierarchical reset_n_reg]

# False path for 'hb_cs_n' and 'hb_reset_n'
set_false_path -to [get_ports hb_cs_n]
set_false_path -to [get_ports hb_reset_n]

#----------------------------------------------------------------------------

# Single bit synchronizer false path
set_false_path -to [get_pins -hierarchical *d_sync_reg*[0]/D]

#----------------------------------------------------------------------------

# Asynchronous reset synchronizer false path
set_false_path -through [get_pins -of_objects [get_cells -hierarchical hbmc_arst_sync*] -filter {NAME =~ *arst}]

#----------------------------------------------------------------------------

# Set minimum period of 'clk_hbmc_0' (200MHz)
set clk_hbmc_0_min_period 5.000

# Set max delay constraint for 'hbmc_bus_sync' data path for at least 2 stages of single bit synchronizer (PERIOD * 2)
set_max_delay [expr {$clk_hbmc_0_min_period * 2}] -through [get_pins -of_objects [get_cells -hierarchical hbmc_bus_sync*] -filter {NAME =~ *src_data*}]

#----------------------------------------------------------------------------

