// megafunction wizard: %ALTFP_ADD_SUB%VBB%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: altfp_add_sub 

// ============================================================
// File Name: fp_add_32x32.v
// Megafunction Name(s):
// 			altfp_add_sub
//
// Simulation Library Files(s):
// 			lpm
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 13.1.4 Build 182 03/12/2014 SJ Full Version
// ************************************************************

//Copyright (C) 1991-2014 Altera Corporation
//Your use of Altera Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Altera Program License 
//Subscription Agreement, Altera MegaCore Function License 
//Agreement, or other applicable license agreement, including, 
//without limitation, that your use is for the sole purpose of 
//programming logic devices manufactured by Altera and sold by 
//Altera or its authorized distributors.  Please refer to the 
//applicable agreement for further details.

module fp_add_32x32 (
	clock,
	dataa,
	datab,
	result)/* synthesis synthesis_clearbox = 1 */;

	input	  clock;
	input	[31:0]  dataa;
	input	[31:0]  datab;
	output	[31:0]  result;

endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: FPM_FORMAT NUMERIC "0"
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone IV GX"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
// Retrieval info: PRIVATE: WIDTH_DATA NUMERIC "32"
// Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
// Retrieval info: CONSTANT: DENORMAL_SUPPORT STRING "NO"
// Retrieval info: CONSTANT: DIRECTION STRING "ADD"
// Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "Cyclone IV GX"
// Retrieval info: CONSTANT: OPTIMIZE STRING "SPEED"
// Retrieval info: CONSTANT: PIPELINE NUMERIC "13"
// Retrieval info: CONSTANT: REDUCED_FUNCTIONALITY STRING "NO"
// Retrieval info: CONSTANT: WIDTH_EXP NUMERIC "8"
// Retrieval info: CONSTANT: WIDTH_MAN NUMERIC "23"
// Retrieval info: USED_PORT: clock 0 0 0 0 INPUT NODEFVAL "clock"
// Retrieval info: USED_PORT: dataa 0 0 32 0 INPUT NODEFVAL "dataa[31..0]"
// Retrieval info: USED_PORT: datab 0 0 32 0 INPUT NODEFVAL "datab[31..0]"
// Retrieval info: USED_PORT: result 0 0 32 0 OUTPUT NODEFVAL "result[31..0]"
// Retrieval info: CONNECT: @clock 0 0 0 0 clock 0 0 0 0
// Retrieval info: CONNECT: @dataa 0 0 32 0 dataa 0 0 32 0
// Retrieval info: CONNECT: @datab 0 0 32 0 datab 0 0 32 0
// Retrieval info: CONNECT: result 0 0 32 0 @result 0 0 32 0
// Retrieval info: GEN_FILE: TYPE_NORMAL fp_add_32x32.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL fp_add_32x32.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL fp_add_32x32.cmp FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL fp_add_32x32.bsf FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL fp_add_32x32_inst.v FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL fp_add_32x32_bb.v TRUE
// Retrieval info: LIB_FILE: lpm
