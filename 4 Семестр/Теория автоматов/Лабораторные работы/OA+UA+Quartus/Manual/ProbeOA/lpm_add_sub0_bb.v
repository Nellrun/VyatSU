// megafunction wizard: %LPM_ADD_SUB%VBB%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: lpm_add_sub 

// ============================================================
// File Name: lpm_add_sub0.v
// Megafunction Name(s):
// 			lpm_add_sub
//
// Simulation Library Files(s):
// 			lpm
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 9.1 Build 350 03/24/2010 SP 2 SJ Web Edition
// ************************************************************

//Copyright (C) 1991-2010 Altera Corporation
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

module lpm_add_sub0 (
	cin,
	dataa,
	datab,
	result);

	input	  cin;
	input	[15:0]  dataa;
	input	[15:0]  datab;
	output	[15:0]  result;

endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: CarryIn NUMERIC "1"
// Retrieval info: PRIVATE: CarryOut NUMERIC "0"
// Retrieval info: PRIVATE: ConstantA NUMERIC "0"
// Retrieval info: PRIVATE: ConstantB NUMERIC "0"
// Retrieval info: PRIVATE: Function NUMERIC "0"
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone III"
// Retrieval info: PRIVATE: LPM_PIPELINE NUMERIC "0"
// Retrieval info: PRIVATE: Latency NUMERIC "0"
// Retrieval info: PRIVATE: Overflow NUMERIC "0"
// Retrieval info: PRIVATE: RadixA NUMERIC "10"
// Retrieval info: PRIVATE: RadixB NUMERIC "10"
// Retrieval info: PRIVATE: Representation NUMERIC "0"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
// Retrieval info: PRIVATE: ValidCtA NUMERIC "0"
// Retrieval info: PRIVATE: ValidCtB NUMERIC "0"
// Retrieval info: PRIVATE: WhichConstant NUMERIC "0"
// Retrieval info: PRIVATE: aclr NUMERIC "0"
// Retrieval info: PRIVATE: clken NUMERIC "0"
// Retrieval info: PRIVATE: nBit NUMERIC "16"
// Retrieval info: CONSTANT: LPM_DIRECTION STRING "ADD"
// Retrieval info: CONSTANT: LPM_HINT STRING "ONE_INPUT_IS_CONSTANT=NO,CIN_USED=YES"
// Retrieval info: CONSTANT: LPM_REPRESENTATION STRING "SIGNED"
// Retrieval info: CONSTANT: LPM_TYPE STRING "LPM_ADD_SUB"
// Retrieval info: CONSTANT: LPM_WIDTH NUMERIC "16"
// Retrieval info: USED_PORT: cin 0 0 0 0 INPUT NODEFVAL cin
// Retrieval info: USED_PORT: dataa 0 0 16 0 INPUT NODEFVAL dataa[15..0]
// Retrieval info: USED_PORT: datab 0 0 16 0 INPUT NODEFVAL datab[15..0]
// Retrieval info: USED_PORT: result 0 0 16 0 OUTPUT NODEFVAL result[15..0]
// Retrieval info: CONNECT: result 0 0 16 0 @result 0 0 16 0
// Retrieval info: CONNECT: @dataa 0 0 16 0 dataa 0 0 16 0
// Retrieval info: CONNECT: @datab 0 0 16 0 datab 0 0 16 0
// Retrieval info: CONNECT: @cin 0 0 0 0 cin 0 0 0 0
// Retrieval info: LIBRARY: lpm lpm.lpm_components.all
// Retrieval info: GEN_FILE: TYPE_NORMAL lpm_add_sub0.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL lpm_add_sub0.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL lpm_add_sub0.cmp TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL lpm_add_sub0.bsf TRUE FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL lpm_add_sub0_inst.v FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL lpm_add_sub0_bb.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL lpm_add_sub0_waveforms.html TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL lpm_add_sub0_wave*.jpg FALSE
// Retrieval info: LIB_FILE: lpm
