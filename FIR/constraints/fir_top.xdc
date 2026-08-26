# Clock signal
set_property -dict { PACKAGE_PIN W5   IOSTANDARD LVCMOS33 } [get_ports clk]
create_clock -add -name sys_clk_pin -period 11 -waveform {0 5.5} [get_ports clk]

#tx
set_property PACKAGE_PIN A18 [get_ports tx]						
	set_property IOSTANDARD LVCMOS33 [get_ports tx]

# rx
set_property PACKAGE_PIN B18 [get_ports rx]						
	set_property IOSTANDARD LVCMOS33 [get_ports rx]


# LED0
set_property PACKAGE_PIN U16 [get_ports led[0]]
set_property IOSTANDARD LVCMOS33 [get_ports led[0]]

# LED1
set_property PACKAGE_PIN E19 [get_ports led[1]]
set_property IOSTANDARD LVCMOS33 [get_ports led[1]]

# LED2
set_property PACKAGE_PIN U19 [get_ports led[2]]
set_property IOSTANDARD LVCMOS33 [get_ports led[2]]
