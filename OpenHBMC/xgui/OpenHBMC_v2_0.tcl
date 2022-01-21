
# Loading additional proc with user specified bodies to compute parameter values.
source [file join [file dirname [file dirname [info script]]] gui/OpenHBMC_v2_0.gtcl]

# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set AXI_Configurations [ipgui::add_page $IPINST -name "AXI Configurations" -display_name {AXI}]
  set_property tooltip {AXI Parameter Configurations} ${AXI_Configurations}
  #Adding Group
  set AXI_parameters [ipgui::add_group $IPINST -name "AXI parameters" -parent ${AXI_Configurations} -display_name {AXI4 Parameters}]
  set_property tooltip {AXI4 Parameters} ${AXI_parameters}
  set C_S_AXI_ADDR_WIDTH [ipgui::add_param $IPINST -name "C_S_AXI_ADDR_WIDTH" -parent ${AXI_parameters}]
  set_property tooltip {C_S_AXI_ADDR_WIDTH <br/> <br/> This parameter is based on Address Editor memory range value and calculated automatically durng Validate Design procedure.} ${C_S_AXI_ADDR_WIDTH}
  set C_S_AXI_DATA_WIDTH [ipgui::add_param $IPINST -name "C_S_AXI_DATA_WIDTH" -parent ${AXI_parameters} -widget comboBox]
  set_property tooltip {C_S_AXI_DATA_WIDTH} ${C_S_AXI_DATA_WIDTH}
  set C_S_AXI_ID_WIDTH [ipgui::add_param $IPINST -name "C_S_AXI_ID_WIDTH" -parent ${AXI_parameters}]
  set_property tooltip {C_S_AXI_ID_WIDTH} ${C_S_AXI_ID_WIDTH}
  set C_S_AXI_ARUSER_WIDTH [ipgui::add_param $IPINST -name "C_S_AXI_ARUSER_WIDTH" -parent ${AXI_parameters}]
  set_property tooltip {C_S_AXI_ARUSER_WIDTH} ${C_S_AXI_ARUSER_WIDTH}
  set C_S_AXI_RUSER_WIDTH [ipgui::add_param $IPINST -name "C_S_AXI_RUSER_WIDTH" -parent ${AXI_parameters}]
  set_property tooltip {C_S_AXI_RUSER_WIDTH} ${C_S_AXI_RUSER_WIDTH}
  set C_S_AXI_AWUSER_WIDTH [ipgui::add_param $IPINST -name "C_S_AXI_AWUSER_WIDTH" -parent ${AXI_parameters}]
  set_property tooltip {C_S_AXI_AWUSER_WIDTH} ${C_S_AXI_AWUSER_WIDTH}
  set C_S_AXI_WUSER_WIDTH [ipgui::add_param $IPINST -name "C_S_AXI_WUSER_WIDTH" -parent ${AXI_parameters}]
  set_property tooltip {C_S_AXI_WUSER_WIDTH} ${C_S_AXI_WUSER_WIDTH}
  set C_S_AXI_BUSER_WIDTH [ipgui::add_param $IPINST -name "C_S_AXI_BUSER_WIDTH" -parent ${AXI_parameters}]
  set_property tooltip {C_S_AXI_BUSER_WIDTH} ${C_S_AXI_BUSER_WIDTH}


  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0" -display_name {Controller}]
  set_property tooltip {Memory Controller Configurations} ${Page_0}
  #Adding Group
  set Memory_options [ipgui::add_group $IPINST -name "Memory options" -parent ${Page_0} -display_name {Memory Options}]
  set C_HBMC_CLOCK_HZ [ipgui::add_param $IPINST -name "C_HBMC_CLOCK_HZ" -parent ${Memory_options}]
  set_property tooltip {Clock frequency in Hz for clk_hbmc_0 and clk_hbmc_90. <br/><br/> clk_hbmc_0 - memory controller clock, 0 degree phase. <br/> clk_hbmc_90 - memory controller clock, 90 degree phase. <br/> <br/> Maximum value depends on memory part capabilities. Current memory controller supports frequencies up to 200MHz. <br/> <br/> NOTE: ISERDES clock frequency MUST be: <br/> <b>clk_iserdes = 3 x clk_hbmc_0</b>} ${C_HBMC_CLOCK_HZ}
  set C_HBMC_CS_MAX_LOW_TIME_US [ipgui::add_param $IPINST -name "C_HBMC_CS_MAX_LOW_TIME_US" -parent ${Memory_options} -widget comboBox]
  set_property tooltip {Chip Select maximum low time. Depends on actual working temperature range and memory part capabilities: <br/></li><li> Industrial - 4us </li><li> Extended - 1us.} ${C_HBMC_CS_MAX_LOW_TIME_US}
  set C_HBMC_FIXED_LATENCY [ipgui::add_param $IPINST -name "C_HBMC_FIXED_LATENCY" -parent ${Memory_options}]
  set_property tooltip {Makes all read and write transactions require the same initial latency. OpenHBMC supports variable latency, that is why it is recommended to leave this parameter unchecked.} ${C_HBMC_FIXED_LATENCY}

  #Adding Group
  set ISERDES_Clocking_Mode [ipgui::add_group $IPINST -name "ISERDES Clocking Mode" -parent ${Page_0} -display_name {Clocking Mode}]
  set_property tooltip {ISERDES Clocking Mode} ${ISERDES_Clocking_Mode}
  set C_ISERDES_CLOCKING_MODE [ipgui::add_param $IPINST -name "C_ISERDES_CLOCKING_MODE" -parent ${ISERDES_Clocking_Mode} -widget comboBox]
  set_property tooltip {<ul>     <li>         <b>BUFIO+BUFR</b> clocking mode. <br/><br/>         This mode has highest performance, though the disadvantage is the clock region routing constraints. To use this mode keep all DQ[7:0] and RWDS lines within a single IO bank.         <br/>         <br/>                  Clock phases: <br>         <ul>             <li>                 <em>clk_hbmc_0</em> and <em>clk_hbmc_90</em> are 90 degree phase aligned.             </li>                          <li>                 <em>clk_iserdes</em> has no any phase alignment requirements in this mode.             </li>         </ul>                  <br/>                  Clocking scheme: <br/>         <ul>                 MMCM/PLL_out_0 -> (no buffer) -> <em>clk_iserdes</em> <br>                 MMCM/PLL_out_1 -> BUFG -> <em>clk_hbmc_0</em> <br>                 MMCM/PLL_out_2 -> BUFG -> <em>clk_hbmc_90</em> <br>         </ul>                  <br/>         <br/>     </li>          <li>         <b>BUFG</b> clocking mode. <br/><br/>         This mode has lower performance, as BUFG is slower than BUFIO. But there is almost no routing constraints.         <br/>         <br/>                  Clock phases: <br>         <ul>             <li>                 <em>clk_hbmc_0</em> and <em>clk_hbmc_90</em> are 90 degree phase aligned.             </li>                          <li>                 <em>clk_iserdes</em> <b>MUST</b> be 0 degree phase aligned to <em>clk_hbmc_0</em> in this mode.             </li>         </ul>                  Clocking scheme: <br/>         <ul>             MMCM/PLL_out_0 -> BUFG -> <em>clk_iserdes</em> <br>             MMCM/PLL_out_1 -> BUFG -> <em>clk_hbmc_0</em> <br>             MMCM/PLL_out_2 -> BUFG -> <em>clk_hbmc_90</em> <br>         </ul>     </li> </ul>} ${C_ISERDES_CLOCKING_MODE}

  #Adding Group
  set IO_configurations [ipgui::add_group $IPINST -name "IO configurations" -parent ${Page_0} -display_name {IO Signal Integrity}]
  set C_HBMC_FPGA_DRIVE_STRENGTH [ipgui::add_param $IPINST -name "C_HBMC_FPGA_DRIVE_STRENGTH" -parent ${IO_configurations} -widget comboBox]
  set_property tooltip {FPGA output drive strength sets the desired buffer output current to meet the load requirements. Proper value depends on various factors, especially the PCB design. Incorrect value may cause non-reliable operation at high frequencies.} ${C_HBMC_FPGA_DRIVE_STRENGTH}
  set C_HBMC_FPGA_SLEW_RATE [ipgui::add_param $IPINST -name "C_HBMC_FPGA_SLEW_RATE" -parent ${IO_configurations} -widget comboBox]
  set_property tooltip {FPGA output slew rate impacts on rise and fall times of the buffer output. Proper value depends on various factors, especially the PCB design. Incorrect value may cause non-reliable operation at high frequencies.} ${C_HBMC_FPGA_SLEW_RATE}
  set C_HBMC_MEM_DRIVE_STRENGTH [ipgui::add_param $IPINST -name "C_HBMC_MEM_DRIVE_STRENGTH" -parent ${IO_configurations} -widget comboBox]
  set_property tooltip {This parameter allows to adjust the DQ[7:0] and RWDS signal output impedance at the memory side to minimize high speed signal behaviors like overshoots, undershoots and ringing. Incorrect value may cause non-reliable operation at high frequencies.} ${C_HBMC_MEM_DRIVE_STRENGTH}


  #Adding Page
  set IODELAY_Configurations [ipgui::add_page $IPINST -name "IODELAY Configurations" -display_name {IODELAY}]
  set_property tooltip {IODELAY Configuration} ${IODELAY_Configurations}
  #Adding Group
  set IODELAY_configuration [ipgui::add_group $IPINST -name "IODELAY configuration" -parent ${IODELAY_Configurations} -display_name {IODELAY Configuration}]
  set C_IODELAY_REFCLK_MHZ [ipgui::add_param $IPINST -name "C_IODELAY_REFCLK_MHZ" -parent ${IODELAY_configuration}]
  set_property tooltip {Value in MHz. Valid ranges: <ul> 190.0 to 210.0 <br/> 290.0 to 310.0 </ul>} ${C_IODELAY_REFCLK_MHZ}
  set C_IODELAY_GROUP_ID [ipgui::add_param $IPINST -name "C_IODELAY_GROUP_ID" -parent ${IODELAY_configuration}]
  set_property tooltip {Specifies group name for associated IDELAYs/ODELAYs and IDELAYCTRL.} ${C_IODELAY_GROUP_ID}
  set C_IDELAYCTRL_INTEGRATED [ipgui::add_param $IPINST -name "C_IDELAYCTRL_INTEGRATED" -parent ${IODELAY_configuration}]
  set_property tooltip {Integrates IDELAYCTRL module that continuosly calibrates individual delay taps (IDELAYs/ODELAYs) in its bank to reduce the effect of PVT (process-voltage-temperature) variations. This option is recommended to be enable by default, except cases when IDELAYCTRL is already used within current IO bank.} ${C_IDELAYCTRL_INTEGRATED}
  #Adding Group
  set RWDS [ipgui::add_group $IPINST -name "RWDS" -parent ${IODELAY_configuration} -layout horizontal]
  set_property tooltip {RWDS} ${RWDS}
  set C_RWDS_USE_IDELAY [ipgui::add_param $IPINST -name "C_RWDS_USE_IDELAY" -parent ${RWDS} -show_label false]
  set_property tooltip {Add IDELAY for RWDS} ${C_RWDS_USE_IDELAY}
  set C_RWDS_IDELAY_TAPS_VALUE [ipgui::add_param $IPINST -name "C_RWDS_IDELAY_TAPS_VALUE" -parent ${RWDS}]
  set_property tooltip {RWDS IDELAY Taps Delay Value (0 - 31)} ${C_RWDS_IDELAY_TAPS_VALUE}

  #Adding Group
  set DQ0 [ipgui::add_group $IPINST -name "DQ0" -parent ${IODELAY_configuration} -layout horizontal]
  set_property tooltip {DQ0} ${DQ0}
  set C_DQ0_USE_IDELAY [ipgui::add_param $IPINST -name "C_DQ0_USE_IDELAY" -parent ${DQ0} -show_label false]
  set_property tooltip {Add IDELAY for DQ0} ${C_DQ0_USE_IDELAY}
  set C_DQ0_IDELAY_TAPS_VALUE [ipgui::add_param $IPINST -name "C_DQ0_IDELAY_TAPS_VALUE" -parent ${DQ0}]
  set_property tooltip {DQ0 IDELAY Taps Delay Value (0 - 31)} ${C_DQ0_IDELAY_TAPS_VALUE}

  #Adding Group
  set DQ1 [ipgui::add_group $IPINST -name "DQ1" -parent ${IODELAY_configuration} -layout horizontal]
  set_property tooltip {DQ1} ${DQ1}
  set C_DQ1_USE_IDELAY [ipgui::add_param $IPINST -name "C_DQ1_USE_IDELAY" -parent ${DQ1} -show_label false]
  set_property tooltip {Add IDELAY for DQ1} ${C_DQ1_USE_IDELAY}
  set C_DQ1_IDELAY_TAPS_VALUE [ipgui::add_param $IPINST -name "C_DQ1_IDELAY_TAPS_VALUE" -parent ${DQ1}]
  set_property tooltip {DQ1 IDELAY Taps Delay Value (0 - 31)} ${C_DQ1_IDELAY_TAPS_VALUE}

  #Adding Group
  set DQ2 [ipgui::add_group $IPINST -name "DQ2" -parent ${IODELAY_configuration} -layout horizontal]
  set_property tooltip {DQ2} ${DQ2}
  set C_DQ2_USE_IDELAY [ipgui::add_param $IPINST -name "C_DQ2_USE_IDELAY" -parent ${DQ2} -show_label false]
  set_property tooltip {Add IDELAY for DQ2} ${C_DQ2_USE_IDELAY}
  set C_DQ2_IDELAY_TAPS_VALUE [ipgui::add_param $IPINST -name "C_DQ2_IDELAY_TAPS_VALUE" -parent ${DQ2}]
  set_property tooltip {DQ2 IDELAY Taps Delay Value (0 - 31)} ${C_DQ2_IDELAY_TAPS_VALUE}

  #Adding Group
  set DQ3 [ipgui::add_group $IPINST -name "DQ3" -parent ${IODELAY_configuration} -layout horizontal]
  set_property tooltip {DQ3} ${DQ3}
  set C_DQ3_USE_IDELAY [ipgui::add_param $IPINST -name "C_DQ3_USE_IDELAY" -parent ${DQ3} -show_label false]
  set_property tooltip {Add IDELAY for DQ3} ${C_DQ3_USE_IDELAY}
  set C_DQ3_IDELAY_TAPS_VALUE [ipgui::add_param $IPINST -name "C_DQ3_IDELAY_TAPS_VALUE" -parent ${DQ3}]
  set_property tooltip {DQ3 IDELAY Taps Delay Value (0 - 31)} ${C_DQ3_IDELAY_TAPS_VALUE}

  #Adding Group
  set DQ4 [ipgui::add_group $IPINST -name "DQ4" -parent ${IODELAY_configuration} -layout horizontal]
  set_property tooltip {DQ4} ${DQ4}
  set C_DQ4_USE_IDELAY [ipgui::add_param $IPINST -name "C_DQ4_USE_IDELAY" -parent ${DQ4} -show_label false]
  set_property tooltip {Add IDELAY for DQ4} ${C_DQ4_USE_IDELAY}
  set C_DQ4_IDELAY_TAPS_VALUE [ipgui::add_param $IPINST -name "C_DQ4_IDELAY_TAPS_VALUE" -parent ${DQ4}]
  set_property tooltip {DQ4 IDELAY Taps Delay Value (0 - 31)} ${C_DQ4_IDELAY_TAPS_VALUE}

  #Adding Group
  set DQ5 [ipgui::add_group $IPINST -name "DQ5" -parent ${IODELAY_configuration} -layout horizontal]
  set_property tooltip {DQ5} ${DQ5}
  set C_DQ5_USE_IDELAY [ipgui::add_param $IPINST -name "C_DQ5_USE_IDELAY" -parent ${DQ5} -show_label false]
  set_property tooltip {Add IDELAY for DQ5} ${C_DQ5_USE_IDELAY}
  set C_DQ5_IDELAY_TAPS_VALUE [ipgui::add_param $IPINST -name "C_DQ5_IDELAY_TAPS_VALUE" -parent ${DQ5}]
  set_property tooltip {DQ5 IDELAY Taps Delay Value (0 - 31)} ${C_DQ5_IDELAY_TAPS_VALUE}

  #Adding Group
  set DQ6 [ipgui::add_group $IPINST -name "DQ6" -parent ${IODELAY_configuration} -layout horizontal]
  set_property tooltip {DQ6} ${DQ6}
  set C_DQ6_USE_IDELAY [ipgui::add_param $IPINST -name "C_DQ6_USE_IDELAY" -parent ${DQ6} -show_label false]
  set_property tooltip {Add IDELAY for DQ6} ${C_DQ6_USE_IDELAY}
  set C_DQ6_IDELAY_TAPS_VALUE [ipgui::add_param $IPINST -name "C_DQ6_IDELAY_TAPS_VALUE" -parent ${DQ6}]
  set_property tooltip {DQ6 IDELAY Taps Delay Value (0 - 31)} ${C_DQ6_IDELAY_TAPS_VALUE}

  #Adding Group
  set DQ7 [ipgui::add_group $IPINST -name "DQ7" -parent ${IODELAY_configuration} -layout horizontal]
  set_property tooltip {DQ7} ${DQ7}
  set C_DQ7_USE_IDELAY [ipgui::add_param $IPINST -name "C_DQ7_USE_IDELAY" -parent ${DQ7} -show_label false]
  set_property tooltip {Add IDELAY for DQ7} ${C_DQ7_USE_IDELAY}
  set C_DQ7_IDELAY_TAPS_VALUE [ipgui::add_param $IPINST -name "C_DQ7_IDELAY_TAPS_VALUE" -parent ${DQ7}]
  set_property tooltip {DQ7 IDELAY Taps Delay Value (0 - 31)} ${C_DQ7_IDELAY_TAPS_VALUE}



  #Adding Page
  set About [ipgui::add_page $IPINST -name "About"]
  #Adding Group
  set Features [ipgui::add_group $IPINST -name "Features" -parent ${About}]
  ipgui::add_static_text $IPINST -name "Features text" -parent ${Features} -text {
OpenHBMC IP-core v2.0

> Supports HyperRAM & HyperRAM 2.0
> Supports 3.3V & 1.8V power modes
> Supports AXI4 data width of 16 / 32 / 64-bit 
> Supports all AXI4 burst types and sizes:
-- AXI4 INCR burst sizes up to 256 data beats
-- AXI4 WRAP bursts of  2, 4, 8, 16 data beats
-- AXI4 FIXED bursts are treated as INCR burst type
> Supports HyperBUS frequency up to 200MHz
> No need to make any kind of calibrations
}

  #Adding Group
  set License [ipgui::add_group $IPINST -name "License" -parent ${About}]
  ipgui::add_static_text $IPINST -name "Text1" -parent ${License} -text {
Licensed under the Apache License, Version 2.0
Copyright © 2020 - 2022, Vaagn Oganesyan, ovgn@protonmail.com
Repo: github.com/OVGN/OpenHBMC
}

  #Adding Group
  set Support [ipgui::add_group $IPINST -name "Support" -parent ${About} -display_name {Donations}]
  ipgui::add_static_text $IPINST -name "Text" -parent ${Support} -text {
Your support makes such kind of projects happen! =)

BTC: 137rRdBum6J6f4Wf21ihRsGnPjxScT4wrC
XRP: rUstbo3nmsBc8Ux5neYdQVgpLKRpShxX86
ETH: 0xD8785350A58BEB65D490a68e1c271748e70a30cE
}

set iconfile [ipgui::find_file [ipgui::get_coredir] "data/wallets.png"]
set image [ipgui::add_image -width 635 -height 225 -parent ${About} -name $iconfile $IPINST]
set_property load_image $iconfile $image

}

proc update_PARAM_VALUE.C_DQ0_IDELAY_TAPS_VALUE { PARAM_VALUE.C_DQ0_IDELAY_TAPS_VALUE PARAM_VALUE.C_DQ0_USE_IDELAY } {
	# Procedure called to update C_DQ0_IDELAY_TAPS_VALUE when any of the dependent parameters in the arguments change
	
	set C_DQ0_IDELAY_TAPS_VALUE ${PARAM_VALUE.C_DQ0_IDELAY_TAPS_VALUE}
	set C_DQ0_USE_IDELAY ${PARAM_VALUE.C_DQ0_USE_IDELAY}
	set values(C_DQ0_USE_IDELAY) [get_property value $C_DQ0_USE_IDELAY]
	if { [gen_USERPARAMETER_C_DQ0_IDELAY_TAPS_VALUE_ENABLEMENT $values(C_DQ0_USE_IDELAY)] } {
		set_property enabled true $C_DQ0_IDELAY_TAPS_VALUE
	} else {
		set_property enabled false $C_DQ0_IDELAY_TAPS_VALUE
	}
}

proc validate_PARAM_VALUE.C_DQ0_IDELAY_TAPS_VALUE { PARAM_VALUE.C_DQ0_IDELAY_TAPS_VALUE } {
	# Procedure called to validate C_DQ0_IDELAY_TAPS_VALUE
	return true
}

proc update_PARAM_VALUE.C_DQ1_IDELAY_TAPS_VALUE { PARAM_VALUE.C_DQ1_IDELAY_TAPS_VALUE PARAM_VALUE.C_DQ1_USE_IDELAY } {
	# Procedure called to update C_DQ1_IDELAY_TAPS_VALUE when any of the dependent parameters in the arguments change
	
	set C_DQ1_IDELAY_TAPS_VALUE ${PARAM_VALUE.C_DQ1_IDELAY_TAPS_VALUE}
	set C_DQ1_USE_IDELAY ${PARAM_VALUE.C_DQ1_USE_IDELAY}
	set values(C_DQ1_USE_IDELAY) [get_property value $C_DQ1_USE_IDELAY]
	if { [gen_USERPARAMETER_C_DQ1_IDELAY_TAPS_VALUE_ENABLEMENT $values(C_DQ1_USE_IDELAY)] } {
		set_property enabled true $C_DQ1_IDELAY_TAPS_VALUE
	} else {
		set_property enabled false $C_DQ1_IDELAY_TAPS_VALUE
	}
}

proc validate_PARAM_VALUE.C_DQ1_IDELAY_TAPS_VALUE { PARAM_VALUE.C_DQ1_IDELAY_TAPS_VALUE } {
	# Procedure called to validate C_DQ1_IDELAY_TAPS_VALUE
	return true
}

proc update_PARAM_VALUE.C_DQ2_IDELAY_TAPS_VALUE { PARAM_VALUE.C_DQ2_IDELAY_TAPS_VALUE PARAM_VALUE.C_DQ2_USE_IDELAY } {
	# Procedure called to update C_DQ2_IDELAY_TAPS_VALUE when any of the dependent parameters in the arguments change
	
	set C_DQ2_IDELAY_TAPS_VALUE ${PARAM_VALUE.C_DQ2_IDELAY_TAPS_VALUE}
	set C_DQ2_USE_IDELAY ${PARAM_VALUE.C_DQ2_USE_IDELAY}
	set values(C_DQ2_USE_IDELAY) [get_property value $C_DQ2_USE_IDELAY]
	if { [gen_USERPARAMETER_C_DQ2_IDELAY_TAPS_VALUE_ENABLEMENT $values(C_DQ2_USE_IDELAY)] } {
		set_property enabled true $C_DQ2_IDELAY_TAPS_VALUE
	} else {
		set_property enabled false $C_DQ2_IDELAY_TAPS_VALUE
	}
}

proc validate_PARAM_VALUE.C_DQ2_IDELAY_TAPS_VALUE { PARAM_VALUE.C_DQ2_IDELAY_TAPS_VALUE } {
	# Procedure called to validate C_DQ2_IDELAY_TAPS_VALUE
	return true
}

proc update_PARAM_VALUE.C_DQ3_IDELAY_TAPS_VALUE { PARAM_VALUE.C_DQ3_IDELAY_TAPS_VALUE PARAM_VALUE.C_DQ3_USE_IDELAY } {
	# Procedure called to update C_DQ3_IDELAY_TAPS_VALUE when any of the dependent parameters in the arguments change
	
	set C_DQ3_IDELAY_TAPS_VALUE ${PARAM_VALUE.C_DQ3_IDELAY_TAPS_VALUE}
	set C_DQ3_USE_IDELAY ${PARAM_VALUE.C_DQ3_USE_IDELAY}
	set values(C_DQ3_USE_IDELAY) [get_property value $C_DQ3_USE_IDELAY]
	if { [gen_USERPARAMETER_C_DQ3_IDELAY_TAPS_VALUE_ENABLEMENT $values(C_DQ3_USE_IDELAY)] } {
		set_property enabled true $C_DQ3_IDELAY_TAPS_VALUE
	} else {
		set_property enabled false $C_DQ3_IDELAY_TAPS_VALUE
	}
}

proc validate_PARAM_VALUE.C_DQ3_IDELAY_TAPS_VALUE { PARAM_VALUE.C_DQ3_IDELAY_TAPS_VALUE } {
	# Procedure called to validate C_DQ3_IDELAY_TAPS_VALUE
	return true
}

proc update_PARAM_VALUE.C_DQ4_IDELAY_TAPS_VALUE { PARAM_VALUE.C_DQ4_IDELAY_TAPS_VALUE PARAM_VALUE.C_DQ4_USE_IDELAY } {
	# Procedure called to update C_DQ4_IDELAY_TAPS_VALUE when any of the dependent parameters in the arguments change
	
	set C_DQ4_IDELAY_TAPS_VALUE ${PARAM_VALUE.C_DQ4_IDELAY_TAPS_VALUE}
	set C_DQ4_USE_IDELAY ${PARAM_VALUE.C_DQ4_USE_IDELAY}
	set values(C_DQ4_USE_IDELAY) [get_property value $C_DQ4_USE_IDELAY]
	if { [gen_USERPARAMETER_C_DQ4_IDELAY_TAPS_VALUE_ENABLEMENT $values(C_DQ4_USE_IDELAY)] } {
		set_property enabled true $C_DQ4_IDELAY_TAPS_VALUE
	} else {
		set_property enabled false $C_DQ4_IDELAY_TAPS_VALUE
	}
}

proc validate_PARAM_VALUE.C_DQ4_IDELAY_TAPS_VALUE { PARAM_VALUE.C_DQ4_IDELAY_TAPS_VALUE } {
	# Procedure called to validate C_DQ4_IDELAY_TAPS_VALUE
	return true
}

proc update_PARAM_VALUE.C_DQ5_IDELAY_TAPS_VALUE { PARAM_VALUE.C_DQ5_IDELAY_TAPS_VALUE PARAM_VALUE.C_DQ5_USE_IDELAY } {
	# Procedure called to update C_DQ5_IDELAY_TAPS_VALUE when any of the dependent parameters in the arguments change
	
	set C_DQ5_IDELAY_TAPS_VALUE ${PARAM_VALUE.C_DQ5_IDELAY_TAPS_VALUE}
	set C_DQ5_USE_IDELAY ${PARAM_VALUE.C_DQ5_USE_IDELAY}
	set values(C_DQ5_USE_IDELAY) [get_property value $C_DQ5_USE_IDELAY]
	if { [gen_USERPARAMETER_C_DQ5_IDELAY_TAPS_VALUE_ENABLEMENT $values(C_DQ5_USE_IDELAY)] } {
		set_property enabled true $C_DQ5_IDELAY_TAPS_VALUE
	} else {
		set_property enabled false $C_DQ5_IDELAY_TAPS_VALUE
	}
}

proc validate_PARAM_VALUE.C_DQ5_IDELAY_TAPS_VALUE { PARAM_VALUE.C_DQ5_IDELAY_TAPS_VALUE } {
	# Procedure called to validate C_DQ5_IDELAY_TAPS_VALUE
	return true
}

proc update_PARAM_VALUE.C_DQ6_IDELAY_TAPS_VALUE { PARAM_VALUE.C_DQ6_IDELAY_TAPS_VALUE PARAM_VALUE.C_DQ6_USE_IDELAY } {
	# Procedure called to update C_DQ6_IDELAY_TAPS_VALUE when any of the dependent parameters in the arguments change
	
	set C_DQ6_IDELAY_TAPS_VALUE ${PARAM_VALUE.C_DQ6_IDELAY_TAPS_VALUE}
	set C_DQ6_USE_IDELAY ${PARAM_VALUE.C_DQ6_USE_IDELAY}
	set values(C_DQ6_USE_IDELAY) [get_property value $C_DQ6_USE_IDELAY]
	if { [gen_USERPARAMETER_C_DQ6_IDELAY_TAPS_VALUE_ENABLEMENT $values(C_DQ6_USE_IDELAY)] } {
		set_property enabled true $C_DQ6_IDELAY_TAPS_VALUE
	} else {
		set_property enabled false $C_DQ6_IDELAY_TAPS_VALUE
	}
}

proc validate_PARAM_VALUE.C_DQ6_IDELAY_TAPS_VALUE { PARAM_VALUE.C_DQ6_IDELAY_TAPS_VALUE } {
	# Procedure called to validate C_DQ6_IDELAY_TAPS_VALUE
	return true
}

proc update_PARAM_VALUE.C_DQ7_IDELAY_TAPS_VALUE { PARAM_VALUE.C_DQ7_IDELAY_TAPS_VALUE PARAM_VALUE.C_DQ7_USE_IDELAY } {
	# Procedure called to update C_DQ7_IDELAY_TAPS_VALUE when any of the dependent parameters in the arguments change
	
	set C_DQ7_IDELAY_TAPS_VALUE ${PARAM_VALUE.C_DQ7_IDELAY_TAPS_VALUE}
	set C_DQ7_USE_IDELAY ${PARAM_VALUE.C_DQ7_USE_IDELAY}
	set values(C_DQ7_USE_IDELAY) [get_property value $C_DQ7_USE_IDELAY]
	if { [gen_USERPARAMETER_C_DQ7_IDELAY_TAPS_VALUE_ENABLEMENT $values(C_DQ7_USE_IDELAY)] } {
		set_property enabled true $C_DQ7_IDELAY_TAPS_VALUE
	} else {
		set_property enabled false $C_DQ7_IDELAY_TAPS_VALUE
	}
}

proc validate_PARAM_VALUE.C_DQ7_IDELAY_TAPS_VALUE { PARAM_VALUE.C_DQ7_IDELAY_TAPS_VALUE } {
	# Procedure called to validate C_DQ7_IDELAY_TAPS_VALUE
	return true
}

proc update_PARAM_VALUE.C_IDELAYCTRL_INTEGRATED { PARAM_VALUE.C_IDELAYCTRL_INTEGRATED PARAM_VALUE.C_RWDS_USE_IDELAY PARAM_VALUE.C_DQ7_USE_IDELAY PARAM_VALUE.C_DQ6_USE_IDELAY PARAM_VALUE.C_DQ5_USE_IDELAY PARAM_VALUE.C_DQ4_USE_IDELAY PARAM_VALUE.C_DQ3_USE_IDELAY PARAM_VALUE.C_DQ2_USE_IDELAY PARAM_VALUE.C_DQ1_USE_IDELAY PARAM_VALUE.C_DQ0_USE_IDELAY } {
	# Procedure called to update C_IDELAYCTRL_INTEGRATED when any of the dependent parameters in the arguments change
	
	set C_IDELAYCTRL_INTEGRATED ${PARAM_VALUE.C_IDELAYCTRL_INTEGRATED}
	set C_RWDS_USE_IDELAY ${PARAM_VALUE.C_RWDS_USE_IDELAY}
	set C_DQ7_USE_IDELAY ${PARAM_VALUE.C_DQ7_USE_IDELAY}
	set C_DQ6_USE_IDELAY ${PARAM_VALUE.C_DQ6_USE_IDELAY}
	set C_DQ5_USE_IDELAY ${PARAM_VALUE.C_DQ5_USE_IDELAY}
	set C_DQ4_USE_IDELAY ${PARAM_VALUE.C_DQ4_USE_IDELAY}
	set C_DQ3_USE_IDELAY ${PARAM_VALUE.C_DQ3_USE_IDELAY}
	set C_DQ2_USE_IDELAY ${PARAM_VALUE.C_DQ2_USE_IDELAY}
	set C_DQ1_USE_IDELAY ${PARAM_VALUE.C_DQ1_USE_IDELAY}
	set C_DQ0_USE_IDELAY ${PARAM_VALUE.C_DQ0_USE_IDELAY}
	set values(C_RWDS_USE_IDELAY) [get_property value $C_RWDS_USE_IDELAY]
	set values(C_DQ7_USE_IDELAY) [get_property value $C_DQ7_USE_IDELAY]
	set values(C_DQ6_USE_IDELAY) [get_property value $C_DQ6_USE_IDELAY]
	set values(C_DQ5_USE_IDELAY) [get_property value $C_DQ5_USE_IDELAY]
	set values(C_DQ4_USE_IDELAY) [get_property value $C_DQ4_USE_IDELAY]
	set values(C_DQ3_USE_IDELAY) [get_property value $C_DQ3_USE_IDELAY]
	set values(C_DQ2_USE_IDELAY) [get_property value $C_DQ2_USE_IDELAY]
	set values(C_DQ1_USE_IDELAY) [get_property value $C_DQ1_USE_IDELAY]
	set values(C_DQ0_USE_IDELAY) [get_property value $C_DQ0_USE_IDELAY]
	if { [gen_USERPARAMETER_C_IDELAYCTRL_INTEGRATED_ENABLEMENT $values(C_RWDS_USE_IDELAY) $values(C_DQ7_USE_IDELAY) $values(C_DQ6_USE_IDELAY) $values(C_DQ5_USE_IDELAY) $values(C_DQ4_USE_IDELAY) $values(C_DQ3_USE_IDELAY) $values(C_DQ2_USE_IDELAY) $values(C_DQ1_USE_IDELAY) $values(C_DQ0_USE_IDELAY)] } {
		set_property enabled true $C_IDELAYCTRL_INTEGRATED
	} else {
		set_property enabled false $C_IDELAYCTRL_INTEGRATED
	}
}

proc validate_PARAM_VALUE.C_IDELAYCTRL_INTEGRATED { PARAM_VALUE.C_IDELAYCTRL_INTEGRATED } {
	# Procedure called to validate C_IDELAYCTRL_INTEGRATED
	return true
}

proc update_PARAM_VALUE.C_IODELAY_GROUP_ID { PARAM_VALUE.C_IODELAY_GROUP_ID PARAM_VALUE.C_RWDS_USE_IDELAY PARAM_VALUE.C_DQ7_USE_IDELAY PARAM_VALUE.C_DQ6_USE_IDELAY PARAM_VALUE.C_DQ5_USE_IDELAY PARAM_VALUE.C_DQ4_USE_IDELAY PARAM_VALUE.C_DQ3_USE_IDELAY PARAM_VALUE.C_DQ2_USE_IDELAY PARAM_VALUE.C_DQ1_USE_IDELAY PARAM_VALUE.C_DQ0_USE_IDELAY } {
	# Procedure called to update C_IODELAY_GROUP_ID when any of the dependent parameters in the arguments change
	
	set C_IODELAY_GROUP_ID ${PARAM_VALUE.C_IODELAY_GROUP_ID}
	set C_RWDS_USE_IDELAY ${PARAM_VALUE.C_RWDS_USE_IDELAY}
	set C_DQ7_USE_IDELAY ${PARAM_VALUE.C_DQ7_USE_IDELAY}
	set C_DQ6_USE_IDELAY ${PARAM_VALUE.C_DQ6_USE_IDELAY}
	set C_DQ5_USE_IDELAY ${PARAM_VALUE.C_DQ5_USE_IDELAY}
	set C_DQ4_USE_IDELAY ${PARAM_VALUE.C_DQ4_USE_IDELAY}
	set C_DQ3_USE_IDELAY ${PARAM_VALUE.C_DQ3_USE_IDELAY}
	set C_DQ2_USE_IDELAY ${PARAM_VALUE.C_DQ2_USE_IDELAY}
	set C_DQ1_USE_IDELAY ${PARAM_VALUE.C_DQ1_USE_IDELAY}
	set C_DQ0_USE_IDELAY ${PARAM_VALUE.C_DQ0_USE_IDELAY}
	set values(C_RWDS_USE_IDELAY) [get_property value $C_RWDS_USE_IDELAY]
	set values(C_DQ7_USE_IDELAY) [get_property value $C_DQ7_USE_IDELAY]
	set values(C_DQ6_USE_IDELAY) [get_property value $C_DQ6_USE_IDELAY]
	set values(C_DQ5_USE_IDELAY) [get_property value $C_DQ5_USE_IDELAY]
	set values(C_DQ4_USE_IDELAY) [get_property value $C_DQ4_USE_IDELAY]
	set values(C_DQ3_USE_IDELAY) [get_property value $C_DQ3_USE_IDELAY]
	set values(C_DQ2_USE_IDELAY) [get_property value $C_DQ2_USE_IDELAY]
	set values(C_DQ1_USE_IDELAY) [get_property value $C_DQ1_USE_IDELAY]
	set values(C_DQ0_USE_IDELAY) [get_property value $C_DQ0_USE_IDELAY]
	if { [gen_USERPARAMETER_C_IODELAY_GROUP_ID_ENABLEMENT $values(C_RWDS_USE_IDELAY) $values(C_DQ7_USE_IDELAY) $values(C_DQ6_USE_IDELAY) $values(C_DQ5_USE_IDELAY) $values(C_DQ4_USE_IDELAY) $values(C_DQ3_USE_IDELAY) $values(C_DQ2_USE_IDELAY) $values(C_DQ1_USE_IDELAY) $values(C_DQ0_USE_IDELAY)] } {
		set_property enabled true $C_IODELAY_GROUP_ID
	} else {
		set_property enabled false $C_IODELAY_GROUP_ID
	}
}

proc validate_PARAM_VALUE.C_IODELAY_GROUP_ID { PARAM_VALUE.C_IODELAY_GROUP_ID } {
	# Procedure called to validate C_IODELAY_GROUP_ID
	return true
}

proc update_PARAM_VALUE.C_IODELAY_REFCLK_MHZ { PARAM_VALUE.C_IODELAY_REFCLK_MHZ PARAM_VALUE.C_RWDS_USE_IDELAY PARAM_VALUE.C_DQ7_USE_IDELAY PARAM_VALUE.C_DQ6_USE_IDELAY PARAM_VALUE.C_DQ5_USE_IDELAY PARAM_VALUE.C_DQ4_USE_IDELAY PARAM_VALUE.C_DQ3_USE_IDELAY PARAM_VALUE.C_DQ2_USE_IDELAY PARAM_VALUE.C_DQ1_USE_IDELAY PARAM_VALUE.C_DQ0_USE_IDELAY } {
	# Procedure called to update C_IODELAY_REFCLK_MHZ when any of the dependent parameters in the arguments change
	
	set C_IODELAY_REFCLK_MHZ ${PARAM_VALUE.C_IODELAY_REFCLK_MHZ}
	set C_RWDS_USE_IDELAY ${PARAM_VALUE.C_RWDS_USE_IDELAY}
	set C_DQ7_USE_IDELAY ${PARAM_VALUE.C_DQ7_USE_IDELAY}
	set C_DQ6_USE_IDELAY ${PARAM_VALUE.C_DQ6_USE_IDELAY}
	set C_DQ5_USE_IDELAY ${PARAM_VALUE.C_DQ5_USE_IDELAY}
	set C_DQ4_USE_IDELAY ${PARAM_VALUE.C_DQ4_USE_IDELAY}
	set C_DQ3_USE_IDELAY ${PARAM_VALUE.C_DQ3_USE_IDELAY}
	set C_DQ2_USE_IDELAY ${PARAM_VALUE.C_DQ2_USE_IDELAY}
	set C_DQ1_USE_IDELAY ${PARAM_VALUE.C_DQ1_USE_IDELAY}
	set C_DQ0_USE_IDELAY ${PARAM_VALUE.C_DQ0_USE_IDELAY}
	set values(C_RWDS_USE_IDELAY) [get_property value $C_RWDS_USE_IDELAY]
	set values(C_DQ7_USE_IDELAY) [get_property value $C_DQ7_USE_IDELAY]
	set values(C_DQ6_USE_IDELAY) [get_property value $C_DQ6_USE_IDELAY]
	set values(C_DQ5_USE_IDELAY) [get_property value $C_DQ5_USE_IDELAY]
	set values(C_DQ4_USE_IDELAY) [get_property value $C_DQ4_USE_IDELAY]
	set values(C_DQ3_USE_IDELAY) [get_property value $C_DQ3_USE_IDELAY]
	set values(C_DQ2_USE_IDELAY) [get_property value $C_DQ2_USE_IDELAY]
	set values(C_DQ1_USE_IDELAY) [get_property value $C_DQ1_USE_IDELAY]
	set values(C_DQ0_USE_IDELAY) [get_property value $C_DQ0_USE_IDELAY]
	if { [gen_USERPARAMETER_C_IODELAY_REFCLK_MHZ_ENABLEMENT $values(C_RWDS_USE_IDELAY) $values(C_DQ7_USE_IDELAY) $values(C_DQ6_USE_IDELAY) $values(C_DQ5_USE_IDELAY) $values(C_DQ4_USE_IDELAY) $values(C_DQ3_USE_IDELAY) $values(C_DQ2_USE_IDELAY) $values(C_DQ1_USE_IDELAY) $values(C_DQ0_USE_IDELAY)] } {
		set_property enabled true $C_IODELAY_REFCLK_MHZ
	} else {
		set_property enabled false $C_IODELAY_REFCLK_MHZ
	}
}

proc validate_PARAM_VALUE.C_IODELAY_REFCLK_MHZ { PARAM_VALUE.C_IODELAY_REFCLK_MHZ } {
	# Procedure called to validate C_IODELAY_REFCLK_MHZ
	return true
}

proc update_PARAM_VALUE.C_RWDS_IDELAY_TAPS_VALUE { PARAM_VALUE.C_RWDS_IDELAY_TAPS_VALUE PARAM_VALUE.C_RWDS_USE_IDELAY } {
	# Procedure called to update C_RWDS_IDELAY_TAPS_VALUE when any of the dependent parameters in the arguments change
	
	set C_RWDS_IDELAY_TAPS_VALUE ${PARAM_VALUE.C_RWDS_IDELAY_TAPS_VALUE}
	set C_RWDS_USE_IDELAY ${PARAM_VALUE.C_RWDS_USE_IDELAY}
	set values(C_RWDS_USE_IDELAY) [get_property value $C_RWDS_USE_IDELAY]
	if { [gen_USERPARAMETER_C_RWDS_IDELAY_TAPS_VALUE_ENABLEMENT $values(C_RWDS_USE_IDELAY)] } {
		set_property enabled true $C_RWDS_IDELAY_TAPS_VALUE
	} else {
		set_property enabled false $C_RWDS_IDELAY_TAPS_VALUE
	}
}

proc validate_PARAM_VALUE.C_RWDS_IDELAY_TAPS_VALUE { PARAM_VALUE.C_RWDS_IDELAY_TAPS_VALUE } {
	# Procedure called to validate C_RWDS_IDELAY_TAPS_VALUE
	return true
}

proc update_PARAM_VALUE.C_DQ0_USE_IDELAY { PARAM_VALUE.C_DQ0_USE_IDELAY } {
	# Procedure called to update C_DQ0_USE_IDELAY when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_DQ0_USE_IDELAY { PARAM_VALUE.C_DQ0_USE_IDELAY } {
	# Procedure called to validate C_DQ0_USE_IDELAY
	return true
}

proc update_PARAM_VALUE.C_DQ1_USE_IDELAY { PARAM_VALUE.C_DQ1_USE_IDELAY } {
	# Procedure called to update C_DQ1_USE_IDELAY when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_DQ1_USE_IDELAY { PARAM_VALUE.C_DQ1_USE_IDELAY } {
	# Procedure called to validate C_DQ1_USE_IDELAY
	return true
}

proc update_PARAM_VALUE.C_DQ2_USE_IDELAY { PARAM_VALUE.C_DQ2_USE_IDELAY } {
	# Procedure called to update C_DQ2_USE_IDELAY when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_DQ2_USE_IDELAY { PARAM_VALUE.C_DQ2_USE_IDELAY } {
	# Procedure called to validate C_DQ2_USE_IDELAY
	return true
}

proc update_PARAM_VALUE.C_DQ3_USE_IDELAY { PARAM_VALUE.C_DQ3_USE_IDELAY } {
	# Procedure called to update C_DQ3_USE_IDELAY when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_DQ3_USE_IDELAY { PARAM_VALUE.C_DQ3_USE_IDELAY } {
	# Procedure called to validate C_DQ3_USE_IDELAY
	return true
}

proc update_PARAM_VALUE.C_DQ4_USE_IDELAY { PARAM_VALUE.C_DQ4_USE_IDELAY } {
	# Procedure called to update C_DQ4_USE_IDELAY when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_DQ4_USE_IDELAY { PARAM_VALUE.C_DQ4_USE_IDELAY } {
	# Procedure called to validate C_DQ4_USE_IDELAY
	return true
}

proc update_PARAM_VALUE.C_DQ5_USE_IDELAY { PARAM_VALUE.C_DQ5_USE_IDELAY } {
	# Procedure called to update C_DQ5_USE_IDELAY when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_DQ5_USE_IDELAY { PARAM_VALUE.C_DQ5_USE_IDELAY } {
	# Procedure called to validate C_DQ5_USE_IDELAY
	return true
}

proc update_PARAM_VALUE.C_DQ6_USE_IDELAY { PARAM_VALUE.C_DQ6_USE_IDELAY } {
	# Procedure called to update C_DQ6_USE_IDELAY when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_DQ6_USE_IDELAY { PARAM_VALUE.C_DQ6_USE_IDELAY } {
	# Procedure called to validate C_DQ6_USE_IDELAY
	return true
}

proc update_PARAM_VALUE.C_DQ7_USE_IDELAY { PARAM_VALUE.C_DQ7_USE_IDELAY } {
	# Procedure called to update C_DQ7_USE_IDELAY when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_DQ7_USE_IDELAY { PARAM_VALUE.C_DQ7_USE_IDELAY } {
	# Procedure called to validate C_DQ7_USE_IDELAY
	return true
}

proc update_PARAM_VALUE.C_HBMC_CLOCK_HZ { PARAM_VALUE.C_HBMC_CLOCK_HZ } {
	# Procedure called to update C_HBMC_CLOCK_HZ when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_HBMC_CLOCK_HZ { PARAM_VALUE.C_HBMC_CLOCK_HZ } {
	# Procedure called to validate C_HBMC_CLOCK_HZ
	return true
}

proc update_PARAM_VALUE.C_HBMC_CS_MAX_LOW_TIME_US { PARAM_VALUE.C_HBMC_CS_MAX_LOW_TIME_US } {
	# Procedure called to update C_HBMC_CS_MAX_LOW_TIME_US when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_HBMC_CS_MAX_LOW_TIME_US { PARAM_VALUE.C_HBMC_CS_MAX_LOW_TIME_US } {
	# Procedure called to validate C_HBMC_CS_MAX_LOW_TIME_US
	return true
}

proc update_PARAM_VALUE.C_HBMC_FIXED_LATENCY { PARAM_VALUE.C_HBMC_FIXED_LATENCY } {
	# Procedure called to update C_HBMC_FIXED_LATENCY when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_HBMC_FIXED_LATENCY { PARAM_VALUE.C_HBMC_FIXED_LATENCY } {
	# Procedure called to validate C_HBMC_FIXED_LATENCY
	return true
}

proc update_PARAM_VALUE.C_HBMC_FPGA_DRIVE_STRENGTH { PARAM_VALUE.C_HBMC_FPGA_DRIVE_STRENGTH } {
	# Procedure called to update C_HBMC_FPGA_DRIVE_STRENGTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_HBMC_FPGA_DRIVE_STRENGTH { PARAM_VALUE.C_HBMC_FPGA_DRIVE_STRENGTH } {
	# Procedure called to validate C_HBMC_FPGA_DRIVE_STRENGTH
	return true
}

proc update_PARAM_VALUE.C_HBMC_FPGA_SLEW_RATE { PARAM_VALUE.C_HBMC_FPGA_SLEW_RATE } {
	# Procedure called to update C_HBMC_FPGA_SLEW_RATE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_HBMC_FPGA_SLEW_RATE { PARAM_VALUE.C_HBMC_FPGA_SLEW_RATE } {
	# Procedure called to validate C_HBMC_FPGA_SLEW_RATE
	return true
}

proc update_PARAM_VALUE.C_HBMC_MEM_DRIVE_STRENGTH { PARAM_VALUE.C_HBMC_MEM_DRIVE_STRENGTH } {
	# Procedure called to update C_HBMC_MEM_DRIVE_STRENGTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_HBMC_MEM_DRIVE_STRENGTH { PARAM_VALUE.C_HBMC_MEM_DRIVE_STRENGTH } {
	# Procedure called to validate C_HBMC_MEM_DRIVE_STRENGTH
	return true
}

proc update_PARAM_VALUE.C_ISERDES_CLOCKING_MODE { PARAM_VALUE.C_ISERDES_CLOCKING_MODE } {
	# Procedure called to update C_ISERDES_CLOCKING_MODE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_ISERDES_CLOCKING_MODE { PARAM_VALUE.C_ISERDES_CLOCKING_MODE } {
	# Procedure called to validate C_ISERDES_CLOCKING_MODE
	return true
}

proc update_PARAM_VALUE.C_RWDS_USE_IDELAY { PARAM_VALUE.C_RWDS_USE_IDELAY } {
	# Procedure called to update C_RWDS_USE_IDELAY when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_RWDS_USE_IDELAY { PARAM_VALUE.C_RWDS_USE_IDELAY } {
	# Procedure called to validate C_RWDS_USE_IDELAY
	return true
}

proc update_PARAM_VALUE.C_S_AXI_ARUSER_WIDTH { PARAM_VALUE.C_S_AXI_ARUSER_WIDTH } {
	# Procedure called to update C_S_AXI_ARUSER_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_ARUSER_WIDTH { PARAM_VALUE.C_S_AXI_ARUSER_WIDTH } {
	# Procedure called to validate C_S_AXI_ARUSER_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S_AXI_AWUSER_WIDTH { PARAM_VALUE.C_S_AXI_AWUSER_WIDTH } {
	# Procedure called to update C_S_AXI_AWUSER_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_AWUSER_WIDTH { PARAM_VALUE.C_S_AXI_AWUSER_WIDTH } {
	# Procedure called to validate C_S_AXI_AWUSER_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S_AXI_BUSER_WIDTH { PARAM_VALUE.C_S_AXI_BUSER_WIDTH } {
	# Procedure called to update C_S_AXI_BUSER_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_BUSER_WIDTH { PARAM_VALUE.C_S_AXI_BUSER_WIDTH } {
	# Procedure called to validate C_S_AXI_BUSER_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S_AXI_RUSER_WIDTH { PARAM_VALUE.C_S_AXI_RUSER_WIDTH } {
	# Procedure called to update C_S_AXI_RUSER_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_RUSER_WIDTH { PARAM_VALUE.C_S_AXI_RUSER_WIDTH } {
	# Procedure called to validate C_S_AXI_RUSER_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S_AXI_WUSER_WIDTH { PARAM_VALUE.C_S_AXI_WUSER_WIDTH } {
	# Procedure called to update C_S_AXI_WUSER_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_WUSER_WIDTH { PARAM_VALUE.C_S_AXI_WUSER_WIDTH } {
	# Procedure called to validate C_S_AXI_WUSER_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S_AXI_ID_WIDTH { PARAM_VALUE.C_S_AXI_ID_WIDTH } {
	# Procedure called to update C_S_AXI_ID_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_ID_WIDTH { PARAM_VALUE.C_S_AXI_ID_WIDTH } {
	# Procedure called to validate C_S_AXI_ID_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S_AXI_DATA_WIDTH { PARAM_VALUE.C_S_AXI_DATA_WIDTH } {
	# Procedure called to update C_S_AXI_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_DATA_WIDTH { PARAM_VALUE.C_S_AXI_DATA_WIDTH } {
	# Procedure called to validate C_S_AXI_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S_AXI_ADDR_WIDTH { PARAM_VALUE.C_S_AXI_ADDR_WIDTH } {
	# Procedure called to update C_S_AXI_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_ADDR_WIDTH { PARAM_VALUE.C_S_AXI_ADDR_WIDTH } {
	# Procedure called to validate C_S_AXI_ADDR_WIDTH
	return true
}


proc update_MODELPARAM_VALUE.C_S_AXI_ID_WIDTH { MODELPARAM_VALUE.C_S_AXI_ID_WIDTH PARAM_VALUE.C_S_AXI_ID_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_ID_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_ID_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S_AXI_DATA_WIDTH { MODELPARAM_VALUE.C_S_AXI_DATA_WIDTH PARAM_VALUE.C_S_AXI_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_DATA_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S_AXI_ADDR_WIDTH { MODELPARAM_VALUE.C_S_AXI_ADDR_WIDTH PARAM_VALUE.C_S_AXI_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.C_HBMC_CLOCK_HZ { MODELPARAM_VALUE.C_HBMC_CLOCK_HZ PARAM_VALUE.C_HBMC_CLOCK_HZ } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_HBMC_CLOCK_HZ}] ${MODELPARAM_VALUE.C_HBMC_CLOCK_HZ}
}

proc update_MODELPARAM_VALUE.C_HBMC_CS_MAX_LOW_TIME_US { MODELPARAM_VALUE.C_HBMC_CS_MAX_LOW_TIME_US PARAM_VALUE.C_HBMC_CS_MAX_LOW_TIME_US } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_HBMC_CS_MAX_LOW_TIME_US}] ${MODELPARAM_VALUE.C_HBMC_CS_MAX_LOW_TIME_US}
}

proc update_MODELPARAM_VALUE.C_HBMC_FIXED_LATENCY { MODELPARAM_VALUE.C_HBMC_FIXED_LATENCY PARAM_VALUE.C_HBMC_FIXED_LATENCY } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_HBMC_FIXED_LATENCY}] ${MODELPARAM_VALUE.C_HBMC_FIXED_LATENCY}
}

proc update_MODELPARAM_VALUE.C_IDELAYCTRL_INTEGRATED { MODELPARAM_VALUE.C_IDELAYCTRL_INTEGRATED PARAM_VALUE.C_IDELAYCTRL_INTEGRATED } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_IDELAYCTRL_INTEGRATED}] ${MODELPARAM_VALUE.C_IDELAYCTRL_INTEGRATED}
}

proc update_MODELPARAM_VALUE.C_IODELAY_GROUP_ID { MODELPARAM_VALUE.C_IODELAY_GROUP_ID PARAM_VALUE.C_IODELAY_GROUP_ID } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_IODELAY_GROUP_ID}] ${MODELPARAM_VALUE.C_IODELAY_GROUP_ID}
}

proc update_MODELPARAM_VALUE.C_IODELAY_REFCLK_MHZ { MODELPARAM_VALUE.C_IODELAY_REFCLK_MHZ PARAM_VALUE.C_IODELAY_REFCLK_MHZ } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_IODELAY_REFCLK_MHZ}] ${MODELPARAM_VALUE.C_IODELAY_REFCLK_MHZ}
}

proc update_MODELPARAM_VALUE.C_S_AXI_AWUSER_WIDTH { MODELPARAM_VALUE.C_S_AXI_AWUSER_WIDTH PARAM_VALUE.C_S_AXI_AWUSER_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_AWUSER_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_AWUSER_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S_AXI_ARUSER_WIDTH { MODELPARAM_VALUE.C_S_AXI_ARUSER_WIDTH PARAM_VALUE.C_S_AXI_ARUSER_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_ARUSER_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_ARUSER_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S_AXI_WUSER_WIDTH { MODELPARAM_VALUE.C_S_AXI_WUSER_WIDTH PARAM_VALUE.C_S_AXI_WUSER_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_WUSER_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_WUSER_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S_AXI_RUSER_WIDTH { MODELPARAM_VALUE.C_S_AXI_RUSER_WIDTH PARAM_VALUE.C_S_AXI_RUSER_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_RUSER_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_RUSER_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S_AXI_BUSER_WIDTH { MODELPARAM_VALUE.C_S_AXI_BUSER_WIDTH PARAM_VALUE.C_S_AXI_BUSER_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_BUSER_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_BUSER_WIDTH}
}

proc update_MODELPARAM_VALUE.C_HBMC_FPGA_DRIVE_STRENGTH { MODELPARAM_VALUE.C_HBMC_FPGA_DRIVE_STRENGTH PARAM_VALUE.C_HBMC_FPGA_DRIVE_STRENGTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_HBMC_FPGA_DRIVE_STRENGTH}] ${MODELPARAM_VALUE.C_HBMC_FPGA_DRIVE_STRENGTH}
}

proc update_MODELPARAM_VALUE.C_HBMC_MEM_DRIVE_STRENGTH { MODELPARAM_VALUE.C_HBMC_MEM_DRIVE_STRENGTH PARAM_VALUE.C_HBMC_MEM_DRIVE_STRENGTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_HBMC_MEM_DRIVE_STRENGTH}] ${MODELPARAM_VALUE.C_HBMC_MEM_DRIVE_STRENGTH}
}

proc update_MODELPARAM_VALUE.C_HBMC_FPGA_SLEW_RATE { MODELPARAM_VALUE.C_HBMC_FPGA_SLEW_RATE PARAM_VALUE.C_HBMC_FPGA_SLEW_RATE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_HBMC_FPGA_SLEW_RATE}] ${MODELPARAM_VALUE.C_HBMC_FPGA_SLEW_RATE}
}

proc update_MODELPARAM_VALUE.C_RWDS_USE_IDELAY { MODELPARAM_VALUE.C_RWDS_USE_IDELAY PARAM_VALUE.C_RWDS_USE_IDELAY } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_RWDS_USE_IDELAY}] ${MODELPARAM_VALUE.C_RWDS_USE_IDELAY}
}

proc update_MODELPARAM_VALUE.C_DQ7_USE_IDELAY { MODELPARAM_VALUE.C_DQ7_USE_IDELAY PARAM_VALUE.C_DQ7_USE_IDELAY } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DQ7_USE_IDELAY}] ${MODELPARAM_VALUE.C_DQ7_USE_IDELAY}
}

proc update_MODELPARAM_VALUE.C_DQ6_USE_IDELAY { MODELPARAM_VALUE.C_DQ6_USE_IDELAY PARAM_VALUE.C_DQ6_USE_IDELAY } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DQ6_USE_IDELAY}] ${MODELPARAM_VALUE.C_DQ6_USE_IDELAY}
}

proc update_MODELPARAM_VALUE.C_DQ5_USE_IDELAY { MODELPARAM_VALUE.C_DQ5_USE_IDELAY PARAM_VALUE.C_DQ5_USE_IDELAY } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DQ5_USE_IDELAY}] ${MODELPARAM_VALUE.C_DQ5_USE_IDELAY}
}

proc update_MODELPARAM_VALUE.C_DQ4_USE_IDELAY { MODELPARAM_VALUE.C_DQ4_USE_IDELAY PARAM_VALUE.C_DQ4_USE_IDELAY } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DQ4_USE_IDELAY}] ${MODELPARAM_VALUE.C_DQ4_USE_IDELAY}
}

proc update_MODELPARAM_VALUE.C_DQ3_USE_IDELAY { MODELPARAM_VALUE.C_DQ3_USE_IDELAY PARAM_VALUE.C_DQ3_USE_IDELAY } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DQ3_USE_IDELAY}] ${MODELPARAM_VALUE.C_DQ3_USE_IDELAY}
}

proc update_MODELPARAM_VALUE.C_DQ2_USE_IDELAY { MODELPARAM_VALUE.C_DQ2_USE_IDELAY PARAM_VALUE.C_DQ2_USE_IDELAY } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DQ2_USE_IDELAY}] ${MODELPARAM_VALUE.C_DQ2_USE_IDELAY}
}

proc update_MODELPARAM_VALUE.C_DQ1_USE_IDELAY { MODELPARAM_VALUE.C_DQ1_USE_IDELAY PARAM_VALUE.C_DQ1_USE_IDELAY } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DQ1_USE_IDELAY}] ${MODELPARAM_VALUE.C_DQ1_USE_IDELAY}
}

proc update_MODELPARAM_VALUE.C_DQ0_USE_IDELAY { MODELPARAM_VALUE.C_DQ0_USE_IDELAY PARAM_VALUE.C_DQ0_USE_IDELAY } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DQ0_USE_IDELAY}] ${MODELPARAM_VALUE.C_DQ0_USE_IDELAY}
}

proc update_MODELPARAM_VALUE.C_RWDS_IDELAY_TAPS_VALUE { MODELPARAM_VALUE.C_RWDS_IDELAY_TAPS_VALUE PARAM_VALUE.C_RWDS_IDELAY_TAPS_VALUE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_RWDS_IDELAY_TAPS_VALUE}] ${MODELPARAM_VALUE.C_RWDS_IDELAY_TAPS_VALUE}
}

proc update_MODELPARAM_VALUE.C_DQ7_IDELAY_TAPS_VALUE { MODELPARAM_VALUE.C_DQ7_IDELAY_TAPS_VALUE PARAM_VALUE.C_DQ7_IDELAY_TAPS_VALUE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DQ7_IDELAY_TAPS_VALUE}] ${MODELPARAM_VALUE.C_DQ7_IDELAY_TAPS_VALUE}
}

proc update_MODELPARAM_VALUE.C_DQ6_IDELAY_TAPS_VALUE { MODELPARAM_VALUE.C_DQ6_IDELAY_TAPS_VALUE PARAM_VALUE.C_DQ6_IDELAY_TAPS_VALUE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DQ6_IDELAY_TAPS_VALUE}] ${MODELPARAM_VALUE.C_DQ6_IDELAY_TAPS_VALUE}
}

proc update_MODELPARAM_VALUE.C_DQ5_IDELAY_TAPS_VALUE { MODELPARAM_VALUE.C_DQ5_IDELAY_TAPS_VALUE PARAM_VALUE.C_DQ5_IDELAY_TAPS_VALUE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DQ5_IDELAY_TAPS_VALUE}] ${MODELPARAM_VALUE.C_DQ5_IDELAY_TAPS_VALUE}
}

proc update_MODELPARAM_VALUE.C_DQ4_IDELAY_TAPS_VALUE { MODELPARAM_VALUE.C_DQ4_IDELAY_TAPS_VALUE PARAM_VALUE.C_DQ4_IDELAY_TAPS_VALUE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DQ4_IDELAY_TAPS_VALUE}] ${MODELPARAM_VALUE.C_DQ4_IDELAY_TAPS_VALUE}
}

proc update_MODELPARAM_VALUE.C_DQ3_IDELAY_TAPS_VALUE { MODELPARAM_VALUE.C_DQ3_IDELAY_TAPS_VALUE PARAM_VALUE.C_DQ3_IDELAY_TAPS_VALUE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DQ3_IDELAY_TAPS_VALUE}] ${MODELPARAM_VALUE.C_DQ3_IDELAY_TAPS_VALUE}
}

proc update_MODELPARAM_VALUE.C_DQ2_IDELAY_TAPS_VALUE { MODELPARAM_VALUE.C_DQ2_IDELAY_TAPS_VALUE PARAM_VALUE.C_DQ2_IDELAY_TAPS_VALUE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DQ2_IDELAY_TAPS_VALUE}] ${MODELPARAM_VALUE.C_DQ2_IDELAY_TAPS_VALUE}
}

proc update_MODELPARAM_VALUE.C_DQ1_IDELAY_TAPS_VALUE { MODELPARAM_VALUE.C_DQ1_IDELAY_TAPS_VALUE PARAM_VALUE.C_DQ1_IDELAY_TAPS_VALUE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DQ1_IDELAY_TAPS_VALUE}] ${MODELPARAM_VALUE.C_DQ1_IDELAY_TAPS_VALUE}
}

proc update_MODELPARAM_VALUE.C_DQ0_IDELAY_TAPS_VALUE { MODELPARAM_VALUE.C_DQ0_IDELAY_TAPS_VALUE PARAM_VALUE.C_DQ0_IDELAY_TAPS_VALUE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DQ0_IDELAY_TAPS_VALUE}] ${MODELPARAM_VALUE.C_DQ0_IDELAY_TAPS_VALUE}
}

proc update_MODELPARAM_VALUE.C_ISERDES_CLOCKING_MODE { MODELPARAM_VALUE.C_ISERDES_CLOCKING_MODE PARAM_VALUE.C_ISERDES_CLOCKING_MODE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_ISERDES_CLOCKING_MODE}] ${MODELPARAM_VALUE.C_ISERDES_CLOCKING_MODE}
}

