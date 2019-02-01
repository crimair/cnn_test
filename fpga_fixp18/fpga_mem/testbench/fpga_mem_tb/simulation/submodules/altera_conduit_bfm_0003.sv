// (C) 2001-2013 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// $Id: //acds/main/ip/sopc/components/verification/altera_tristate_conduit_bfm/altera_tristate_conduit_bfm.sv.terp#7 $
// $Revision: #7 $
// $Date: 2010/08/05 $
// $Author: klong $
//-----------------------------------------------------------------------------
// =head1 NAME
// altera_conduit_bfm
// =head1 SYNOPSIS
// Bus Functional Model (BFM) for a Standard Conduit BFM
//-----------------------------------------------------------------------------
// =head1 DESCRIPTION
// This is a Bus Functional Model (BFM) for a Standard Conduit Master.
// This BFM sampled the input/bidirection port value or driving user's value to 
// output ports when user call the API.  
// This BFM's HDL is been generated through terp file in Qsys/SOPC Builder.
// Generation parameters:
// output_name:                                       altera_conduit_bfm_0003
// role:width:direction:                              pll_mem_clk:1:input,pll_write_clk:1:input,pll_locked:1:input,pll_write_clk_pre_phy_clk:1:input,pll_addr_cmd_clk:1:input,pll_avl_clk:1:input,pll_config_clk:1:input,pll_dr_clk:1:input,pll_dr_clk_pre_phy_clk:1:input,pll_mem_phy_clk:1:input,afi_phy_clk:1:input,pll_avl_phy_clk:1:input
// 0
//-----------------------------------------------------------------------------
`timescale 1 ns / 1 ns

module altera_conduit_bfm_0003
(
   sig_pll_mem_clk,
   sig_pll_write_clk,
   sig_pll_locked,
   sig_pll_write_clk_pre_phy_clk,
   sig_pll_addr_cmd_clk,
   sig_pll_avl_clk,
   sig_pll_config_clk,
   sig_pll_dr_clk,
   sig_pll_dr_clk_pre_phy_clk,
   sig_pll_mem_phy_clk,
   sig_afi_phy_clk,
   sig_pll_avl_phy_clk
);

   //--------------------------------------------------------------------------
   // =head1 PINS 
   // =head2 User defined interface
   //--------------------------------------------------------------------------
   input sig_pll_mem_clk;
   input sig_pll_write_clk;
   input sig_pll_locked;
   input sig_pll_write_clk_pre_phy_clk;
   input sig_pll_addr_cmd_clk;
   input sig_pll_avl_clk;
   input sig_pll_config_clk;
   input sig_pll_dr_clk;
   input sig_pll_dr_clk_pre_phy_clk;
   input sig_pll_mem_phy_clk;
   input sig_afi_phy_clk;
   input sig_pll_avl_phy_clk;

   // synthesis translate_off
   import verbosity_pkg::*;
   
   typedef logic ROLE_pll_mem_clk_t;
   typedef logic ROLE_pll_write_clk_t;
   typedef logic ROLE_pll_locked_t;
   typedef logic ROLE_pll_write_clk_pre_phy_clk_t;
   typedef logic ROLE_pll_addr_cmd_clk_t;
   typedef logic ROLE_pll_avl_clk_t;
   typedef logic ROLE_pll_config_clk_t;
   typedef logic ROLE_pll_dr_clk_t;
   typedef logic ROLE_pll_dr_clk_pre_phy_clk_t;
   typedef logic ROLE_pll_mem_phy_clk_t;
   typedef logic ROLE_afi_phy_clk_t;
   typedef logic ROLE_pll_avl_phy_clk_t;

   logic [0 : 0] pll_mem_clk_in;
   logic [0 : 0] pll_mem_clk_local;
   logic [0 : 0] pll_write_clk_in;
   logic [0 : 0] pll_write_clk_local;
   logic [0 : 0] pll_locked_in;
   logic [0 : 0] pll_locked_local;
   logic [0 : 0] pll_write_clk_pre_phy_clk_in;
   logic [0 : 0] pll_write_clk_pre_phy_clk_local;
   logic [0 : 0] pll_addr_cmd_clk_in;
   logic [0 : 0] pll_addr_cmd_clk_local;
   logic [0 : 0] pll_avl_clk_in;
   logic [0 : 0] pll_avl_clk_local;
   logic [0 : 0] pll_config_clk_in;
   logic [0 : 0] pll_config_clk_local;
   logic [0 : 0] pll_dr_clk_in;
   logic [0 : 0] pll_dr_clk_local;
   logic [0 : 0] pll_dr_clk_pre_phy_clk_in;
   logic [0 : 0] pll_dr_clk_pre_phy_clk_local;
   logic [0 : 0] pll_mem_phy_clk_in;
   logic [0 : 0] pll_mem_phy_clk_local;
   logic [0 : 0] afi_phy_clk_in;
   logic [0 : 0] afi_phy_clk_local;
   logic [0 : 0] pll_avl_phy_clk_in;
   logic [0 : 0] pll_avl_phy_clk_local;

   //--------------------------------------------------------------------------
   // =head1 Public Methods API
   // =pod
   // This section describes the public methods in the application programming
   // interface (API). The application program interface provides methods for 
   // a testbench which instantiates, controls and queries state in this BFM 
   // component. Test programs must only use these public access methods and 
   // events to communicate with this BFM component. The API and module pins
   // are the only interfaces of this component that are guaranteed to be
   // stable. The API will be maintained for the life of the product. 
   // While we cannot prevent a test program from directly accessing internal
   // tasks, functions, or data private to the BFM, there is no guarantee that
   // these will be present in the future. In fact, it is best for the user
   // to assume that the underlying implementation of this component can 
   // and will change.
   // =cut
   //--------------------------------------------------------------------------
   
   event signal_input_pll_mem_clk_change;
   event signal_input_pll_write_clk_change;
   event signal_input_pll_locked_change;
   event signal_input_pll_write_clk_pre_phy_clk_change;
   event signal_input_pll_addr_cmd_clk_change;
   event signal_input_pll_avl_clk_change;
   event signal_input_pll_config_clk_change;
   event signal_input_pll_dr_clk_change;
   event signal_input_pll_dr_clk_pre_phy_clk_change;
   event signal_input_pll_mem_phy_clk_change;
   event signal_input_afi_phy_clk_change;
   event signal_input_pll_avl_phy_clk_change;
   
   function automatic string get_version();  // public
      // Return BFM version string. For example, version 9.1 sp1 is "9.1sp1" 
      string ret_version = "13.1";
      return ret_version;
   endfunction

   // -------------------------------------------------------
   // pll_mem_clk
   // -------------------------------------------------------
   function automatic ROLE_pll_mem_clk_t get_pll_mem_clk();
   
      // Gets the pll_mem_clk input value.
      $sformat(message, "%m: called get_pll_mem_clk");
      print(VERBOSITY_DEBUG, message);
      return pll_mem_clk_in;
      
   endfunction

   // -------------------------------------------------------
   // pll_write_clk
   // -------------------------------------------------------
   function automatic ROLE_pll_write_clk_t get_pll_write_clk();
   
      // Gets the pll_write_clk input value.
      $sformat(message, "%m: called get_pll_write_clk");
      print(VERBOSITY_DEBUG, message);
      return pll_write_clk_in;
      
   endfunction

   // -------------------------------------------------------
   // pll_locked
   // -------------------------------------------------------
   function automatic ROLE_pll_locked_t get_pll_locked();
   
      // Gets the pll_locked input value.
      $sformat(message, "%m: called get_pll_locked");
      print(VERBOSITY_DEBUG, message);
      return pll_locked_in;
      
   endfunction

   // -------------------------------------------------------
   // pll_write_clk_pre_phy_clk
   // -------------------------------------------------------
   function automatic ROLE_pll_write_clk_pre_phy_clk_t get_pll_write_clk_pre_phy_clk();
   
      // Gets the pll_write_clk_pre_phy_clk input value.
      $sformat(message, "%m: called get_pll_write_clk_pre_phy_clk");
      print(VERBOSITY_DEBUG, message);
      return pll_write_clk_pre_phy_clk_in;
      
   endfunction

   // -------------------------------------------------------
   // pll_addr_cmd_clk
   // -------------------------------------------------------
   function automatic ROLE_pll_addr_cmd_clk_t get_pll_addr_cmd_clk();
   
      // Gets the pll_addr_cmd_clk input value.
      $sformat(message, "%m: called get_pll_addr_cmd_clk");
      print(VERBOSITY_DEBUG, message);
      return pll_addr_cmd_clk_in;
      
   endfunction

   // -------------------------------------------------------
   // pll_avl_clk
   // -------------------------------------------------------
   function automatic ROLE_pll_avl_clk_t get_pll_avl_clk();
   
      // Gets the pll_avl_clk input value.
      $sformat(message, "%m: called get_pll_avl_clk");
      print(VERBOSITY_DEBUG, message);
      return pll_avl_clk_in;
      
   endfunction

   // -------------------------------------------------------
   // pll_config_clk
   // -------------------------------------------------------
   function automatic ROLE_pll_config_clk_t get_pll_config_clk();
   
      // Gets the pll_config_clk input value.
      $sformat(message, "%m: called get_pll_config_clk");
      print(VERBOSITY_DEBUG, message);
      return pll_config_clk_in;
      
   endfunction

   // -------------------------------------------------------
   // pll_dr_clk
   // -------------------------------------------------------
   function automatic ROLE_pll_dr_clk_t get_pll_dr_clk();
   
      // Gets the pll_dr_clk input value.
      $sformat(message, "%m: called get_pll_dr_clk");
      print(VERBOSITY_DEBUG, message);
      return pll_dr_clk_in;
      
   endfunction

   // -------------------------------------------------------
   // pll_dr_clk_pre_phy_clk
   // -------------------------------------------------------
   function automatic ROLE_pll_dr_clk_pre_phy_clk_t get_pll_dr_clk_pre_phy_clk();
   
      // Gets the pll_dr_clk_pre_phy_clk input value.
      $sformat(message, "%m: called get_pll_dr_clk_pre_phy_clk");
      print(VERBOSITY_DEBUG, message);
      return pll_dr_clk_pre_phy_clk_in;
      
   endfunction

   // -------------------------------------------------------
   // pll_mem_phy_clk
   // -------------------------------------------------------
   function automatic ROLE_pll_mem_phy_clk_t get_pll_mem_phy_clk();
   
      // Gets the pll_mem_phy_clk input value.
      $sformat(message, "%m: called get_pll_mem_phy_clk");
      print(VERBOSITY_DEBUG, message);
      return pll_mem_phy_clk_in;
      
   endfunction

   // -------------------------------------------------------
   // afi_phy_clk
   // -------------------------------------------------------
   function automatic ROLE_afi_phy_clk_t get_afi_phy_clk();
   
      // Gets the afi_phy_clk input value.
      $sformat(message, "%m: called get_afi_phy_clk");
      print(VERBOSITY_DEBUG, message);
      return afi_phy_clk_in;
      
   endfunction

   // -------------------------------------------------------
   // pll_avl_phy_clk
   // -------------------------------------------------------
   function automatic ROLE_pll_avl_phy_clk_t get_pll_avl_phy_clk();
   
      // Gets the pll_avl_phy_clk input value.
      $sformat(message, "%m: called get_pll_avl_phy_clk");
      print(VERBOSITY_DEBUG, message);
      return pll_avl_phy_clk_in;
      
   endfunction

   assign pll_mem_clk_in = sig_pll_mem_clk;
   assign pll_write_clk_in = sig_pll_write_clk;
   assign pll_locked_in = sig_pll_locked;
   assign pll_write_clk_pre_phy_clk_in = sig_pll_write_clk_pre_phy_clk;
   assign pll_addr_cmd_clk_in = sig_pll_addr_cmd_clk;
   assign pll_avl_clk_in = sig_pll_avl_clk;
   assign pll_config_clk_in = sig_pll_config_clk;
   assign pll_dr_clk_in = sig_pll_dr_clk;
   assign pll_dr_clk_pre_phy_clk_in = sig_pll_dr_clk_pre_phy_clk;
   assign pll_mem_phy_clk_in = sig_pll_mem_phy_clk;
   assign afi_phy_clk_in = sig_afi_phy_clk;
   assign pll_avl_phy_clk_in = sig_pll_avl_phy_clk;


   always @(pll_mem_clk_in) begin
      if (pll_mem_clk_local != pll_mem_clk_in)
         -> signal_input_pll_mem_clk_change;
      pll_mem_clk_local = pll_mem_clk_in;
   end
   
   always @(pll_write_clk_in) begin
      if (pll_write_clk_local != pll_write_clk_in)
         -> signal_input_pll_write_clk_change;
      pll_write_clk_local = pll_write_clk_in;
   end
   
   always @(pll_locked_in) begin
      if (pll_locked_local != pll_locked_in)
         -> signal_input_pll_locked_change;
      pll_locked_local = pll_locked_in;
   end
   
   always @(pll_write_clk_pre_phy_clk_in) begin
      if (pll_write_clk_pre_phy_clk_local != pll_write_clk_pre_phy_clk_in)
         -> signal_input_pll_write_clk_pre_phy_clk_change;
      pll_write_clk_pre_phy_clk_local = pll_write_clk_pre_phy_clk_in;
   end
   
   always @(pll_addr_cmd_clk_in) begin
      if (pll_addr_cmd_clk_local != pll_addr_cmd_clk_in)
         -> signal_input_pll_addr_cmd_clk_change;
      pll_addr_cmd_clk_local = pll_addr_cmd_clk_in;
   end
   
   always @(pll_avl_clk_in) begin
      if (pll_avl_clk_local != pll_avl_clk_in)
         -> signal_input_pll_avl_clk_change;
      pll_avl_clk_local = pll_avl_clk_in;
   end
   
   always @(pll_config_clk_in) begin
      if (pll_config_clk_local != pll_config_clk_in)
         -> signal_input_pll_config_clk_change;
      pll_config_clk_local = pll_config_clk_in;
   end
   
   always @(pll_dr_clk_in) begin
      if (pll_dr_clk_local != pll_dr_clk_in)
         -> signal_input_pll_dr_clk_change;
      pll_dr_clk_local = pll_dr_clk_in;
   end
   
   always @(pll_dr_clk_pre_phy_clk_in) begin
      if (pll_dr_clk_pre_phy_clk_local != pll_dr_clk_pre_phy_clk_in)
         -> signal_input_pll_dr_clk_pre_phy_clk_change;
      pll_dr_clk_pre_phy_clk_local = pll_dr_clk_pre_phy_clk_in;
   end
   
   always @(pll_mem_phy_clk_in) begin
      if (pll_mem_phy_clk_local != pll_mem_phy_clk_in)
         -> signal_input_pll_mem_phy_clk_change;
      pll_mem_phy_clk_local = pll_mem_phy_clk_in;
   end
   
   always @(afi_phy_clk_in) begin
      if (afi_phy_clk_local != afi_phy_clk_in)
         -> signal_input_afi_phy_clk_change;
      afi_phy_clk_local = afi_phy_clk_in;
   end
   
   always @(pll_avl_phy_clk_in) begin
      if (pll_avl_phy_clk_local != pll_avl_phy_clk_in)
         -> signal_input_pll_avl_phy_clk_change;
      pll_avl_phy_clk_local = pll_avl_phy_clk_in;
   end
   


// synthesis translate_on

endmodule

