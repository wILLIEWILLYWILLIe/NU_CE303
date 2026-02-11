# Cadence Genus(TM) Synthesis Solution, Version 18.14-s037_1, built Mar 27 2019 12:19:21

# Date: Fri Oct 24 13:11:47 2025
# Host: finagle.wot.ece.northwestern.edu (x86_64 w/Linux 4.18.0-553.78.1.el8_10.x86_64) (12cores*48cpus*2physical cpus*Intel(R) Xeon(R) Gold 5317 CPU @ 3.00GHz 18432KB)
# OS:   Red Hat Enterprise Linux release 8.10 (Ootpa)

read_hdl ../alu.v
et_db library /vol/ece303/genus_tutorial/NangateOpenCellLibrary_typical.lib
set_db library /vol/ece303/genus_tutorial/NangateOpenCellLibrary_typical.lib
set_db lef_library /vol/ece303/genus_tutorial/NangateOpenCellLibrary.lef
elaborate
current_design alu
current_design alu8
read_sdc ../alu8_1ns.sdc
syn_generic
syn_map
syn_opt
report_timing > timing.rpt
report_area > area.rpt
write_hdl > alu_syn.v
quit
