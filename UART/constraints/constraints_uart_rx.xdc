# Clock signal
set_property -dict { PACKAGE_PIN W5   IOSTANDARD LVCMOS33 } [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

# rx
set_property PACKAGE_PIN B18 [get_ports rx]						
	set_property IOSTANDARD LVCMOS33 [get_ports rx]

# LED0
set_property PACKAGE_PIN U16 [get_ports data[0]]
set_property IOSTANDARD LVCMOS33 [get_ports data[0]]

# LED1
set_property PACKAGE_PIN E19 [get_ports data[1]]
set_property IOSTANDARD LVCMOS33 [get_ports data[1]]

# LED2
set_property PACKAGE_PIN U19 [get_ports data[2]]
set_property IOSTANDARD LVCMOS33 [get_ports data[2]]

# LED3
set_property PACKAGE_PIN V19 [get_ports data[3]]
set_property IOSTANDARD LVCMOS33 [get_ports data[3]]

# LED4
set_property PACKAGE_PIN W18 [get_ports data[4]]
set_property IOSTANDARD LVCMOS33 [get_ports data[4]]

# LED5
set_property PACKAGE_PIN U15 [get_ports data[5]]
set_property IOSTANDARD LVCMOS33 [get_ports data[5]]

# LED6
set_property PACKAGE_PIN U14 [get_ports data[6]]
set_property IOSTANDARD LVCMOS33 [get_ports data[6]]

# LED7
set_property PACKAGE_PIN V14 [get_ports data[7]]
set_property IOSTANDARD LVCMOS33 [get_ports data[7]]

# LED15 - rx valid indicator
set_property PACKAGE_PIN L1 [get_ports valid]
set_property IOSTANDARD LVCMOS33 [get_ports valid]
