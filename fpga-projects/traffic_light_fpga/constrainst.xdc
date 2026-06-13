# Clock - 100MHz oscillator
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 [get_ports clk]

# LED0
set_property PACKAGE_PIN U16 [get_ports red]
set_property IOSTANDARD LVCMOS33 [get_ports red]

# LED1
set_property PACKAGE_PIN E19 [get_ports yellow]
set_property IOSTANDARD LVCMOS33 [get_ports yellow]

# LED2
set_property PACKAGE_PIN U19 [get_ports green]
set_property IOSTANDARD LVCMOS33 [get_ports green]