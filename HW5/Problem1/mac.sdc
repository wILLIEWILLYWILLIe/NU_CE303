# 1 GHz (1 ns period)
create_clock -name clk -period 1.0 [get_ports clk]

# Input delays for IN and W 
set_input_delay -max 0.5 -clock clk [get_ports {IN[*] W[*]}]
set_input_delay -min -0.2 -clock clk [get_ports {IN[*] W[*]}]

# Output delays for OUT
set_output_delay -max 0.5 -clock clk [get_ports {OUT[*]}]
set_output_delay -min -0.2 -clock clk [get_ports {OUT[*]}]
