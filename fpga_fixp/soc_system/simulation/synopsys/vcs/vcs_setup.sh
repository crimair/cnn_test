
# (C) 2001-2015 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions and 
# other software and tools, and its AMPP partner logic functions, and 
# any output files any of the foregoing (including device programming 
# or simulation files), and any associated documentation or information 
# are expressly subject to the terms and conditions of the Altera 
# Program License Subscription Agreement, Altera MegaCore Function 
# License Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by Altera 
# or its authorized distributors. Please refer to the applicable 
# agreement for further details.

# ACDS 13.1 182 linux 2015.06.24.10:50:23

# ----------------------------------------
# vcs - auto-generated simulation script

# ----------------------------------------
# initialize variables
TOP_LEVEL_NAME="soc_system"
QSYS_SIMDIR="./../../"
QUARTUS_INSTALL_DIR="/usr/tool/Altera/13.1.4s/quartus/"
SKIP_FILE_COPY=0
SKIP_ELAB=0
SKIP_SIM=0
USER_DEFINED_ELAB_OPTIONS=""
USER_DEFINED_SIM_OPTIONS="+vcs+finish+100"
# ----------------------------------------
# overwrite variables - DO NOT MODIFY!
# This block evaluates each command line argument, typically used for 
# overwriting variables. An example usage:
#   sh <simulator>_setup.sh SKIP_ELAB=1 SKIP_SIM=1
for expression in "$@"; do
  eval $expression
  if [ $? -ne 0 ]; then
    echo "Error: This command line argument, \"$expression\", is/has an invalid expression." >&2
    exit $?
  fi
done

# ----------------------------------------
# initialize simulation properties - DO NOT MODIFY!
ELAB_OPTIONS=""
SIM_OPTIONS=""
if [[ `vcs -platform` != *"amd64"* ]]; then
  :
else
  :
fi

# ----------------------------------------
# copy RAM/ROM files to simulation directory

vcs -lca -timescale=1ps/1ps -sverilog +verilog2001ext+.v -ntb_opts dtm $ELAB_OPTIONS $USER_DEFINED_ELAB_OPTIONS \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/220model.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v \
  $QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/synopsys/cyclonev_atoms_ncrypt.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/synopsys/cyclonev_hmi_atoms_ncrypt.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_atoms.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/synopsys/cyclonev_hssi_atoms_ncrypt.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_hssi_atoms.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/synopsys/cyclonev_pcie_hip_atoms_ncrypt.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_pcie_hip_atoms.v \
  $QSYS_SIMDIR/submodules/verbosity_pkg.sv \
  $QSYS_SIMDIR/submodules/avalon_utilities_pkg.sv \
  $QSYS_SIMDIR/submodules/avalon_mm_pkg.sv \
  $QSYS_SIMDIR/submodules/altera_avalon_mm_slave_bfm.sv \
  $QSYS_SIMDIR/submodules/altera_avalon_interrupt_sink.sv \
  $QSYS_SIMDIR/submodules/altera_avalon_clock_source.sv \
  $QSYS_SIMDIR/submodules/altera_avalon_reset_source.sv \
  $QSYS_SIMDIR/submodules/soc_system_hps_0_hps_io_border_memory.sv \
  $QSYS_SIMDIR/submodules/soc_system_hps_0_hps_io_border_hps_io.sv \
  $QSYS_SIMDIR/submodules/soc_system_hps_0_hps_io_border.sv \
  $QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv \
  $QSYS_SIMDIR/submodules/soc_system_mm_interconnect_2_rsp_xbar_mux.sv \
  $QSYS_SIMDIR/submodules/soc_system_mm_interconnect_2_rsp_xbar_demux.sv \
  $QSYS_SIMDIR/submodules/soc_system_mm_interconnect_2_cmd_xbar_mux.sv \
  $QSYS_SIMDIR/submodules/soc_system_mm_interconnect_2_cmd_xbar_demux.sv \
  $QSYS_SIMDIR/submodules/soc_system_mm_interconnect_2_id_router.sv \
  $QSYS_SIMDIR/submodules/soc_system_mm_interconnect_2_addr_router.sv \
  $QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_rsp_xbar_mux.sv \
  $QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_rsp_xbar_demux.sv \
  $QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_cmd_xbar_mux.sv \
  $QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_cmd_xbar_demux.sv \
  $QSYS_SIMDIR/submodules/altera_merlin_burst_adapter.sv \
  $QSYS_SIMDIR/submodules/altera_merlin_address_alignment.sv \
  $QSYS_SIMDIR/submodules/altera_merlin_traffic_limiter.sv \
  $QSYS_SIMDIR/submodules/altera_merlin_reorder_memory.sv \
  $QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v \
  $QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_base.v \
  $QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_id_router.sv \
  $QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_addr_router.sv \
  $QSYS_SIMDIR/submodules/altera_merlin_slave_agent.sv \
  $QSYS_SIMDIR/submodules/altera_merlin_burst_uncompressor.sv \
  $QSYS_SIMDIR/submodules/altera_merlin_axi_master_ni.sv \
  $QSYS_SIMDIR/submodules/altera_merlin_slave_translator.sv \
  $QSYS_SIMDIR/submodules/soc_system_hps_0_hps_io.v \
  $QSYS_SIMDIR/submodules/questa_mvc_svapi.svh \
  $QSYS_SIMDIR/submodules/mgc_common_axi.sv \
  $QSYS_SIMDIR/submodules/mgc_axi_master.sv \
  $QSYS_SIMDIR/submodules/mgc_axi_slave.sv \
  $QSYS_SIMDIR/submodules/soc_system_hps_0_fpga_interfaces_f2h_cold_reset_req.sv \
  $QSYS_SIMDIR/submodules/soc_system_hps_0_fpga_interfaces_f2h_debug_reset_req.sv \
  $QSYS_SIMDIR/submodules/soc_system_hps_0_fpga_interfaces_f2h_warm_reset_req.sv \
  $QSYS_SIMDIR/submodules/soc_system_hps_0_fpga_interfaces_f2h_stm_hw_events.sv \
  $QSYS_SIMDIR/submodules/soc_system_hps_0_fpga_interfaces.sv \
  $QSYS_SIMDIR/submodules/altera_reset_controller.v \
  $QSYS_SIMDIR/submodules/altera_reset_synchronizer.v \
  $QSYS_SIMDIR/submodules/soc_system_irq_mapper.sv \
  $QSYS_SIMDIR/submodules/soc_system_mm_interconnect_2.v \
  $QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0.v \
  $QSYS_SIMDIR/submodules/altera_avalon_mm_clock_crossing_bridge.v \
  $QSYS_SIMDIR/submodules/altera_avalon_dc_fifo.v \
  $QSYS_SIMDIR/submodules/altera_dcfifo_synchronizer_bundle.v \
  $QSYS_SIMDIR/submodules/altera_avalon_mm_bridge.v \
  $QSYS_SIMDIR/submodules/soc_system_sysid_qsys.vo \
  $QSYS_SIMDIR/submodules/soc_system_hps_0.v \
  $QSYS_SIMDIR/soc_system.v \
  -top $TOP_LEVEL_NAME
# ----------------------------------------
# simulate
if [ $SKIP_SIM -eq 0 ]; then
  ./simv $SIM_OPTIONS $USER_DEFINED_SIM_OPTIONS
fi
