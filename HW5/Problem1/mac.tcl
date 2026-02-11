#-------------------------------------------------------
# Genus synthesis script for MAC
#-------------------------------------------------------

# Top module name
set TOP mac
read_hdl mac.v
# Paths 
set_db library /vol/ece303/genus_tutorial/NangateOpenCellLibrary_typical.lib
# set_db lef_library /vol/ece303/genus_tutorial/NangateOpenCellLibrary.lef

# read_hdl -sv mac.v
elaborate $TOP
current_design $TOP

read_sdc mac.sdc

# synthesize -to_mapped
syn_generic
syn_map
syn_opt

report_area   > mac_report_area.rpt
report_timing > mac_report_timing.rpt

write_hdl > mac_netlist.v
write_sdf > mac.sdf
