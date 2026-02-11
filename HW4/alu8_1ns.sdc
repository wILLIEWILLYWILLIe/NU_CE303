# alu8_1ns.sdc
# Timing constraints: ALL ALU operations must complete within 1 ns.
# This SDC models the ALU as a purely combinational block between inputs and outputs.

# 1) Virtual clock at 1 GHz (1.000 ns period)
create_clock -name VCLK -period 1.000

# 2) Tight IO timing assumptions relative to the virtual clock.
#    Adjust these if your upstream/downstream budgets differ.
set_input_delay  -max 0.10 -clock VCLK [get_ports {A[*] B[*] F[*]}]
set_input_delay  -min 0.02 -clock VCLK [get_ports {A[*] B[*] F[*]}]

set_output_delay -max 0.10 -clock VCLK [get_ports {Q[*] Cout}]
set_output_delay -min 0.02 -clock VCLK [get_ports {Q[*] Cout}]

# 3) Explicit end-to-end max delay between all inputs and all outputs <= 1.000 ns
#    (This is redundant with the clock/delays above, but makes intent crystal clear.)
set_max_delay 1.000 -from [get_ports {A[*] B[*] F[*]}] -to [get_ports {Q[*] Cout}]

# (Optional) If your tool/library supports these, uncomment and tune as needed:
# set_load 0.02 [get_ports {Q[*] Cout}]     ;# ~20 fF per output pin
# set_drive 0    [get_ports {A[*] B[*] F[*]}]
