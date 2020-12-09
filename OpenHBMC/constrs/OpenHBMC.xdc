# Edge-Aligned Double Data Rate Source Synchronous Inputs
# (Using a direct FF connection)
#
# For an edge-aligned Source Synchronous interface, the clock
# transition occurs at the same time as the data transitions.
# In this template, the clock is aligned with the beginning of the
# data. The constraints below rely on the default timing
# analysis (setup = 1/2 cycle, hold = 0 cycle).
#
# input            _________________________________
# clock  _________|                                 |___________________________
#                 |                                 |                 
#         skew_bre|skew_are                 skew_bfe|skew_afe
#         <------>|<------>                 <------>|<------>
#        _        |        _________________        |        _________________
# data   _XXXXXXXXXXXXXXXXX____Rise_Data____XXXXXXXXXXXXXXXXX____Fall_Data____XX
#

create_clock -name hb_rwds_strb -period 6.25 [get_ports hb_rwds]

set input_clock         hb_rwds_strb;      # Name of input clock
set input_clock_period  6.25;              # Period of input clock (full-period)
set skew_bre            0.450;             # Data invalid before the rising clock edge
set skew_are            0.450;             # Data invalid after the rising clock edge
set skew_bfe            0.450;             # Data invalid before the falling clock edge
set skew_afe            0.450;             # Data invalid after the falling clock edge
set input_ports         hb_dq[*];          # List of input ports

# Input Delay Constraint
set_input_delay -clock $input_clock -max [expr $input_clock_period/2 + $skew_afe] [get_ports $input_ports];
set_input_delay -clock $input_clock -min [expr $input_clock_period/2 - $skew_bfe] [get_ports $input_ports];
set_input_delay -clock $input_clock -max [expr $input_clock_period/2 + $skew_are] [get_ports $input_ports] -clock_fall -add_delay;
set_input_delay -clock $input_clock -min [expr $input_clock_period/2 - $skew_bre] [get_ports $input_ports] -clock_fall -add_delay;

# TODO: output delay