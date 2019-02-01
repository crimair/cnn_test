
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

# ACDS 13.1 162 linux 2015.06.22.13:03:32

# ----------------------------------------
# ncsim - auto-generated simulation script

# ----------------------------------------
# initialize variables
TOP_LEVEL_NAME="soc_system_tb"
QSYS_SIMDIR="./../"
QUARTUS_INSTALL_DIR="/usr/tool/Altera/13.1s/quartus/"
SKIP_FILE_COPY=0
SKIP_DEV_COM=0
SKIP_COM=0
SKIP_ELAB=0
SKIP_SIM=0
USER_DEFINED_ELAB_OPTIONS=""
USER_DEFINED_SIM_OPTIONS="-input \"@run 100; exit\""

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
if [[ `ncsim -version` != *"ncsim(64)"* ]]; then
  :
else
  :
fi

# ----------------------------------------
# create compilation libraries
mkdir -p ./libraries/work/
mkdir -p ./libraries/altera_common_sv_packages/
mkdir -p ./libraries/border/
mkdir -p ./libraries/crosser/
mkdir -p ./libraries/rsp_xbar_mux/
mkdir -p ./libraries/rsp_xbar_demux/
mkdir -p ./libraries/cmd_xbar_mux/
mkdir -p ./libraries/cmd_xbar_demux/
mkdir -p ./libraries/id_router/
mkdir -p ./libraries/addr_router/
mkdir -p ./libraries/burst_adapter/
mkdir -p ./libraries/limiter/
mkdir -p ./libraries/sysid_qsys_control_slave_translator_avalon_universal_slave_0_agent_rsp_fifo/
mkdir -p ./libraries/sysid_qsys_control_slave_translator_avalon_universal_slave_0_agent/
mkdir -p ./libraries/hps_0_h2f_lw_axi_master_agent/
mkdir -p ./libraries/sysid_qsys_control_slave_translator/
mkdir -p ./libraries/hps_io/
mkdir -p ./libraries/fpga_interfaces/
mkdir -p ./libraries/irq_mapper/
mkdir -p ./libraries/mm_interconnect_1/
mkdir -p ./libraries/mm_interconnect_0/
mkdir -p ./libraries/mm_bridge_0/
mkdir -p ./libraries/sysid_qsys/
mkdir -p ./libraries/hps_0/
mkdir -p ./libraries/rst_controller/
mkdir -p ./libraries/soc_system_inst_reg_avl_bfm/
mkdir -p ./libraries/soc_system_inst_hps_0_f2h_stm_hw_events_bfm/
mkdir -p ./libraries/soc_system_inst_hps_0_hps_io_bfm/
mkdir -p ./libraries/soc_system_inst_memory_bfm/
mkdir -p ./libraries/soc_system_inst_reset_bfm/
mkdir -p ./libraries/soc_system_inst_clk_bfm/
mkdir -p ./libraries/soc_system_inst/
mkdir -p ./libraries/altera_ver/
mkdir -p ./libraries/lpm_ver/
mkdir -p ./libraries/sgate_ver/
mkdir -p ./libraries/altera_mf_ver/
mkdir -p ./libraries/altera_lnsim_ver/
mkdir -p ./libraries/cyclonev_ver/
mkdir -p ./libraries/cyclonev_hssi_ver/
mkdir -p ./libraries/cyclonev_pcie_hip_ver/

# ----------------------------------------
# copy RAM/ROM files to simulation directory

# ----------------------------------------
# compile device library files
if [ $SKIP_DEV_COM -eq 0 ]; then
  ncvlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.v"                      -work altera_ver           
  ncvlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.v"                               -work lpm_ver              
  ncvlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.v"                                  -work sgate_ver            
  ncvlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v"                              -work altera_mf_ver        
  ncvlog -sv "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv"                          -work altera_lnsim_ver     
  ncvlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cadence/cyclonev_atoms_ncrypt.v"          -work cyclonev_ver         
  ncvlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cadence/cyclonev_hmi_atoms_ncrypt.v"      -work cyclonev_ver         
  ncvlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_atoms.v"                         -work cyclonev_ver         
  ncvlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cadence/cyclonev_hssi_atoms_ncrypt.v"     -work cyclonev_hssi_ver    
  ncvlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_hssi_atoms.v"                    -work cyclonev_hssi_ver    
  ncvlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cadence/cyclonev_pcie_hip_atoms_ncrypt.v" -work cyclonev_pcie_hip_ver
  ncvlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_pcie_hip_atoms.v"                -work cyclonev_pcie_hip_ver
fi

# ----------------------------------------
# compile design files in correct order
if [ $SKIP_COM -eq 0 ]; then
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/verbosity_pkg.sv"                                        -work altera_common_sv_packages                                                   -cdslib ./cds_libs/altera_common_sv_packages.cds.lib                                                  
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/avalon_utilities_pkg.sv"                                 -work altera_common_sv_packages                                                   -cdslib ./cds_libs/altera_common_sv_packages.cds.lib                                                  
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/avalon_mm_pkg.sv"                                        -work altera_common_sv_packages                                                   -cdslib ./cds_libs/altera_common_sv_packages.cds.lib                                                  
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/altera_avalon_mm_slave_bfm.sv"                           -work border                                                                      -cdslib ./cds_libs/border.cds.lib                                                                     
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/altera_avalon_interrupt_sink.sv"                         -work border                                                                      -cdslib ./cds_libs/border.cds.lib                                                                     
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/altera_avalon_clock_source.sv"                           -work border                                                                      -cdslib ./cds_libs/border.cds.lib                                                                     
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/altera_avalon_reset_source.sv"                           -work border                                                                      -cdslib ./cds_libs/border.cds.lib                                                                     
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/soc_system_hps_0_hps_io_border_memory.sv"                -work border                                                                      -cdslib ./cds_libs/border.cds.lib                                                                     
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/soc_system_hps_0_hps_io_border_hps_io.sv"                -work border                                                                      -cdslib ./cds_libs/border.cds.lib                                                                     
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/soc_system_hps_0_hps_io_border.sv"                       -work border                                                                      -cdslib ./cds_libs/border.cds.lib                                                                     
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/altera_avalon_st_handshake_clock_crosser.v"              -work crosser                                                                     -cdslib ./cds_libs/crosser.cds.lib                                                                    
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/altera_avalon_st_clock_crosser.v"                        -work crosser                                                                     -cdslib ./cds_libs/crosser.cds.lib                                                                    
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/altera_avalon_st_pipeline_base.v"                        -work crosser                                                                     -cdslib ./cds_libs/crosser.cds.lib                                                                    
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/altera_merlin_arbitrator.sv"                             -work rsp_xbar_mux                                                                -cdslib ./cds_libs/rsp_xbar_mux.cds.lib                                                               
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/soc_system_mm_interconnect_1_rsp_xbar_mux.sv"            -work rsp_xbar_mux                                                                -cdslib ./cds_libs/rsp_xbar_mux.cds.lib                                                               
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/soc_system_mm_interconnect_1_rsp_xbar_demux.sv"          -work rsp_xbar_demux                                                              -cdslib ./cds_libs/rsp_xbar_demux.cds.lib                                                             
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/altera_merlin_arbitrator.sv"                             -work cmd_xbar_mux                                                                -cdslib ./cds_libs/cmd_xbar_mux.cds.lib                                                               
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/soc_system_mm_interconnect_1_cmd_xbar_mux.sv"            -work cmd_xbar_mux                                                                -cdslib ./cds_libs/cmd_xbar_mux.cds.lib                                                               
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/soc_system_mm_interconnect_1_cmd_xbar_demux.sv"          -work cmd_xbar_demux                                                              -cdslib ./cds_libs/cmd_xbar_demux.cds.lib                                                             
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/soc_system_mm_interconnect_1_id_router.sv"               -work id_router                                                                   -cdslib ./cds_libs/id_router.cds.lib                                                                  
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/soc_system_mm_interconnect_1_addr_router.sv"             -work addr_router                                                                 -cdslib ./cds_libs/addr_router.cds.lib                                                                
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/altera_merlin_arbitrator.sv"                             -work rsp_xbar_mux                                                                -cdslib ./cds_libs/rsp_xbar_mux.cds.lib                                                               
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/soc_system_mm_interconnect_0_rsp_xbar_mux.sv"            -work rsp_xbar_mux                                                                -cdslib ./cds_libs/rsp_xbar_mux.cds.lib                                                               
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/soc_system_mm_interconnect_0_rsp_xbar_demux.sv"          -work rsp_xbar_demux                                                              -cdslib ./cds_libs/rsp_xbar_demux.cds.lib                                                             
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/altera_merlin_arbitrator.sv"                             -work cmd_xbar_mux                                                                -cdslib ./cds_libs/cmd_xbar_mux.cds.lib                                                               
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/soc_system_mm_interconnect_0_cmd_xbar_mux.sv"            -work cmd_xbar_mux                                                                -cdslib ./cds_libs/cmd_xbar_mux.cds.lib                                                               
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/soc_system_mm_interconnect_0_cmd_xbar_demux.sv"          -work cmd_xbar_demux                                                              -cdslib ./cds_libs/cmd_xbar_demux.cds.lib                                                             
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/altera_merlin_burst_adapter.sv"                          -work burst_adapter                                                               -cdslib ./cds_libs/burst_adapter.cds.lib                                                              
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/altera_merlin_address_alignment.sv"                      -work burst_adapter                                                               -cdslib ./cds_libs/burst_adapter.cds.lib                                                              
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/altera_merlin_traffic_limiter.sv"                        -work limiter                                                                     -cdslib ./cds_libs/limiter.cds.lib                                                                    
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/altera_merlin_reorder_memory.sv"                         -work limiter                                                                     -cdslib ./cds_libs/limiter.cds.lib                                                                    
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/altera_avalon_sc_fifo.v"                                 -work limiter                                                                     -cdslib ./cds_libs/limiter.cds.lib                                                                    
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/altera_avalon_st_pipeline_base.v"                        -work limiter                                                                     -cdslib ./cds_libs/limiter.cds.lib                                                                    
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/soc_system_mm_interconnect_0_id_router.sv"               -work id_router                                                                   -cdslib ./cds_libs/id_router.cds.lib                                                                  
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/soc_system_mm_interconnect_0_addr_router.sv"             -work addr_router                                                                 -cdslib ./cds_libs/addr_router.cds.lib                                                                
  ncvlog     "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/altera_avalon_sc_fifo.v"                                 -work sysid_qsys_control_slave_translator_avalon_universal_slave_0_agent_rsp_fifo -cdslib ./cds_libs/sysid_qsys_control_slave_translator_avalon_universal_slave_0_agent_rsp_fifo.cds.lib
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/altera_merlin_slave_agent.sv"                            -work sysid_qsys_control_slave_translator_avalon_universal_slave_0_agent          -cdslib ./cds_libs/sysid_qsys_control_slave_translator_avalon_universal_slave_0_agent.cds.lib         
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/altera_merlin_burst_uncompressor.sv"                     -work sysid_qsys_control_slave_translator_avalon_universal_slave_0_agent          -cdslib ./cds_libs/sysid_qsys_control_slave_translator_avalon_universal_slave_0_agent.cds.lib         
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/altera_merlin_axi_master_ni.sv"                          -work hps_0_h2f_lw_axi_master_agent                                               -cdslib ./cds_libs/hps_0_h2f_lw_axi_master_agent.cds.lib                                              
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/altera_merlin_address_alignment.sv"                      -work hps_0_h2f_lw_axi_master_agent                                               -cdslib ./cds_libs/hps_0_h2f_lw_axi_master_agent.cds.lib                                              
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/altera_merlin_slave_translator.sv"                       -work sysid_qsys_control_slave_translator                                         -cdslib ./cds_libs/sysid_qsys_control_slave_translator.cds.lib                                        
  ncvlog     "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/soc_system_hps_0_hps_io.v"                               -work hps_io                                                                      -cdslib ./cds_libs/hps_io.cds.lib                                                                     
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/altera_avalon_mm_slave_bfm.sv"                           -work fpga_interfaces                                                             -cdslib ./cds_libs/fpga_interfaces.cds.lib                                                            
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/questa_mvc_svapi.svh"                                    -work fpga_interfaces                                                             -cdslib ./cds_libs/fpga_interfaces.cds.lib                                                            
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/mgc_common_axi.sv"                                       -work fpga_interfaces                                                             -cdslib ./cds_libs/fpga_interfaces.cds.lib                                                            
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/mgc_axi_master.sv"                                       -work fpga_interfaces                                                             -cdslib ./cds_libs/fpga_interfaces.cds.lib                                                            
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/mgc_axi_slave.sv"                                        -work fpga_interfaces                                                             -cdslib ./cds_libs/fpga_interfaces.cds.lib                                                            
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/altera_avalon_interrupt_sink.sv"                         -work fpga_interfaces                                                             -cdslib ./cds_libs/fpga_interfaces.cds.lib                                                            
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/altera_avalon_clock_source.sv"                           -work fpga_interfaces                                                             -cdslib ./cds_libs/fpga_interfaces.cds.lib                                                            
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/altera_avalon_reset_source.sv"                           -work fpga_interfaces                                                             -cdslib ./cds_libs/fpga_interfaces.cds.lib                                                            
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/soc_system_hps_0_fpga_interfaces_f2h_cold_reset_req.sv"  -work fpga_interfaces                                                             -cdslib ./cds_libs/fpga_interfaces.cds.lib                                                            
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/soc_system_hps_0_fpga_interfaces_f2h_debug_reset_req.sv" -work fpga_interfaces                                                             -cdslib ./cds_libs/fpga_interfaces.cds.lib                                                            
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/soc_system_hps_0_fpga_interfaces_f2h_warm_reset_req.sv"  -work fpga_interfaces                                                             -cdslib ./cds_libs/fpga_interfaces.cds.lib                                                            
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/soc_system_hps_0_fpga_interfaces_f2h_stm_hw_events.sv"   -work fpga_interfaces                                                             -cdslib ./cds_libs/fpga_interfaces.cds.lib                                                            
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/soc_system_hps_0_fpga_interfaces.sv"                     -work fpga_interfaces                                                             -cdslib ./cds_libs/fpga_interfaces.cds.lib                                                            
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/soc_system_irq_mapper.sv"                                -work irq_mapper                                                                  -cdslib ./cds_libs/irq_mapper.cds.lib                                                                 
  ncvlog     "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/soc_system_mm_interconnect_1.v"                          -work mm_interconnect_1                                                           -cdslib ./cds_libs/mm_interconnect_1.cds.lib                                                          
  ncvlog     "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/soc_system_mm_interconnect_0.v"                          -work mm_interconnect_0                                                           -cdslib ./cds_libs/mm_interconnect_0.cds.lib                                                          
  ncvlog     "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/altera_avalon_mm_bridge.v"                               -work mm_bridge_0                                                                 -cdslib ./cds_libs/mm_bridge_0.cds.lib                                                                
  ncvlog     "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/soc_system_sysid_qsys.vo"                                -work sysid_qsys                                                                  -cdslib ./cds_libs/sysid_qsys.cds.lib                                                                 
  ncvlog     "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/soc_system_hps_0.v"                                      -work hps_0                                                                       -cdslib ./cds_libs/hps_0.cds.lib                                                                      
  ncvlog     "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/altera_reset_controller.v"                               -work rst_controller                                                              -cdslib ./cds_libs/rst_controller.cds.lib                                                             
  ncvlog     "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/altera_reset_synchronizer.v"                             -work rst_controller                                                              -cdslib ./cds_libs/rst_controller.cds.lib                                                             
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/altera_avalon_mm_slave_bfm.sv"                           -work soc_system_inst_reg_avl_bfm                                                 -cdslib ./cds_libs/soc_system_inst_reg_avl_bfm.cds.lib                                                
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/altera_conduit_bfm_0003.sv"                              -work soc_system_inst_hps_0_f2h_stm_hw_events_bfm                                 -cdslib ./cds_libs/soc_system_inst_hps_0_f2h_stm_hw_events_bfm.cds.lib                                
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/altera_conduit_bfm_0002.sv"                              -work soc_system_inst_hps_0_hps_io_bfm                                            -cdslib ./cds_libs/soc_system_inst_hps_0_hps_io_bfm.cds.lib                                           
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/altera_conduit_bfm.sv"                                   -work soc_system_inst_memory_bfm                                                  -cdslib ./cds_libs/soc_system_inst_memory_bfm.cds.lib                                                 
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/altera_avalon_reset_source.sv"                           -work soc_system_inst_reset_bfm                                                   -cdslib ./cds_libs/soc_system_inst_reset_bfm.cds.lib                                                  
  ncvlog -sv "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/altera_avalon_clock_source.sv"                           -work soc_system_inst_clk_bfm                                                     -cdslib ./cds_libs/soc_system_inst_clk_bfm.cds.lib                                                    
  ncvlog     "$QSYS_SIMDIR/soc_system_tb/simulation/submodules/soc_system.v"                                            -work soc_system_inst                                                             -cdslib ./cds_libs/soc_system_inst.cds.lib                                                            
  ncvlog     "$QSYS_SIMDIR/soc_system_tb/simulation/soc_system_tb.v"                                                                                                                                                                                                                                            
fi

# ----------------------------------------
# elaborate top level design
if [ $SKIP_ELAB -eq 0 ]; then
  ncelab -access +w+r+c -namemap_mixgen $ELAB_OPTIONS $USER_DEFINED_ELAB_OPTIONS $TOP_LEVEL_NAME
fi

# ----------------------------------------
# simulate
if [ $SKIP_SIM -eq 0 ]; then
  eval ncsim -licqueue $SIM_OPTIONS $USER_DEFINED_SIM_OPTIONS $TOP_LEVEL_NAME
fi
