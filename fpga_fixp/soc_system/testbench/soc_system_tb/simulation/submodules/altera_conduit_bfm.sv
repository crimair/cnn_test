// (C) 2001-2014 Altera Corporation. All rights reserved.
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
// output_name:                                       altera_conduit_bfm
// role:width:direction:                              mem_a:15:input,mem_ba:3:input,mem_ck:1:input,mem_ck_n:1:input,mem_cke:1:input,mem_cs_n:1:input,mem_ras_n:1:input,mem_cas_n:1:input,mem_we_n:1:input,mem_reset_n:1:input,mem_dq:32:bidir,mem_dqs:4:bidir,mem_dqs_n:4:bidir,mem_odt:1:input,mem_dm:4:input,oct_rzqin:1:output
// 0
//-----------------------------------------------------------------------------
`timescale 1 ns / 1 ns

module altera_conduit_bfm
(
   sig_mem_a,
   sig_mem_ba,
   sig_mem_ck,
   sig_mem_ck_n,
   sig_mem_cke,
   sig_mem_cs_n,
   sig_mem_ras_n,
   sig_mem_cas_n,
   sig_mem_we_n,
   sig_mem_reset_n,
   sig_mem_dq,
   sig_mem_dqs,
   sig_mem_dqs_n,
   sig_mem_odt,
   sig_mem_dm,
   sig_oct_rzqin
);

   //--------------------------------------------------------------------------
   // =head1 PINS 
   // =head2 User defined interface
   //--------------------------------------------------------------------------
   input [14 : 0] sig_mem_a;
   input [2 : 0] sig_mem_ba;
   input sig_mem_ck;
   input sig_mem_ck_n;
   input sig_mem_cke;
   input sig_mem_cs_n;
   input sig_mem_ras_n;
   input sig_mem_cas_n;
   input sig_mem_we_n;
   input sig_mem_reset_n;
   inout wire [31 : 0] sig_mem_dq;
   inout wire [3 : 0] sig_mem_dqs;
   inout wire [3 : 0] sig_mem_dqs_n;
   input sig_mem_odt;
   input [3 : 0] sig_mem_dm;
   output sig_oct_rzqin;

   // synthesis translate_off
   import verbosity_pkg::*;
   
   typedef logic [14 : 0] ROLE_mem_a_t;
   typedef logic [2 : 0] ROLE_mem_ba_t;
   typedef logic ROLE_mem_ck_t;
   typedef logic ROLE_mem_ck_n_t;
   typedef logic ROLE_mem_cke_t;
   typedef logic ROLE_mem_cs_n_t;
   typedef logic ROLE_mem_ras_n_t;
   typedef logic ROLE_mem_cas_n_t;
   typedef logic ROLE_mem_we_n_t;
   typedef logic ROLE_mem_reset_n_t;
   typedef logic [31 : 0] ROLE_mem_dq_t;
   typedef logic [3 : 0] ROLE_mem_dqs_t;
   typedef logic [3 : 0] ROLE_mem_dqs_n_t;
   typedef logic ROLE_mem_odt_t;
   typedef logic [3 : 0] ROLE_mem_dm_t;
   typedef logic ROLE_oct_rzqin_t;

   logic [14 : 0] mem_a_in;
   logic [14 : 0] mem_a_local;
   logic [2 : 0] mem_ba_in;
   logic [2 : 0] mem_ba_local;
   logic [0 : 0] mem_ck_in;
   logic [0 : 0] mem_ck_local;
   logic [0 : 0] mem_ck_n_in;
   logic [0 : 0] mem_ck_n_local;
   logic [0 : 0] mem_cke_in;
   logic [0 : 0] mem_cke_local;
   logic [0 : 0] mem_cs_n_in;
   logic [0 : 0] mem_cs_n_local;
   logic [0 : 0] mem_ras_n_in;
   logic [0 : 0] mem_ras_n_local;
   logic [0 : 0] mem_cas_n_in;
   logic [0 : 0] mem_cas_n_local;
   logic [0 : 0] mem_we_n_in;
   logic [0 : 0] mem_we_n_local;
   logic [0 : 0] mem_reset_n_in;
   logic [0 : 0] mem_reset_n_local;
   logic mem_dq_oe;
   logic mem_dq_oe_temp = 0;
   reg [31 : 0] mem_dq_temp;
   reg [31 : 0] mem_dq_out;
   logic [31 : 0] mem_dq_in;
   logic [31 : 0] mem_dq_local;
   logic mem_dqs_oe;
   logic mem_dqs_oe_temp = 0;
   reg [3 : 0] mem_dqs_temp;
   reg [3 : 0] mem_dqs_out;
   logic [3 : 0] mem_dqs_in;
   logic [3 : 0] mem_dqs_local;
   logic mem_dqs_n_oe;
   logic mem_dqs_n_oe_temp = 0;
   reg [3 : 0] mem_dqs_n_temp;
   reg [3 : 0] mem_dqs_n_out;
   logic [3 : 0] mem_dqs_n_in;
   logic [3 : 0] mem_dqs_n_local;
   logic [0 : 0] mem_odt_in;
   logic [0 : 0] mem_odt_local;
   logic [3 : 0] mem_dm_in;
   logic [3 : 0] mem_dm_local;
   reg oct_rzqin_temp;
   reg oct_rzqin_out;

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
   
   event signal_input_mem_a_change;
   event signal_input_mem_ba_change;
   event signal_input_mem_ck_change;
   event signal_input_mem_ck_n_change;
   event signal_input_mem_cke_change;
   event signal_input_mem_cs_n_change;
   event signal_input_mem_ras_n_change;
   event signal_input_mem_cas_n_change;
   event signal_input_mem_we_n_change;
   event signal_input_mem_reset_n_change;
   event signal_input_mem_dq_change;
   event signal_input_mem_dqs_change;
   event signal_input_mem_dqs_n_change;
   event signal_input_mem_odt_change;
   event signal_input_mem_dm_change;
   
   function automatic string get_version();  // public
      // Return BFM version string. For example, version 9.1 sp1 is "9.1sp1" 
      string ret_version = "13.1";
      return ret_version;
   endfunction

   // -------------------------------------------------------
   // mem_a
   // -------------------------------------------------------
   function automatic ROLE_mem_a_t get_mem_a();
   
      // Gets the mem_a input value.
      $sformat(message, "%m: called get_mem_a");
      print(VERBOSITY_DEBUG, message);
      return mem_a_in;
      
   endfunction

   // -------------------------------------------------------
   // mem_ba
   // -------------------------------------------------------
   function automatic ROLE_mem_ba_t get_mem_ba();
   
      // Gets the mem_ba input value.
      $sformat(message, "%m: called get_mem_ba");
      print(VERBOSITY_DEBUG, message);
      return mem_ba_in;
      
   endfunction

   // -------------------------------------------------------
   // mem_ck
   // -------------------------------------------------------
   function automatic ROLE_mem_ck_t get_mem_ck();
   
      // Gets the mem_ck input value.
      $sformat(message, "%m: called get_mem_ck");
      print(VERBOSITY_DEBUG, message);
      return mem_ck_in;
      
   endfunction

   // -------------------------------------------------------
   // mem_ck_n
   // -------------------------------------------------------
   function automatic ROLE_mem_ck_n_t get_mem_ck_n();
   
      // Gets the mem_ck_n input value.
      $sformat(message, "%m: called get_mem_ck_n");
      print(VERBOSITY_DEBUG, message);
      return mem_ck_n_in;
      
   endfunction

   // -------------------------------------------------------
   // mem_cke
   // -------------------------------------------------------
   function automatic ROLE_mem_cke_t get_mem_cke();
   
      // Gets the mem_cke input value.
      $sformat(message, "%m: called get_mem_cke");
      print(VERBOSITY_DEBUG, message);
      return mem_cke_in;
      
   endfunction

   // -------------------------------------------------------
   // mem_cs_n
   // -------------------------------------------------------
   function automatic ROLE_mem_cs_n_t get_mem_cs_n();
   
      // Gets the mem_cs_n input value.
      $sformat(message, "%m: called get_mem_cs_n");
      print(VERBOSITY_DEBUG, message);
      return mem_cs_n_in;
      
   endfunction

   // -------------------------------------------------------
   // mem_ras_n
   // -------------------------------------------------------
   function automatic ROLE_mem_ras_n_t get_mem_ras_n();
   
      // Gets the mem_ras_n input value.
      $sformat(message, "%m: called get_mem_ras_n");
      print(VERBOSITY_DEBUG, message);
      return mem_ras_n_in;
      
   endfunction

   // -------------------------------------------------------
   // mem_cas_n
   // -------------------------------------------------------
   function automatic ROLE_mem_cas_n_t get_mem_cas_n();
   
      // Gets the mem_cas_n input value.
      $sformat(message, "%m: called get_mem_cas_n");
      print(VERBOSITY_DEBUG, message);
      return mem_cas_n_in;
      
   endfunction

   // -------------------------------------------------------
   // mem_we_n
   // -------------------------------------------------------
   function automatic ROLE_mem_we_n_t get_mem_we_n();
   
      // Gets the mem_we_n input value.
      $sformat(message, "%m: called get_mem_we_n");
      print(VERBOSITY_DEBUG, message);
      return mem_we_n_in;
      
   endfunction

   // -------------------------------------------------------
   // mem_reset_n
   // -------------------------------------------------------
   function automatic ROLE_mem_reset_n_t get_mem_reset_n();
   
      // Gets the mem_reset_n input value.
      $sformat(message, "%m: called get_mem_reset_n");
      print(VERBOSITY_DEBUG, message);
      return mem_reset_n_in;
      
   endfunction

   // -------------------------------------------------------
   // mem_dq
   // -------------------------------------------------------
   function automatic ROLE_mem_dq_t get_mem_dq();
   
      // Gets the mem_dq input value.
      $sformat(message, "%m: called get_mem_dq");
      print(VERBOSITY_DEBUG, message);
      return mem_dq_in;
      
   endfunction

   function automatic void set_mem_dq (
      ROLE_mem_dq_t new_value
   );
      // Drive the new value to mem_dq.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      mem_dq_temp = new_value;
   endfunction
   
   function automatic void set_mem_dq_oe (
      bit enable
   );
      // bidir port mem_dq will work as output port when set to 1.
      // bidir port mem_dq will work as input port when set to 0.
      
      $sformat(message, "%m: method called arg0 %0d", enable); 
      print(VERBOSITY_DEBUG, message);
      
      mem_dq_oe_temp = enable;
   endfunction

   // -------------------------------------------------------
   // mem_dqs
   // -------------------------------------------------------
   function automatic ROLE_mem_dqs_t get_mem_dqs();
   
      // Gets the mem_dqs input value.
      $sformat(message, "%m: called get_mem_dqs");
      print(VERBOSITY_DEBUG, message);
      return mem_dqs_in;
      
   endfunction

   function automatic void set_mem_dqs (
      ROLE_mem_dqs_t new_value
   );
      // Drive the new value to mem_dqs.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      mem_dqs_temp = new_value;
   endfunction
   
   function automatic void set_mem_dqs_oe (
      bit enable
   );
      // bidir port mem_dqs will work as output port when set to 1.
      // bidir port mem_dqs will work as input port when set to 0.
      
      $sformat(message, "%m: method called arg0 %0d", enable); 
      print(VERBOSITY_DEBUG, message);
      
      mem_dqs_oe_temp = enable;
   endfunction

   // -------------------------------------------------------
   // mem_dqs_n
   // -------------------------------------------------------
   function automatic ROLE_mem_dqs_n_t get_mem_dqs_n();
   
      // Gets the mem_dqs_n input value.
      $sformat(message, "%m: called get_mem_dqs_n");
      print(VERBOSITY_DEBUG, message);
      return mem_dqs_n_in;
      
   endfunction

   function automatic void set_mem_dqs_n (
      ROLE_mem_dqs_n_t new_value
   );
      // Drive the new value to mem_dqs_n.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      mem_dqs_n_temp = new_value;
   endfunction
   
   function automatic void set_mem_dqs_n_oe (
      bit enable
   );
      // bidir port mem_dqs_n will work as output port when set to 1.
      // bidir port mem_dqs_n will work as input port when set to 0.
      
      $sformat(message, "%m: method called arg0 %0d", enable); 
      print(VERBOSITY_DEBUG, message);
      
      mem_dqs_n_oe_temp = enable;
   endfunction

   // -------------------------------------------------------
   // mem_odt
   // -------------------------------------------------------
   function automatic ROLE_mem_odt_t get_mem_odt();
   
      // Gets the mem_odt input value.
      $sformat(message, "%m: called get_mem_odt");
      print(VERBOSITY_DEBUG, message);
      return mem_odt_in;
      
   endfunction

   // -------------------------------------------------------
   // mem_dm
   // -------------------------------------------------------
   function automatic ROLE_mem_dm_t get_mem_dm();
   
      // Gets the mem_dm input value.
      $sformat(message, "%m: called get_mem_dm");
      print(VERBOSITY_DEBUG, message);
      return mem_dm_in;
      
   endfunction

   // -------------------------------------------------------
   // oct_rzqin
   // -------------------------------------------------------

   function automatic void set_oct_rzqin (
      ROLE_oct_rzqin_t new_value
   );
      // Drive the new value to oct_rzqin.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      oct_rzqin_temp = new_value;
   endfunction

   assign mem_a_in = sig_mem_a;
   assign mem_ba_in = sig_mem_ba;
   assign mem_ck_in = sig_mem_ck;
   assign mem_ck_n_in = sig_mem_ck_n;
   assign mem_cke_in = sig_mem_cke;
   assign mem_cs_n_in = sig_mem_cs_n;
   assign mem_ras_n_in = sig_mem_ras_n;
   assign mem_cas_n_in = sig_mem_cas_n;
   assign mem_we_n_in = sig_mem_we_n;
   assign mem_reset_n_in = sig_mem_reset_n;
   assign mem_dq_oe = mem_dq_oe_temp;
   assign sig_mem_dq = (mem_dq_oe == 1)? mem_dq_temp:'z;
   assign mem_dq_in = (mem_dq_oe == 0)? sig_mem_dq:'z;
   assign mem_dqs_oe = mem_dqs_oe_temp;
   assign sig_mem_dqs = (mem_dqs_oe == 1)? mem_dqs_temp:'z;
   assign mem_dqs_in = (mem_dqs_oe == 0)? sig_mem_dqs:'z;
   assign mem_dqs_n_oe = mem_dqs_n_oe_temp;
   assign sig_mem_dqs_n = (mem_dqs_n_oe == 1)? mem_dqs_n_temp:'z;
   assign mem_dqs_n_in = (mem_dqs_n_oe == 0)? sig_mem_dqs_n:'z;
   assign mem_odt_in = sig_mem_odt;
   assign mem_dm_in = sig_mem_dm;
   assign sig_oct_rzqin = oct_rzqin_temp;


   always @(mem_a_in) begin
      if (mem_a_local != mem_a_in)
         -> signal_input_mem_a_change;
      mem_a_local = mem_a_in;
   end
   
   always @(mem_ba_in) begin
      if (mem_ba_local != mem_ba_in)
         -> signal_input_mem_ba_change;
      mem_ba_local = mem_ba_in;
   end
   
   always @(mem_ck_in) begin
      if (mem_ck_local != mem_ck_in)
         -> signal_input_mem_ck_change;
      mem_ck_local = mem_ck_in;
   end
   
   always @(mem_ck_n_in) begin
      if (mem_ck_n_local != mem_ck_n_in)
         -> signal_input_mem_ck_n_change;
      mem_ck_n_local = mem_ck_n_in;
   end
   
   always @(mem_cke_in) begin
      if (mem_cke_local != mem_cke_in)
         -> signal_input_mem_cke_change;
      mem_cke_local = mem_cke_in;
   end
   
   always @(mem_cs_n_in) begin
      if (mem_cs_n_local != mem_cs_n_in)
         -> signal_input_mem_cs_n_change;
      mem_cs_n_local = mem_cs_n_in;
   end
   
   always @(mem_ras_n_in) begin
      if (mem_ras_n_local != mem_ras_n_in)
         -> signal_input_mem_ras_n_change;
      mem_ras_n_local = mem_ras_n_in;
   end
   
   always @(mem_cas_n_in) begin
      if (mem_cas_n_local != mem_cas_n_in)
         -> signal_input_mem_cas_n_change;
      mem_cas_n_local = mem_cas_n_in;
   end
   
   always @(mem_we_n_in) begin
      if (mem_we_n_local != mem_we_n_in)
         -> signal_input_mem_we_n_change;
      mem_we_n_local = mem_we_n_in;
   end
   
   always @(mem_reset_n_in) begin
      if (mem_reset_n_local != mem_reset_n_in)
         -> signal_input_mem_reset_n_change;
      mem_reset_n_local = mem_reset_n_in;
   end
   
   always @(mem_dq_in) begin
      if (mem_dq_oe == 0) begin
         if (mem_dq_local != mem_dq_in)
            -> signal_input_mem_dq_change;
         mem_dq_local = mem_dq_in;
      end
   end
   
   always @(mem_dqs_in) begin
      if (mem_dqs_oe == 0) begin
         if (mem_dqs_local != mem_dqs_in)
            -> signal_input_mem_dqs_change;
         mem_dqs_local = mem_dqs_in;
      end
   end
   
   always @(mem_dqs_n_in) begin
      if (mem_dqs_n_oe == 0) begin
         if (mem_dqs_n_local != mem_dqs_n_in)
            -> signal_input_mem_dqs_n_change;
         mem_dqs_n_local = mem_dqs_n_in;
      end
   end
   
   always @(mem_odt_in) begin
      if (mem_odt_local != mem_odt_in)
         -> signal_input_mem_odt_change;
      mem_odt_local = mem_odt_in;
   end
   
   always @(mem_dm_in) begin
      if (mem_dm_local != mem_dm_in)
         -> signal_input_mem_dm_change;
      mem_dm_local = mem_dm_in;
   end
   


// synthesis translate_on

endmodule

