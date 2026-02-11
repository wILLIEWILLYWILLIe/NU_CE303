# Cadence Genus(TM) Synthesis Solution, Version 18.14-s037_1, built Mar 27 2019 12:19:21

# Date: Wed Oct 15 20:02:37 2025
# Host: finagle.wot.ece.northwestern.edu (x86_64 w/Linux 4.18.0-553.78.1.el8_10.x86_64) (12cores*48cpus*2physical cpus*Intel(R) Xeon(R) Gold 5317 CPU @ 3.00GHz 18432KB)
# OS:   Red Hat Enterprise Linux release 8.10 (Ootpa)

read_hdl ../alu_conv.v
set_db library /vol/ece303/genus_tutorial/NangateOpenCellLibrary_typical.lib
set_db lef_library /vol/ece303/genus_tutorial/NangateOpenCellLibrary.lef
elaborate
$ current_design alu_conv
current_design alu_conv
read_sdc ../alu_conv.sdc
syn_generic
syn_map
syn_opt
report_timing > timing.rpt
report_area > area.rpt
write_hdl > alu_conv_syn.v
quit
