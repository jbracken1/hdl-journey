# Clock signal
set_property -dict { PACKAGE_PIN W5   IOSTANDARD LVCMOS33 } [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

#tx
set_property PACKAGE_PIN A18 [get_ports tx]						
	set_property IOSTANDARD LVCMOS33 [get_ports tx]

# center button 
set_property PACKAGE_PIN U18 [get_ports button]						
	set_property IOSTANDARD LVCMOS33 [get_ports button]

# Switches
set_property -dict { PACKAGE_PIN V17   IOSTANDARD LVCMOS33 } [get_ports {sw[0]}]
set_property -dict { PACKAGE_PIN V16   IOSTANDARD LVCMOS33 } [get_ports {sw[1]}]
set_property -dict { PACKAGE_PIN W16   IOSTANDARD LVCMOS33 } [get_ports {sw[2]}]
set_property -dict { PACKAGE_PIN W17   IOSTANDARD LVCMOS33 } [get_ports {sw[3]}]
set_property -dict { PACKAGE_PIN W15   IOSTANDARD LVCMOS33 } [get_ports {sw[4]}]
set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS33 } [get_ports {sw[5]}]
set_property -dict { PACKAGE_PIN W14   IOSTANDARD LVCMOS33 } [get_ports {sw[6]}]
set_property -dict { PACKAGE_PIN W13   IOSTANDARD LVCMOS33 } [get_ports {sw[7]}]


# LED0
set_property PACKAGE_PIN U16 [get_ports led[0]]
set_property IOSTANDARD LVCMOS33 [get_ports led[0]]

# LED1
set_property PACKAGE_PIN E19 [get_ports led[1]]
set_property IOSTANDARD LVCMOS33 [get_ports led[1]]

# LED2
set_property PACKAGE_PIN U19 [get_ports led[2]]
set_property IOSTANDARD LVCMOS33 [get_ports led[2]]

# LED3
set_property PACKAGE_PIN V19 [get_ports led[3]]
set_property IOSTANDARD LVCMOS33 [get_ports led[3]]

# LED4
set_property PACKAGE_PIN W18 [get_ports led[4]]
set_property IOSTANDARD LVCMOS33 [get_ports led[4]]

# LED5
set_property PACKAGE_PIN U15 [get_ports led[5]]
set_property IOSTANDARD LVCMOS33 [get_ports led[5]]

# LED6
set_property PACKAGE_PIN U14 [get_ports led[6]]
set_property IOSTANDARD LVCMOS33 [get_ports led[6]]

# LED7
set_property PACKAGE_PIN V14 [get_ports led[7]]
set_property IOSTANDARD LVCMOS33 [get_ports led[7]]

# LED15 - tx busy indicator
set_property PACKAGE_PIN L1 [get_ports tx_busy]
set_property IOSTANDARD LVCMOS33 [get_ports tx_busy]
