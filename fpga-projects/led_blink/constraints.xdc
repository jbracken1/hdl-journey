# Clock - 100MHz oscillator
set_property PACKAGE_PIN W5 [get_ports clk_100MHz]
set_property IOSTANDARD LVCMOS33 [get_ports clk_100MHz]
create_clock -period 10.000 [get_ports clk_100MHz]

# LED0
set_property PACKAGE_PIN U16 [get_ports clk_1Hz[0]]
set_property IOSTANDARD LVCMOS33 [get_ports clk_1Hz[0]]

# LED1
set_property PACKAGE_PIN E19 [get_ports clk_1Hz[1]]
set_property IOSTANDARD LVCMOS33 [get_ports clk_1Hz[1]]

# LED2
set_property PACKAGE_PIN U19 [get_ports clk_1Hz[2]]
set_property IOSTANDARD LVCMOS33 [get_ports clk_1Hz[2]]

# LED3
set_property PACKAGE_PIN V19 [get_ports clk_1Hz[3]]
set_property IOSTANDARD LVCMOS33 [get_ports clk_1Hz[3]]