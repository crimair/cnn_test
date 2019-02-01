
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

# ACDS 13.1 162 linux 2015.06.22.13:01:53

# ----------------------------------------
# Auto-generated simulation script

# ----------------------------------------
# Initialize variables
if ![info exists SYSTEM_INSTANCE_NAME] { 
  set SYSTEM_INSTANCE_NAME ""
} elseif { ![ string match "" $SYSTEM_INSTANCE_NAME ] } { 
  set SYSTEM_INSTANCE_NAME "/$SYSTEM_INSTANCE_NAME"
}

if ![info exists TOP_LEVEL_NAME] { 
  set TOP_LEVEL_NAME "soc_system"
}

if ![info exists QSYS_SIMDIR] { 
  set QSYS_SIMDIR "./../"
}

if ![info exists QUARTUS_INSTALL_DIR] { 
  set QUARTUS_INSTALL_DIR "/usr/tool/Altera/13.1s/quartus/"
}

# ----------------------------------------
# Initialize simulation properties - DO NOT MODIFY!
set ELAB_OPTIONS ""
set SIM_OPTIONS ""
if ![ string match "*-64 vsim*" [ vsim -version ] ] {
} else {
}

# ----------------------------------------
# Copy ROM/RAM files to simulation directory
alias file_copy {
  echo "\[exec\] file_copy"
}

# ----------------------------------------
# Create compilation libraries
proc ensure_lib { lib } { if ![file isdirectory $lib] { vlib $lib } }
ensure_lib          ./libraries/     
ensure_lib          ./libraries/work/
vmap       work     ./libraries/work/
vmap       work_lib ./libraries/work/
if ![ string match "*ModelSim ALTERA*" [ vsim -version ] ] {
  ensure_lib                       ./libraries/altera_ver/           
  vmap       altera_ver            ./libraries/altera_ver/           
  ensure_lib                       ./libraries/lpm_ver/              
  vmap       lpm_ver               ./libraries/lpm_ver/              
  ensure_lib                       ./libraries/sgate_ver/            
  vmap       sgate_ver             ./libraries/sgate_ver/            
  ensure_lib                       ./libraries/altera_mf_ver/        
  vmap       altera_mf_ver         ./libraries/altera_mf_ver/        
  ensure_lib                       ./libraries/altera_lnsim_ver/     
  vmap       altera_lnsim_ver      ./libraries/altera_lnsim_ver/     
  ensure_lib                       ./libraries/cyclonev_ver/         
  vmap       cyclonev_ver          ./libraries/cyclonev_ver/         
  ensure_lib                       ./libraries/cyclonev_hssi_ver/    
  vmap       cyclonev_hssi_ver     ./libraries/cyclonev_hssi_ver/    
  ensure_lib                       ./libraries/cyclonev_pcie_hip_ver/
  vmap       cyclonev_pcie_hip_ver ./libraries/cyclonev_pcie_hip_ver/
}
ensure_lib                                                                             ./libraries/altera_common_sv_packages/                                                  
vmap       altera_common_sv_packages                                                   ./libraries/altera_common_sv_packages/                                                  
ensure_lib                                                                             ./libraries/border/                                                                     
vmap       border                                                                      ./libraries/border/                                                                     
ensure_lib                                                                             ./libraries/crosser/                                                                    
vmap       crosser                                                                     ./libraries/crosser/                                                                    
ensure_lib                                                                             ./libraries/rsp_xbar_mux/                                                               
vmap       rsp_xbar_mux                                                                ./libraries/rsp_xbar_mux/                                                               
ensure_lib                                                                             ./libraries/rsp_xbar_demux/                                                             
vmap       rsp_xbar_demux                                                              ./libraries/rsp_xbar_demux/                                                             
ensure_lib                                                                             ./libraries/cmd_xbar_mux/                                                               
vmap       cmd_xbar_mux                                                                ./libraries/cmd_xbar_mux/                                                               
ensure_lib                                                                             ./libraries/cmd_xbar_demux/                                                             
vmap       cmd_xbar_demux                                                              ./libraries/cmd_xbar_demux/                                                             
ensure_lib                                                                             ./libraries/id_router/                                                                  
vmap       id_router                                                                   ./libraries/id_router/                                                                  
ensure_lib                                                                             ./libraries/addr_router/                                                                
vmap       addr_router                                                                 ./libraries/addr_router/                                                                
ensure_lib                                                                             ./libraries/burst_adapter/                                                              
vmap       burst_adapter                                                               ./libraries/burst_adapter/                                                              
ensure_lib                                                                             ./libraries/limiter/                                                                    
vmap       limiter                                                                     ./libraries/limiter/                                                                    
ensure_lib                                                                             ./libraries/sysid_qsys_control_slave_translator_avalon_universal_slave_0_agent_rsp_fifo/
vmap       sysid_qsys_control_slave_translator_avalon_universal_slave_0_agent_rsp_fifo ./libraries/sysid_qsys_control_slave_translator_avalon_universal_slave_0_agent_rsp_fifo/
ensure_lib                                                                             ./libraries/sysid_qsys_control_slave_translator_avalon_universal_slave_0_agent/         
vmap       sysid_qsys_control_slave_translator_avalon_universal_slave_0_agent          ./libraries/sysid_qsys_control_slave_translator_avalon_universal_slave_0_agent/         
ensure_lib                                                                             ./libraries/hps_0_h2f_lw_axi_master_agent/                                              
vmap       hps_0_h2f_lw_axi_master_agent                                               ./libraries/hps_0_h2f_lw_axi_master_agent/                                              
ensure_lib                                                                             ./libraries/sysid_qsys_control_slave_translator/                                        
vmap       sysid_qsys_control_slave_translator                                         ./libraries/sysid_qsys_control_slave_translator/                                        
ensure_lib                                                                             ./libraries/hps_io/                                                                     
vmap       hps_io                                                                      ./libraries/hps_io/                                                                     
ensure_lib                                                                             ./libraries/fpga_interfaces/                                                            
vmap       fpga_interfaces                                                             ./libraries/fpga_interfaces/                                                            
ensure_lib                                                                             ./libraries/rst_controller/                                                             
vmap       rst_controller                                                              ./libraries/rst_controller/                                                             
ensure_lib                                                                             ./libraries/irq_mapper/                                                                 
vmap       irq_mapper                                                                  ./libraries/irq_mapper/                                                                 
ensure_lib                                                                             ./libraries/mm_interconnect_1/                                                          
vmap       mm_interconnect_1                                                           ./libraries/mm_interconnect_1/                                                          
ensure_lib                                                                             ./libraries/mm_interconnect_0/                                                          
vmap       mm_interconnect_0                                                           ./libraries/mm_interconnect_0/                                                          
ensure_lib                                                                             ./libraries/mm_bridge_0/                                                                
vmap       mm_bridge_0                                                                 ./libraries/mm_bridge_0/                                                                
ensure_lib                                                                             ./libraries/sysid_qsys/                                                                 
vmap       sysid_qsys                                                                  ./libraries/sysid_qsys/                                                                 
ensure_lib                                                                             ./libraries/hps_0/                                                                      
vmap       hps_0                                                                       ./libraries/hps_0/                                                                      

# ----------------------------------------
# Compile device library files
alias dev_com {
  echo "\[exec\] dev_com"
  if ![ string match "*ModelSim ALTERA*" [ vsim -version ] ] {
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.v"                     -work altera_ver           
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.v"                              -work lpm_ver              
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.v"                                 -work sgate_ver            
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v"                             -work altera_mf_ver        
    vlog -sv "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv"                         -work altera_lnsim_ver     
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/mentor/cyclonev_atoms_ncrypt.v"          -work cyclonev_ver         
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/mentor/cyclonev_hmi_atoms_ncrypt.v"      -work cyclonev_ver         
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_atoms.v"                        -work cyclonev_ver         
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/mentor/cyclonev_hssi_atoms_ncrypt.v"     -work cyclonev_hssi_ver    
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_hssi_atoms.v"                   -work cyclonev_hssi_ver    
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/mentor/cyclonev_pcie_hip_atoms_ncrypt.v" -work cyclonev_pcie_hip_ver
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_pcie_hip_atoms.v"               -work cyclonev_pcie_hip_ver
  }
}

# ----------------------------------------
# Compile the design files in correct order
alias com {
  echo "\[exec\] com"
  vlog -sv "$QSYS_SIMDIR/submodules/verbosity_pkg.sv"                                                                     -work altera_common_sv_packages                                                  
  vlog -sv "$QSYS_SIMDIR/submodules/avalon_utilities_pkg.sv"                                                              -work altera_common_sv_packages                                                  
  vlog -sv "$QSYS_SIMDIR/submodules/avalon_mm_pkg.sv"                                                                     -work altera_common_sv_packages                                                  
  vlog -sv "$QSYS_SIMDIR/submodules/altera_avalon_mm_slave_bfm.sv"                           -L altera_common_sv_packages -work border                                                                     
  vlog -sv "$QSYS_SIMDIR/submodules/altera_avalon_interrupt_sink.sv"                         -L altera_common_sv_packages -work border                                                                     
  vlog -sv "$QSYS_SIMDIR/submodules/altera_avalon_clock_source.sv"                           -L altera_common_sv_packages -work border                                                                     
  vlog -sv "$QSYS_SIMDIR/submodules/altera_avalon_reset_source.sv"                           -L altera_common_sv_packages -work border                                                                     
  vlog -sv "$QSYS_SIMDIR/submodules/soc_system_hps_0_hps_io_border_memory.sv"                -L altera_common_sv_packages -work border                                                                     
  vlog -sv "$QSYS_SIMDIR/submodules/soc_system_hps_0_hps_io_border_hps_io.sv"                -L altera_common_sv_packages -work border                                                                     
  vlog -sv "$QSYS_SIMDIR/submodules/soc_system_hps_0_hps_io_border.sv"                       -L altera_common_sv_packages -work border                                                                     
  vlog -sv "$QSYS_SIMDIR/submodules/altera_avalon_st_handshake_clock_crosser.v"              -L altera_common_sv_packages -work crosser                                                                    
  vlog -sv "$QSYS_SIMDIR/submodules/altera_avalon_st_clock_crosser.v"                        -L altera_common_sv_packages -work crosser                                                                    
  vlog -sv "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_base.v"                        -L altera_common_sv_packages -work crosser                                                                    
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                             -L altera_common_sv_packages -work rsp_xbar_mux                                                               
  vlog -sv "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_1_rsp_xbar_mux.sv"            -L altera_common_sv_packages -work rsp_xbar_mux                                                               
  vlog -sv "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_1_rsp_xbar_demux.sv"          -L altera_common_sv_packages -work rsp_xbar_demux                                                             
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                             -L altera_common_sv_packages -work cmd_xbar_mux                                                               
  vlog -sv "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_1_cmd_xbar_mux.sv"            -L altera_common_sv_packages -work cmd_xbar_mux                                                               
  vlog -sv "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_1_cmd_xbar_demux.sv"          -L altera_common_sv_packages -work cmd_xbar_demux                                                             
  vlog -sv "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_1_id_router.sv"               -L altera_common_sv_packages -work id_router                                                                  
  vlog -sv "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_1_addr_router.sv"             -L altera_common_sv_packages -work addr_router                                                                
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                             -L altera_common_sv_packages -work rsp_xbar_mux                                                               
  vlog -sv "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_rsp_xbar_mux.sv"            -L altera_common_sv_packages -work rsp_xbar_mux                                                               
  vlog -sv "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_rsp_xbar_demux.sv"          -L altera_common_sv_packages -work rsp_xbar_demux                                                             
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                             -L altera_common_sv_packages -work cmd_xbar_mux                                                               
  vlog -sv "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_cmd_xbar_mux.sv"            -L altera_common_sv_packages -work cmd_xbar_mux                                                               
  vlog -sv "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_cmd_xbar_demux.sv"          -L altera_common_sv_packages -work cmd_xbar_demux                                                             
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter.sv"                          -L altera_common_sv_packages -work burst_adapter                                                              
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_address_alignment.sv"                      -L altera_common_sv_packages -work burst_adapter                                                              
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_traffic_limiter.sv"                        -L altera_common_sv_packages -work limiter                                                                    
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_reorder_memory.sv"                         -L altera_common_sv_packages -work limiter                                                                    
  vlog -sv "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"                                 -L altera_common_sv_packages -work limiter                                                                    
  vlog -sv "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_base.v"                        -L altera_common_sv_packages -work limiter                                                                    
  vlog -sv "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_id_router.sv"               -L altera_common_sv_packages -work id_router                                                                  
  vlog -sv "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_addr_router.sv"             -L altera_common_sv_packages -work addr_router                                                                
  vlog     "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"                                                              -work sysid_qsys_control_slave_translator_avalon_universal_slave_0_agent_rsp_fifo
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_slave_agent.sv"                            -L altera_common_sv_packages -work sysid_qsys_control_slave_translator_avalon_universal_slave_0_agent         
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_burst_uncompressor.sv"                     -L altera_common_sv_packages -work sysid_qsys_control_slave_translator_avalon_universal_slave_0_agent         
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_axi_master_ni.sv"                          -L altera_common_sv_packages -work hps_0_h2f_lw_axi_master_agent                                              
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_address_alignment.sv"                      -L altera_common_sv_packages -work hps_0_h2f_lw_axi_master_agent                                              
  vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_slave_translator.sv"                       -L altera_common_sv_packages -work sysid_qsys_control_slave_translator                                        
  vlog     "$QSYS_SIMDIR/submodules/soc_system_hps_0_hps_io.v"                                                            -work hps_io                                                                     
  vlog -sv "$QSYS_SIMDIR/submodules/altera_avalon_mm_slave_bfm.sv"                           -L altera_common_sv_packages -work fpga_interfaces                                                            
  vlog -sv "$QSYS_SIMDIR/submodules/questa_mvc_svapi.svh"                                    -L altera_common_sv_packages -work fpga_interfaces                                                            
  vlog -sv "$QSYS_SIMDIR/submodules/mgc_common_axi.sv"                                       -L altera_common_sv_packages -work fpga_interfaces                                                            
  vlog -sv "$QSYS_SIMDIR/submodules/mgc_axi_master.sv"                                       -L altera_common_sv_packages -work fpga_interfaces                                                            
  vlog -sv "$QSYS_SIMDIR/submodules/mgc_axi_slave.sv"                                        -L altera_common_sv_packages -work fpga_interfaces                                                            
  vlog -sv "$QSYS_SIMDIR/submodules/altera_avalon_interrupt_sink.sv"                         -L altera_common_sv_packages -work fpga_interfaces                                                            
  vlog -sv "$QSYS_SIMDIR/submodules/altera_avalon_clock_source.sv"                           -L altera_common_sv_packages -work fpga_interfaces                                                            
  vlog -sv "$QSYS_SIMDIR/submodules/altera_avalon_reset_source.sv"                           -L altera_common_sv_packages -work fpga_interfaces                                                            
  vlog -sv "$QSYS_SIMDIR/submodules/soc_system_hps_0_fpga_interfaces_f2h_cold_reset_req.sv"  -L altera_common_sv_packages -work fpga_interfaces                                                            
  vlog -sv "$QSYS_SIMDIR/submodules/soc_system_hps_0_fpga_interfaces_f2h_debug_reset_req.sv" -L altera_common_sv_packages -work fpga_interfaces                                                            
  vlog -sv "$QSYS_SIMDIR/submodules/soc_system_hps_0_fpga_interfaces_f2h_warm_reset_req.sv"  -L altera_common_sv_packages -work fpga_interfaces                                                            
  vlog -sv "$QSYS_SIMDIR/submodules/soc_system_hps_0_fpga_interfaces_f2h_stm_hw_events.sv"   -L altera_common_sv_packages -work fpga_interfaces                                                            
  vlog -sv "$QSYS_SIMDIR/submodules/soc_system_hps_0_fpga_interfaces.sv"                     -L altera_common_sv_packages -work fpga_interfaces                                                            
  vlog     "$QSYS_SIMDIR/submodules/altera_reset_controller.v"                                                            -work rst_controller                                                             
  vlog     "$QSYS_SIMDIR/submodules/altera_reset_synchronizer.v"                                                          -work rst_controller                                                             
  vlog -sv "$QSYS_SIMDIR/submodules/soc_system_irq_mapper.sv"                                -L altera_common_sv_packages -work irq_mapper                                                                 
  vlog     "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_1.v"                                                       -work mm_interconnect_1                                                          
  vlog     "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0.v"                                                       -work mm_interconnect_0                                                          
  vlog     "$QSYS_SIMDIR/submodules/altera_avalon_mm_bridge.v"                                                            -work mm_bridge_0                                                                
  vlog     "$QSYS_SIMDIR/submodules/soc_system_sysid_qsys.vo"                                                             -work sysid_qsys                                                                 
  vlog     "$QSYS_SIMDIR/submodules/soc_system_hps_0.v"                                                                   -work hps_0                                                                      
  vlog     "$QSYS_SIMDIR/soc_system.v"                                                                                                                                                                     
}

# ----------------------------------------
# Elaborate top level design
alias elab {
  echo "\[exec\] elab"
  eval vsim -t ps $ELAB_OPTIONS -L work -L work_lib -L altera_common_sv_packages -L border -L crosser -L rsp_xbar_mux -L rsp_xbar_demux -L cmd_xbar_mux -L cmd_xbar_demux -L id_router -L addr_router -L burst_adapter -L limiter -L sysid_qsys_control_slave_translator_avalon_universal_slave_0_agent_rsp_fifo -L sysid_qsys_control_slave_translator_avalon_universal_slave_0_agent -L hps_0_h2f_lw_axi_master_agent -L sysid_qsys_control_slave_translator -L hps_io -L fpga_interfaces -L rst_controller -L irq_mapper -L mm_interconnect_1 -L mm_interconnect_0 -L mm_bridge_0 -L sysid_qsys -L hps_0 -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver $TOP_LEVEL_NAME
}

# ----------------------------------------
# Elaborate the top level design with novopt option
alias elab_debug {
  echo "\[exec\] elab_debug"
  eval vsim -novopt -t ps $ELAB_OPTIONS -L work -L work_lib -L altera_common_sv_packages -L border -L crosser -L rsp_xbar_mux -L rsp_xbar_demux -L cmd_xbar_mux -L cmd_xbar_demux -L id_router -L addr_router -L burst_adapter -L limiter -L sysid_qsys_control_slave_translator_avalon_universal_slave_0_agent_rsp_fifo -L sysid_qsys_control_slave_translator_avalon_universal_slave_0_agent -L hps_0_h2f_lw_axi_master_agent -L sysid_qsys_control_slave_translator -L hps_io -L fpga_interfaces -L rst_controller -L irq_mapper -L mm_interconnect_1 -L mm_interconnect_0 -L mm_bridge_0 -L sysid_qsys -L hps_0 -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver $TOP_LEVEL_NAME
}

# ----------------------------------------
# Compile all the design files and elaborate the top level design
alias ld "
  dev_com
  com
  elab
"

# ----------------------------------------
# Compile all the design files and elaborate the top level design with -novopt
alias ld_debug "
  dev_com
  com
  elab_debug
"

# ----------------------------------------
# Print out user commmand line aliases
alias h {
  echo "List Of Command Line Aliases"
  echo
  echo "file_copy                     -- Copy ROM/RAM files to simulation directory"
  echo
  echo "dev_com                       -- Compile device library files"
  echo
  echo "com                           -- Compile the design files in correct order"
  echo
  echo "elab                          -- Elaborate top level design"
  echo
  echo "elab_debug                    -- Elaborate the top level design with novopt option"
  echo
  echo "ld                            -- Compile all the design files and elaborate the top level design"
  echo
  echo "ld_debug                      -- Compile all the design files and elaborate the top level design with -novopt"
  echo
  echo 
  echo
  echo "List Of Variables"
  echo
  echo "TOP_LEVEL_NAME                -- Top level module name."
  echo
  echo "SYSTEM_INSTANCE_NAME          -- Instantiated system module name inside top level module."
  echo
  echo "QSYS_SIMDIR                   -- Qsys base simulation directory."
  echo
  echo "QUARTUS_INSTALL_DIR           -- Quartus installation directory."
}
file_copy
h
