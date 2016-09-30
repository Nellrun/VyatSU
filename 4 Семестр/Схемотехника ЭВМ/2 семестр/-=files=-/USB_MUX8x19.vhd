-- megafunction wizard: %LPM_MUX%
-- GENERATION: STANDARD
-- VERSION: WM1.0
-- MODULE: LPM_MUX 

-- ============================================================
-- File Name: USB_MUX8x19.vhd
-- Megafunction Name(s):
-- 			LPM_MUX
--
-- Simulation Library Files(s):
-- 			lpm
-- ============================================================
-- ************************************************************
-- THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
--
-- 10.1 Build 153 11/29/2010 SJ Web Edition
-- ************************************************************


--Copyright (C) 1991-2010 Altera Corporation
--Your use of Altera Corporation's design tools, logic functions 
--and other software and tools, and its AMPP partner logic 
--functions, and any output files from any of the foregoing 
--(including device programming or simulation files), and any 
--associated documentation or information are expressly subject 
--to the terms and conditions of the Altera Program License 
--Subscription Agreement, Altera MegaCore Function License 
--Agreement, or other applicable license agreement, including, 
--without limitation, that your use is for the sole purpose of 
--programming logic devices manufactured by Altera and sold by 
--Altera or its authorized distributors.  Please refer to the 
--applicable agreement for further details.


LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY lpm;
USE lpm.lpm_components.all;

ENTITY USB_MUX8x19 IS
	PORT
	(
		data0x		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		data10x		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		data11x		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		data12x		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		data13x		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		data14x		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		data15x		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		data16x		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		data17x		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		data18x		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		data19x		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		data1x		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		data20x		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		data21x		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		data22x		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		data23x		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		data24x		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		data25x		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		data26x		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		data27x		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		data2x		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		data3x		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		data4x		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		data5x		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		data6x		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		data7x		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		data8x		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		data9x		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		sel		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		result		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
END USB_MUX8x19;


ARCHITECTURE SYN OF usb_mux8x19 IS

--	type STD_LOGIC_2D is array (NATURAL RANGE <>, NATURAL RANGE <>) of STD_LOGIC;

	SIGNAL sub_wire0	: STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL sub_wire1	: STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL sub_wire2	: STD_LOGIC_2D (27 DOWNTO 0, 7 DOWNTO 0);
	SIGNAL sub_wire3	: STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL sub_wire4	: STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL sub_wire5	: STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL sub_wire6	: STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL sub_wire7	: STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL sub_wire8	: STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL sub_wire9	: STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL sub_wire10	: STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL sub_wire11	: STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL sub_wire12	: STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL sub_wire13	: STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL sub_wire14	: STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL sub_wire15	: STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL sub_wire16	: STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL sub_wire17	: STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL sub_wire18	: STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL sub_wire19	: STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL sub_wire20	: STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL sub_wire21	: STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL sub_wire22	: STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL sub_wire23	: STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL sub_wire24	: STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL sub_wire25	: STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL sub_wire26	: STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL sub_wire27	: STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL sub_wire28	: STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL sub_wire29	: STD_LOGIC_VECTOR (7 DOWNTO 0);

BEGIN
	sub_wire29    <= data0x(7 DOWNTO 0);
	sub_wire28    <= data1x(7 DOWNTO 0);
	sub_wire27    <= data2x(7 DOWNTO 0);
	sub_wire26    <= data3x(7 DOWNTO 0);
	sub_wire25    <= data4x(7 DOWNTO 0);
	sub_wire24    <= data5x(7 DOWNTO 0);
	sub_wire23    <= data6x(7 DOWNTO 0);
	sub_wire22    <= data7x(7 DOWNTO 0);
	sub_wire21    <= data8x(7 DOWNTO 0);
	sub_wire20    <= data9x(7 DOWNTO 0);
	sub_wire19    <= data10x(7 DOWNTO 0);
	sub_wire18    <= data11x(7 DOWNTO 0);
	sub_wire17    <= data12x(7 DOWNTO 0);
	sub_wire16    <= data13x(7 DOWNTO 0);
	sub_wire15    <= data14x(7 DOWNTO 0);
	sub_wire14    <= data15x(7 DOWNTO 0);
	sub_wire13    <= data16x(7 DOWNTO 0);
	sub_wire12    <= data17x(7 DOWNTO 0);
	sub_wire11    <= data18x(7 DOWNTO 0);
	sub_wire10    <= data19x(7 DOWNTO 0);
	sub_wire9    <= data20x(7 DOWNTO 0);
	sub_wire8    <= data21x(7 DOWNTO 0);
	sub_wire7    <= data22x(7 DOWNTO 0);
	sub_wire6    <= data23x(7 DOWNTO 0);
	sub_wire5    <= data24x(7 DOWNTO 0);
	sub_wire4    <= data25x(7 DOWNTO 0);
	sub_wire3    <= data26x(7 DOWNTO 0);
	result    <= sub_wire0(7 DOWNTO 0);
	sub_wire1    <= data27x(7 DOWNTO 0);
	sub_wire2(27, 0)    <= sub_wire1(0);
	sub_wire2(27, 1)    <= sub_wire1(1);
	sub_wire2(27, 2)    <= sub_wire1(2);
	sub_wire2(27, 3)    <= sub_wire1(3);
	sub_wire2(27, 4)    <= sub_wire1(4);
	sub_wire2(27, 5)    <= sub_wire1(5);
	sub_wire2(27, 6)    <= sub_wire1(6);
	sub_wire2(27, 7)    <= sub_wire1(7);
	sub_wire2(26, 0)    <= sub_wire3(0);
	sub_wire2(26, 1)    <= sub_wire3(1);
	sub_wire2(26, 2)    <= sub_wire3(2);
	sub_wire2(26, 3)    <= sub_wire3(3);
	sub_wire2(26, 4)    <= sub_wire3(4);
	sub_wire2(26, 5)    <= sub_wire3(5);
	sub_wire2(26, 6)    <= sub_wire3(6);
	sub_wire2(26, 7)    <= sub_wire3(7);
	sub_wire2(25, 0)    <= sub_wire4(0);
	sub_wire2(25, 1)    <= sub_wire4(1);
	sub_wire2(25, 2)    <= sub_wire4(2);
	sub_wire2(25, 3)    <= sub_wire4(3);
	sub_wire2(25, 4)    <= sub_wire4(4);
	sub_wire2(25, 5)    <= sub_wire4(5);
	sub_wire2(25, 6)    <= sub_wire4(6);
	sub_wire2(25, 7)    <= sub_wire4(7);
	sub_wire2(24, 0)    <= sub_wire5(0);
	sub_wire2(24, 1)    <= sub_wire5(1);
	sub_wire2(24, 2)    <= sub_wire5(2);
	sub_wire2(24, 3)    <= sub_wire5(3);
	sub_wire2(24, 4)    <= sub_wire5(4);
	sub_wire2(24, 5)    <= sub_wire5(5);
	sub_wire2(24, 6)    <= sub_wire5(6);
	sub_wire2(24, 7)    <= sub_wire5(7);
	sub_wire2(23, 0)    <= sub_wire6(0);
	sub_wire2(23, 1)    <= sub_wire6(1);
	sub_wire2(23, 2)    <= sub_wire6(2);
	sub_wire2(23, 3)    <= sub_wire6(3);
	sub_wire2(23, 4)    <= sub_wire6(4);
	sub_wire2(23, 5)    <= sub_wire6(5);
	sub_wire2(23, 6)    <= sub_wire6(6);
	sub_wire2(23, 7)    <= sub_wire6(7);
	sub_wire2(22, 0)    <= sub_wire7(0);
	sub_wire2(22, 1)    <= sub_wire7(1);
	sub_wire2(22, 2)    <= sub_wire7(2);
	sub_wire2(22, 3)    <= sub_wire7(3);
	sub_wire2(22, 4)    <= sub_wire7(4);
	sub_wire2(22, 5)    <= sub_wire7(5);
	sub_wire2(22, 6)    <= sub_wire7(6);
	sub_wire2(22, 7)    <= sub_wire7(7);
	sub_wire2(21, 0)    <= sub_wire8(0);
	sub_wire2(21, 1)    <= sub_wire8(1);
	sub_wire2(21, 2)    <= sub_wire8(2);
	sub_wire2(21, 3)    <= sub_wire8(3);
	sub_wire2(21, 4)    <= sub_wire8(4);
	sub_wire2(21, 5)    <= sub_wire8(5);
	sub_wire2(21, 6)    <= sub_wire8(6);
	sub_wire2(21, 7)    <= sub_wire8(7);
	sub_wire2(20, 0)    <= sub_wire9(0);
	sub_wire2(20, 1)    <= sub_wire9(1);
	sub_wire2(20, 2)    <= sub_wire9(2);
	sub_wire2(20, 3)    <= sub_wire9(3);
	sub_wire2(20, 4)    <= sub_wire9(4);
	sub_wire2(20, 5)    <= sub_wire9(5);
	sub_wire2(20, 6)    <= sub_wire9(6);
	sub_wire2(20, 7)    <= sub_wire9(7);
	sub_wire2(19, 0)    <= sub_wire10(0);
	sub_wire2(19, 1)    <= sub_wire10(1);
	sub_wire2(19, 2)    <= sub_wire10(2);
	sub_wire2(19, 3)    <= sub_wire10(3);
	sub_wire2(19, 4)    <= sub_wire10(4);
	sub_wire2(19, 5)    <= sub_wire10(5);
	sub_wire2(19, 6)    <= sub_wire10(6);
	sub_wire2(19, 7)    <= sub_wire10(7);
	sub_wire2(18, 0)    <= sub_wire11(0);
	sub_wire2(18, 1)    <= sub_wire11(1);
	sub_wire2(18, 2)    <= sub_wire11(2);
	sub_wire2(18, 3)    <= sub_wire11(3);
	sub_wire2(18, 4)    <= sub_wire11(4);
	sub_wire2(18, 5)    <= sub_wire11(5);
	sub_wire2(18, 6)    <= sub_wire11(6);
	sub_wire2(18, 7)    <= sub_wire11(7);
	sub_wire2(17, 0)    <= sub_wire12(0);
	sub_wire2(17, 1)    <= sub_wire12(1);
	sub_wire2(17, 2)    <= sub_wire12(2);
	sub_wire2(17, 3)    <= sub_wire12(3);
	sub_wire2(17, 4)    <= sub_wire12(4);
	sub_wire2(17, 5)    <= sub_wire12(5);
	sub_wire2(17, 6)    <= sub_wire12(6);
	sub_wire2(17, 7)    <= sub_wire12(7);
	sub_wire2(16, 0)    <= sub_wire13(0);
	sub_wire2(16, 1)    <= sub_wire13(1);
	sub_wire2(16, 2)    <= sub_wire13(2);
	sub_wire2(16, 3)    <= sub_wire13(3);
	sub_wire2(16, 4)    <= sub_wire13(4);
	sub_wire2(16, 5)    <= sub_wire13(5);
	sub_wire2(16, 6)    <= sub_wire13(6);
	sub_wire2(16, 7)    <= sub_wire13(7);
	sub_wire2(15, 0)    <= sub_wire14(0);
	sub_wire2(15, 1)    <= sub_wire14(1);
	sub_wire2(15, 2)    <= sub_wire14(2);
	sub_wire2(15, 3)    <= sub_wire14(3);
	sub_wire2(15, 4)    <= sub_wire14(4);
	sub_wire2(15, 5)    <= sub_wire14(5);
	sub_wire2(15, 6)    <= sub_wire14(6);
	sub_wire2(15, 7)    <= sub_wire14(7);
	sub_wire2(14, 0)    <= sub_wire15(0);
	sub_wire2(14, 1)    <= sub_wire15(1);
	sub_wire2(14, 2)    <= sub_wire15(2);
	sub_wire2(14, 3)    <= sub_wire15(3);
	sub_wire2(14, 4)    <= sub_wire15(4);
	sub_wire2(14, 5)    <= sub_wire15(5);
	sub_wire2(14, 6)    <= sub_wire15(6);
	sub_wire2(14, 7)    <= sub_wire15(7);
	sub_wire2(13, 0)    <= sub_wire16(0);
	sub_wire2(13, 1)    <= sub_wire16(1);
	sub_wire2(13, 2)    <= sub_wire16(2);
	sub_wire2(13, 3)    <= sub_wire16(3);
	sub_wire2(13, 4)    <= sub_wire16(4);
	sub_wire2(13, 5)    <= sub_wire16(5);
	sub_wire2(13, 6)    <= sub_wire16(6);
	sub_wire2(13, 7)    <= sub_wire16(7);
	sub_wire2(12, 0)    <= sub_wire17(0);
	sub_wire2(12, 1)    <= sub_wire17(1);
	sub_wire2(12, 2)    <= sub_wire17(2);
	sub_wire2(12, 3)    <= sub_wire17(3);
	sub_wire2(12, 4)    <= sub_wire17(4);
	sub_wire2(12, 5)    <= sub_wire17(5);
	sub_wire2(12, 6)    <= sub_wire17(6);
	sub_wire2(12, 7)    <= sub_wire17(7);
	sub_wire2(11, 0)    <= sub_wire18(0);
	sub_wire2(11, 1)    <= sub_wire18(1);
	sub_wire2(11, 2)    <= sub_wire18(2);
	sub_wire2(11, 3)    <= sub_wire18(3);
	sub_wire2(11, 4)    <= sub_wire18(4);
	sub_wire2(11, 5)    <= sub_wire18(5);
	sub_wire2(11, 6)    <= sub_wire18(6);
	sub_wire2(11, 7)    <= sub_wire18(7);
	sub_wire2(10, 0)    <= sub_wire19(0);
	sub_wire2(10, 1)    <= sub_wire19(1);
	sub_wire2(10, 2)    <= sub_wire19(2);
	sub_wire2(10, 3)    <= sub_wire19(3);
	sub_wire2(10, 4)    <= sub_wire19(4);
	sub_wire2(10, 5)    <= sub_wire19(5);
	sub_wire2(10, 6)    <= sub_wire19(6);
	sub_wire2(10, 7)    <= sub_wire19(7);
	sub_wire2(9, 0)    <= sub_wire20(0);
	sub_wire2(9, 1)    <= sub_wire20(1);
	sub_wire2(9, 2)    <= sub_wire20(2);
	sub_wire2(9, 3)    <= sub_wire20(3);
	sub_wire2(9, 4)    <= sub_wire20(4);
	sub_wire2(9, 5)    <= sub_wire20(5);
	sub_wire2(9, 6)    <= sub_wire20(6);
	sub_wire2(9, 7)    <= sub_wire20(7);
	sub_wire2(8, 0)    <= sub_wire21(0);
	sub_wire2(8, 1)    <= sub_wire21(1);
	sub_wire2(8, 2)    <= sub_wire21(2);
	sub_wire2(8, 3)    <= sub_wire21(3);
	sub_wire2(8, 4)    <= sub_wire21(4);
	sub_wire2(8, 5)    <= sub_wire21(5);
	sub_wire2(8, 6)    <= sub_wire21(6);
	sub_wire2(8, 7)    <= sub_wire21(7);
	sub_wire2(7, 0)    <= sub_wire22(0);
	sub_wire2(7, 1)    <= sub_wire22(1);
	sub_wire2(7, 2)    <= sub_wire22(2);
	sub_wire2(7, 3)    <= sub_wire22(3);
	sub_wire2(7, 4)    <= sub_wire22(4);
	sub_wire2(7, 5)    <= sub_wire22(5);
	sub_wire2(7, 6)    <= sub_wire22(6);
	sub_wire2(7, 7)    <= sub_wire22(7);
	sub_wire2(6, 0)    <= sub_wire23(0);
	sub_wire2(6, 1)    <= sub_wire23(1);
	sub_wire2(6, 2)    <= sub_wire23(2);
	sub_wire2(6, 3)    <= sub_wire23(3);
	sub_wire2(6, 4)    <= sub_wire23(4);
	sub_wire2(6, 5)    <= sub_wire23(5);
	sub_wire2(6, 6)    <= sub_wire23(6);
	sub_wire2(6, 7)    <= sub_wire23(7);
	sub_wire2(5, 0)    <= sub_wire24(0);
	sub_wire2(5, 1)    <= sub_wire24(1);
	sub_wire2(5, 2)    <= sub_wire24(2);
	sub_wire2(5, 3)    <= sub_wire24(3);
	sub_wire2(5, 4)    <= sub_wire24(4);
	sub_wire2(5, 5)    <= sub_wire24(5);
	sub_wire2(5, 6)    <= sub_wire24(6);
	sub_wire2(5, 7)    <= sub_wire24(7);
	sub_wire2(4, 0)    <= sub_wire25(0);
	sub_wire2(4, 1)    <= sub_wire25(1);
	sub_wire2(4, 2)    <= sub_wire25(2);
	sub_wire2(4, 3)    <= sub_wire25(3);
	sub_wire2(4, 4)    <= sub_wire25(4);
	sub_wire2(4, 5)    <= sub_wire25(5);
	sub_wire2(4, 6)    <= sub_wire25(6);
	sub_wire2(4, 7)    <= sub_wire25(7);
	sub_wire2(3, 0)    <= sub_wire26(0);
	sub_wire2(3, 1)    <= sub_wire26(1);
	sub_wire2(3, 2)    <= sub_wire26(2);
	sub_wire2(3, 3)    <= sub_wire26(3);
	sub_wire2(3, 4)    <= sub_wire26(4);
	sub_wire2(3, 5)    <= sub_wire26(5);
	sub_wire2(3, 6)    <= sub_wire26(6);
	sub_wire2(3, 7)    <= sub_wire26(7);
	sub_wire2(2, 0)    <= sub_wire27(0);
	sub_wire2(2, 1)    <= sub_wire27(1);
	sub_wire2(2, 2)    <= sub_wire27(2);
	sub_wire2(2, 3)    <= sub_wire27(3);
	sub_wire2(2, 4)    <= sub_wire27(4);
	sub_wire2(2, 5)    <= sub_wire27(5);
	sub_wire2(2, 6)    <= sub_wire27(6);
	sub_wire2(2, 7)    <= sub_wire27(7);
	sub_wire2(1, 0)    <= sub_wire28(0);
	sub_wire2(1, 1)    <= sub_wire28(1);
	sub_wire2(1, 2)    <= sub_wire28(2);
	sub_wire2(1, 3)    <= sub_wire28(3);
	sub_wire2(1, 4)    <= sub_wire28(4);
	sub_wire2(1, 5)    <= sub_wire28(5);
	sub_wire2(1, 6)    <= sub_wire28(6);
	sub_wire2(1, 7)    <= sub_wire28(7);
	sub_wire2(0, 0)    <= sub_wire29(0);
	sub_wire2(0, 1)    <= sub_wire29(1);
	sub_wire2(0, 2)    <= sub_wire29(2);
	sub_wire2(0, 3)    <= sub_wire29(3);
	sub_wire2(0, 4)    <= sub_wire29(4);
	sub_wire2(0, 5)    <= sub_wire29(5);
	sub_wire2(0, 6)    <= sub_wire29(6);
	sub_wire2(0, 7)    <= sub_wire29(7);

	LPM_MUX_component : LPM_MUX
	GENERIC MAP (
		lpm_size => 28,
		lpm_type => "LPM_MUX",
		lpm_width => 8,
		lpm_widths => 5
	)
	PORT MAP (
		data => sub_wire2,
		sel => sel,
		result => sub_wire0
	);



END SYN;

-- ============================================================
-- CNX file retrieval info
-- ============================================================
-- Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone III"
-- Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
-- Retrieval info: LIBRARY: lpm lpm.lpm_components.all
-- Retrieval info: CONSTANT: LPM_SIZE NUMERIC "28"
-- Retrieval info: CONSTANT: LPM_TYPE STRING "LPM_MUX"
-- Retrieval info: CONSTANT: LPM_WIDTH NUMERIC "8"
-- Retrieval info: CONSTANT: LPM_WIDTHS NUMERIC "5"
-- Retrieval info: USED_PORT: data0x 0 0 8 0 INPUT NODEFVAL "data0x[7..0]"
-- Retrieval info: USED_PORT: data10x 0 0 8 0 INPUT NODEFVAL "data10x[7..0]"
-- Retrieval info: USED_PORT: data11x 0 0 8 0 INPUT NODEFVAL "data11x[7..0]"
-- Retrieval info: USED_PORT: data12x 0 0 8 0 INPUT NODEFVAL "data12x[7..0]"
-- Retrieval info: USED_PORT: data13x 0 0 8 0 INPUT NODEFVAL "data13x[7..0]"
-- Retrieval info: USED_PORT: data14x 0 0 8 0 INPUT NODEFVAL "data14x[7..0]"
-- Retrieval info: USED_PORT: data15x 0 0 8 0 INPUT NODEFVAL "data15x[7..0]"
-- Retrieval info: USED_PORT: data16x 0 0 8 0 INPUT NODEFVAL "data16x[7..0]"
-- Retrieval info: USED_PORT: data17x 0 0 8 0 INPUT NODEFVAL "data17x[7..0]"
-- Retrieval info: USED_PORT: data18x 0 0 8 0 INPUT NODEFVAL "data18x[7..0]"
-- Retrieval info: USED_PORT: data19x 0 0 8 0 INPUT NODEFVAL "data19x[7..0]"
-- Retrieval info: USED_PORT: data1x 0 0 8 0 INPUT NODEFVAL "data1x[7..0]"
-- Retrieval info: USED_PORT: data20x 0 0 8 0 INPUT NODEFVAL "data20x[7..0]"
-- Retrieval info: USED_PORT: data21x 0 0 8 0 INPUT NODEFVAL "data21x[7..0]"
-- Retrieval info: USED_PORT: data22x 0 0 8 0 INPUT NODEFVAL "data22x[7..0]"
-- Retrieval info: USED_PORT: data23x 0 0 8 0 INPUT NODEFVAL "data23x[7..0]"
-- Retrieval info: USED_PORT: data24x 0 0 8 0 INPUT NODEFVAL "data24x[7..0]"
-- Retrieval info: USED_PORT: data25x 0 0 8 0 INPUT NODEFVAL "data25x[7..0]"
-- Retrieval info: USED_PORT: data26x 0 0 8 0 INPUT NODEFVAL "data26x[7..0]"
-- Retrieval info: USED_PORT: data27x 0 0 8 0 INPUT NODEFVAL "data27x[7..0]"
-- Retrieval info: USED_PORT: data2x 0 0 8 0 INPUT NODEFVAL "data2x[7..0]"
-- Retrieval info: USED_PORT: data3x 0 0 8 0 INPUT NODEFVAL "data3x[7..0]"
-- Retrieval info: USED_PORT: data4x 0 0 8 0 INPUT NODEFVAL "data4x[7..0]"
-- Retrieval info: USED_PORT: data5x 0 0 8 0 INPUT NODEFVAL "data5x[7..0]"
-- Retrieval info: USED_PORT: data6x 0 0 8 0 INPUT NODEFVAL "data6x[7..0]"
-- Retrieval info: USED_PORT: data7x 0 0 8 0 INPUT NODEFVAL "data7x[7..0]"
-- Retrieval info: USED_PORT: data8x 0 0 8 0 INPUT NODEFVAL "data8x[7..0]"
-- Retrieval info: USED_PORT: data9x 0 0 8 0 INPUT NODEFVAL "data9x[7..0]"
-- Retrieval info: USED_PORT: result 0 0 8 0 OUTPUT NODEFVAL "result[7..0]"
-- Retrieval info: USED_PORT: sel 0 0 5 0 INPUT NODEFVAL "sel[4..0]"
-- Retrieval info: CONNECT: @data 1 0 8 0 data0x 0 0 8 0
-- Retrieval info: CONNECT: @data 1 10 8 0 data10x 0 0 8 0
-- Retrieval info: CONNECT: @data 1 11 8 0 data11x 0 0 8 0
-- Retrieval info: CONNECT: @data 1 12 8 0 data12x 0 0 8 0
-- Retrieval info: CONNECT: @data 1 13 8 0 data13x 0 0 8 0
-- Retrieval info: CONNECT: @data 1 14 8 0 data14x 0 0 8 0
-- Retrieval info: CONNECT: @data 1 15 8 0 data15x 0 0 8 0
-- Retrieval info: CONNECT: @data 1 16 8 0 data16x 0 0 8 0
-- Retrieval info: CONNECT: @data 1 17 8 0 data17x 0 0 8 0
-- Retrieval info: CONNECT: @data 1 18 8 0 data18x 0 0 8 0
-- Retrieval info: CONNECT: @data 1 19 8 0 data19x 0 0 8 0
-- Retrieval info: CONNECT: @data 1 1 8 0 data1x 0 0 8 0
-- Retrieval info: CONNECT: @data 1 20 8 0 data20x 0 0 8 0
-- Retrieval info: CONNECT: @data 1 21 8 0 data21x 0 0 8 0
-- Retrieval info: CONNECT: @data 1 22 8 0 data22x 0 0 8 0
-- Retrieval info: CONNECT: @data 1 23 8 0 data23x 0 0 8 0
-- Retrieval info: CONNECT: @data 1 24 8 0 data24x 0 0 8 0
-- Retrieval info: CONNECT: @data 1 25 8 0 data25x 0 0 8 0
-- Retrieval info: CONNECT: @data 1 26 8 0 data26x 0 0 8 0
-- Retrieval info: CONNECT: @data 1 27 8 0 data27x 0 0 8 0
-- Retrieval info: CONNECT: @data 1 2 8 0 data2x 0 0 8 0
-- Retrieval info: CONNECT: @data 1 3 8 0 data3x 0 0 8 0
-- Retrieval info: CONNECT: @data 1 4 8 0 data4x 0 0 8 0
-- Retrieval info: CONNECT: @data 1 5 8 0 data5x 0 0 8 0
-- Retrieval info: CONNECT: @data 1 6 8 0 data6x 0 0 8 0
-- Retrieval info: CONNECT: @data 1 7 8 0 data7x 0 0 8 0
-- Retrieval info: CONNECT: @data 1 8 8 0 data8x 0 0 8 0
-- Retrieval info: CONNECT: @data 1 9 8 0 data9x 0 0 8 0
-- Retrieval info: CONNECT: @sel 0 0 5 0 sel 0 0 5 0
-- Retrieval info: CONNECT: result 0 0 8 0 @result 0 0 8 0
-- Retrieval info: GEN_FILE: TYPE_NORMAL USB_MUX8x19.vhd TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL USB_MUX8x19.inc FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL USB_MUX8x19.cmp TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL USB_MUX8x19.bsf TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL USB_MUX8x19_inst.vhd FALSE
-- Retrieval info: LIB_FILE: lpm
