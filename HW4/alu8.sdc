
create_clock -name VCLK -period 1.000


set_input_delay  -max 0.10 -clock VCLK [get_ports {A[*] B[*] F[*]}]
set_input_delay  -min 0.02 -clock VCLK [get_ports {A[*] B[*] F[*]}]

set_output_delay -max 0.10 -clock VCLK [get_ports {Q[*] Cout}]
set_output_delay -min 0.02 -clock VCLK [get_ports {Q[*] Cout}]

set_max_delay 1.000 -from [get_ports {A[*] B[*] F[*]}] -to [get_ports {Q[*] Cout}]
