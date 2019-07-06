#**************************************************************
# This .sdc file is created by Terasic Tool.
# Users are recommended to modify this file to match users logic.
#**************************************************************

#**************************************************************
# Create Clock
#**************************************************************
create_clock -period "10.0 MHz" [get_ports ADC_CLK_10]
create_clock -period "50.0 MHz" [get_ports MAX10_CLK1_50]
create_clock -period "50.0 MHz" [get_ports MAX10_CLK2_50]
create_clock -period "25.0 MHz" [get_ports NET_RX_CLK]
create_clock -period "25.0 MHz" [get_ports NET_TX_CLK]
create_clock -period "60.0 MHz" [get_ports USB_CLKIN]

#**************************************************************
# Create Generated Clock
#**************************************************************
derive_pll_clocks



#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************
derive_clock_uncertainty



#**************************************************************
# Set Input Delay
#**************************************************************

# input delay will be clock to output of the external device plus plus clk trace delay plus data trace delay
# 5.4 ns for the sdram


#**************************************************************
# Set Output Delay
#**************************************************************

# this constrains a source synchronous interface, in which data and clock lines are both send externally

# max output delay specifies the maximum amount of time available to output a signal and still meet the setup time of the external device.
# Think about maximum output delay as "how long must the launched data signal be stable (at the fpga's data output pin) before the launch
# clock edge (at the fpga's clock output pin)". initially set the output delay as the setup time of the external device. add max pcb trace
# delay minus min pcb trace delay in later

# the traces are about 2.5 inches long total and it takes about 170 ps/in for the signals to travel so the total trace time should be about 425 ps
# the minimum setup time on the sdram is 1.5 ns, and the mimimum hold time is 0.8 ns.
# the clock period will be 10 ns for 100 mhz, 7.5 ns for 133 mhz, 6 ns for 166 mhz, or 5 ns for 200 mhz
# I think the max delay would be the setup time, and the min delay would be the hold time.
# so for say 133 mhz operation we have the equations
# 7.5 ns - (1.5 ns + 0.425 ns) = 5.575 ns max output delay for setup time
#               0.8 ns - 0.425 = 0.375 ns min output delay for hold time


# source synchronous
set sdramSetup   1.5
set sdramHold    0.8
set dataTraceMax 0.5
set dataTraceMin 0.425
set clkTrackMax  0.5
set clkTraceMin  0.425
set outMaxDelay [expr $dataTraceMax + $sdramSetup - $clkTraceMin]
set outMinDelay [expr $dataTraceMin - $sdramHold  - $clkTrackMax]

set launchClk "DECA_soc|pll|altpll_component|auto_generated|pll1|clk[0]"
set latchClk  "DECA_soc|pll|altpll_component|auto_generated|pll1|clk[1]"

# these are system-centric output delay constraints, center aligned or small phase shift.
set_output_delay -min $outMinDelay -clock [get_clocks $latchClk] [get_ports {externalSdramAddress[*] externalSdramBa[*] externalSdramCas externalSdramCke externalSdramCs externalSdramDq[*] externalSdramDqm[*] externalSdramRas externalSdramWe}]
set_output_delay -max $outMaxDelay -clock [get_clocks $latchClk] [get_ports {externalSdramAddress[*] externalSdramBa[*] externalSdramCas externalSdramCke externalSdramCs externalSdramDq[*] externalSdramDqm[*] externalSdramRas externalSdramWe}]

#set_output_delay -clock [get_clocks $launchClk] -max  2 [get_ports {externalSdramAddress[*] externalSdramBa[*] externalSdramCas externalSdramCke externalSdramCs externalSdramDq[*] externalSdramDqm[*] externalSdramRas externalSdramWe}]
#set_output_delay -clock [get_clocks $launchClk] -min -1 [get_ports {externalSdramAddress[*] externalSdramBa[*] externalSdramCas externalSdramCke externalSdramCs externalSdramDq[*] externalSdramDqm[*] externalSdramRas externalSdramWe}]

#set_multicycle_path -setup -end 0 -rise_from [get_clocks $latchClk] -rise_to [get_clocks $launchClk]
#set_multicycle_path -setup -end 0 -fall_from [get_clocks $latchClk] -fall_to [get_clocks $launchClk]

set_false_path -setup -rise_from [get_clocks $latchClk] -fall_to [get_clocks $launchClk]
set_false_path -setup -fall_from [get_clocks $latchClk] -rise_to [get_clocks $launchClk]
set_false_path -hold  -rise_from [get_clocks $latchClk] -rise_to [get_clocks $launchClk]
set_false_path -hold  -fall_from [get_clocks $latchClk] -fall_to [get_clocks $launchClk]

# need to constrain
# externalSdramClk
# externalSdramDq[*] input delay




# from the constraining source synchronous interfaces video

#Source latencies are based on clock network delays from the master clock (not necessarily the master pin). You can use the set_clock_latency -source command to override the source latency.

# the launch clock (used internally in the fpga)
#create_generated_clock -name data_clock -source [get_pins PLL|inclk[0]] [get_pins PLL|clk[0]]

# the internal latch clock before it is driven through the output pins of the fpga
#create_generated_clock -name clk_out_int -phase 270 -source [get_pins PLL|inclk[0]] [get_pins PLL|clk[1]]

# the latch clock after it is driven outside the fpga
#create_generated_clock -name clk_out -source [get_pins PLL|clk[1]] [get_pins clk_out]

# set deviceSetup  1.5
# set deviceHold   0.8
# set dataTraceMax 0.425
# set dataTraceMin 0.425
# set clkTrackMax  0.425
# set clkTraceMin  0.425
# set outMaxDelay [expr dataTraceMax + deviceSetup - clkTraceMin]
# set outMinDelay [expr dataTraceMin - deviceHold  - clkTrackMax]

# set_output_delay -max outMaxDelay -clock [get_clocks clk_out] [get_ports data_out]
# set_output_delay -min outMinDelay -clock [get_clocks clk_out] [get_ports data_out]


#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************



#**************************************************************
# Set Load
#**************************************************************



