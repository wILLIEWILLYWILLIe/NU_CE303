#!/bin/bash
#
# Usage:
#   ./run_alu_sim.sh [netlist_file] [testbench_file]
#
# Examples:
#   ./run_alu_sim.sh
#   ./run_alu_sim.sh ./Synthesis/alu_syn.v tb_alu_wave.v
#   ./run_alu_sim.sh ./Synthesis/alu_syn.v tb_alu_tiny.v
#
# This script runs Cadence Xcelium (xrun) in GUI mode on the ALU.
# It will also pull in the Nangate cell library model.

# -------- defaults --------
NETLIST_DEFAULT="./Synthesis/alu_syn.v"
TB_DEFAULT="tb_alu_wave.v"
LIB_PATH="/vol/ece303/genus_tutorial/NangateOpenCellLibrary.v"

# -------- pick args or defaults --------
NETLIST_FILE="${1:-$NETLIST_DEFAULT}"
TB_FILE="${2:-$TB_DEFAULT}"

echo "[INFO] Using netlist:   $NETLIST_FILE"
echo "[INFO] Using testbench: $TB_FILE"
echo "[INFO] Using lib:       $LIB_PATH"
echo "[INFO] Launching xrun..."

# -------- run xrun --------
xrun -64bit -gui -access r \
  -xmelab_args "-warnmax 0 -delay_mode zero -maxdelays" \
  "$NETLIST_FILE" "$TB_FILE" "$LIB_PATH"
