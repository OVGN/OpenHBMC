# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0" -display_name {IP-Core Configurations}]
  set_property tooltip {IP-Core Configurations} ${Page_0}
  #Adding Group
  set Memory_options [ipgui::add_group $IPINST -name "Memory options" -parent ${Page_0} -display_name {Memory Options}]
  set C_HBMC_CLOCK_HZ [ipgui::add_param $IPINST -name "C_HBMC_CLOCK_HZ" -parent ${Memory_options}]
  set_property tooltip {Value in Hz. Defines frequencies of clk_hbmc_0 (0 degree) and clk_hbmc_270 (270 degree). Minimum clock frequency is limited by 100MHz.} ${C_HBMC_CLOCK_HZ}
  set C_HBMC_CS_MAX_LOW_TIME_US [ipgui::add_param $IPINST -name "C_HBMC_CS_MAX_LOW_TIME_US" -parent ${Memory_options} -widget comboBox]
  set_property tooltip {CS maximum low time} ${C_HBMC_CS_MAX_LOW_TIME_US}
  set C_HBMC_FIXED_LATENCY [ipgui::add_param $IPINST -name "C_HBMC_FIXED_LATENCY" -parent ${Memory_options}]
  set_property tooltip {Makes all read and write transactions require the same initial latency. OpenHBMC supports variable latency, that is why it is recommended to leave this parameter unchecked.} ${C_HBMC_FIXED_LATENCY}

  #Adding Group
  set IO_configurations [ipgui::add_group $IPINST -name "IO configurations" -parent ${Page_0} -display_name {IO Signal Integrity}]
  set C_HBMC_FPGA_DRIVE_STRENGTH [ipgui::add_param $IPINST -name "C_HBMC_FPGA_DRIVE_STRENGTH" -parent ${IO_configurations} -widget comboBox]
  set_property tooltip {Drive strength sets the desired buffers output current to meet the load requirements and depends on various factors, especially the PCB design. Incorrect value may cause non-reliable operation at high frequencies.} ${C_HBMC_FPGA_DRIVE_STRENGTH}
  set C_HBMC_FPGA_SLEW_RATE [ipgui::add_param $IPINST -name "C_HBMC_FPGA_SLEW_RATE" -parent ${IO_configurations} -widget comboBox]
  set_property tooltip {Slew rate impacts on rise and fall times of the buffers output and depends on various factors, especially PCB design. Incorrect value may cause non-reliable operation at high frequencies.} ${C_HBMC_FPGA_SLEW_RATE}
  set C_HBMC_MEM_DRIVE_STRENGTH [ipgui::add_param $IPINST -name "C_HBMC_MEM_DRIVE_STRENGTH" -parent ${IO_configurations} -widget comboBox]
  set_property tooltip {This parameter allows to adjust the DQ[7:0] and RWDS signal output impedance at the memory side to minimize high speed signal behaviors like overshoots, undershoots and ringing. Incorrect value may cause non-reliable operation at high frequencies.} ${C_HBMC_MEM_DRIVE_STRENGTH}

  #Adding Group
  set IODELAY_configuration [ipgui::add_group $IPINST -name "IODELAY configuration" -parent ${Page_0} -display_name {IODELAY Configuration}]
  set C_IODELAY_REFCLK_MHZ [ipgui::add_param $IPINST -name "C_IODELAY_REFCLK_MHZ" -parent ${IODELAY_configuration}]
  set_property tooltip {Value in MHz. Valid ranges: 190.0 to 210.0 / 290.0 to 310.0} ${C_IODELAY_REFCLK_MHZ}
  set C_IODELAY_GROUP_ID [ipgui::add_param $IPINST -name "C_IODELAY_GROUP_ID" -parent ${IODELAY_configuration}]
  set_property tooltip {Specifies group name for associated IDELAYs/ODELAYs and IDELAYCTRL.} ${C_IODELAY_GROUP_ID}
  set C_IDELAYCTRL_INTEGRATED [ipgui::add_param $IPINST -name "C_IDELAYCTRL_INTEGRATED" -parent ${IODELAY_configuration}]
  set_property tooltip {Integrates IDELAYCTRL module that continuosly calibrates individual delay taps (IDELAYs/ODELAYs) in its bank to reduce the effect of PVT (process-voltage-temperature) variations. This option is recommended to be enable by default, except cases when IDELAYCTRL is already used within current IO bank.} ${C_IDELAYCTRL_INTEGRATED}


  #Adding Page
  set About [ipgui::add_page $IPINST -name "About"]
  #Adding Group
  set Features [ipgui::add_group $IPINST -name "Features" -parent ${About}]
  ipgui::add_static_text $IPINST -name "Features text" -parent ${Features} -text {
OpenHBMC IP-core v1.0

> Supports HyperRAM & HyperRAM 2.0
> Supports 3.3V & 1.8V power modes
> Supports AXI4 data width of 16 / 32 / 64-bit 
> Supports all AXI4 burst types and sizes:
> > AXI4 INCR burst sizes up to 256 data beats
> > AXI4 WRAP bursts of  2, 4, 8, 16 data beats
> > AXI4 FIXED bursts are treated as INCR burst type
> No AXI4 read or write reordering
}

  #Adding Group
  set License [ipgui::add_group $IPINST -name "License" -parent ${About}]
  ipgui::add_static_text $IPINST -name "Text1" -parent ${License} -text {
Licensed under the Apache License, Version 2.0
Copyright © 2020, Vaagn Oganesyan, ovgn@protonmail.com
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

proc update_PARAM_VALUE.BTC { PARAM_VALUE.BTC } {
	# Procedure called to update BTC when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BTC { PARAM_VALUE.BTC } {
	# Procedure called to validate BTC
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

proc update_PARAM_VALUE.C_IDELAYCTRL_INTEGRATED { PARAM_VALUE.C_IDELAYCTRL_INTEGRATED } {
	# Procedure called to update C_IDELAYCTRL_INTEGRATED when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_IDELAYCTRL_INTEGRATED { PARAM_VALUE.C_IDELAYCTRL_INTEGRATED } {
	# Procedure called to validate C_IDELAYCTRL_INTEGRATED
	return true
}

proc update_PARAM_VALUE.C_IODELAY_GROUP_ID { PARAM_VALUE.C_IODELAY_GROUP_ID } {
	# Procedure called to update C_IODELAY_GROUP_ID when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_IODELAY_GROUP_ID { PARAM_VALUE.C_IODELAY_GROUP_ID } {
	# Procedure called to validate C_IODELAY_GROUP_ID
	return true
}

proc update_PARAM_VALUE.C_IODELAY_REFCLK_MHZ { PARAM_VALUE.C_IODELAY_REFCLK_MHZ } {
	# Procedure called to update C_IODELAY_REFCLK_MHZ when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_IODELAY_REFCLK_MHZ { PARAM_VALUE.C_IODELAY_REFCLK_MHZ } {
	# Procedure called to validate C_IODELAY_REFCLK_MHZ
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

proc update_PARAM_VALUE.C_S_AXI_BASEADDR { PARAM_VALUE.C_S_AXI_BASEADDR } {
	# Procedure called to update C_S_AXI_BASEADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_BASEADDR { PARAM_VALUE.C_S_AXI_BASEADDR } {
	# Procedure called to validate C_S_AXI_BASEADDR
	return true
}

proc update_PARAM_VALUE.C_S_AXI_HIGHADDR { PARAM_VALUE.C_S_AXI_HIGHADDR } {
	# Procedure called to update C_S_AXI_HIGHADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_HIGHADDR { PARAM_VALUE.C_S_AXI_HIGHADDR } {
	# Procedure called to validate C_S_AXI_HIGHADDR
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

proc update_MODELPARAM_VALUE.C_S_AXI_BASEADDR { MODELPARAM_VALUE.C_S_AXI_BASEADDR PARAM_VALUE.C_S_AXI_BASEADDR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_BASEADDR}] ${MODELPARAM_VALUE.C_S_AXI_BASEADDR}
}

proc update_MODELPARAM_VALUE.C_S_AXI_HIGHADDR { MODELPARAM_VALUE.C_S_AXI_HIGHADDR PARAM_VALUE.C_S_AXI_HIGHADDR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_HIGHADDR}] ${MODELPARAM_VALUE.C_S_AXI_HIGHADDR}
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

