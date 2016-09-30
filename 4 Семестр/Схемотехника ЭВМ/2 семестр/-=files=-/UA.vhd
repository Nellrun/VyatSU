-- Copyright (C) 1991-2010 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- PROGRAM		"Quartus II"
-- VERSION		"Version 10.1 Build 153 11/29/2010 SJ Web Edition"
-- CREATED		"Thu Aug 25 20:33:26 2011"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY UA IS 
	PORT
	(
		X :  IN  STD_LOGIC;
		Z :  IN  STD_LOGIC;
		Reset :  IN  STD_LOGIC;
		Clk :  IN  STD_LOGIC;
		Clk_25MHz :  IN  STD_LOGIC;
		P :  IN  STD_LOGIC_VECTOR(63 DOWNTO 0);
		Adr :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0);
		Y :  OUT  STD_LOGIC_VECTOR(63 DOWNTO 0)
	);
END UA;

ARCHITECTURE bdf_type OF UA IS 

COMPONENT pzumpr
	PORT(clock : IN STD_LOGIC;
		 address : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(81 DOWNTO 0)
	);
END COMPONENT;

COMPONENT ua_ct10
	PORT(clock : IN STD_LOGIC;
		 sload : IN STD_LOGIC;
		 aclr : IN STD_LOGIC;
		 data : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
	);
END COMPONENT;

COMPONENT ua_ms67x1
	PORT(data0 : IN STD_LOGIC;
		 data1 : IN STD_LOGIC;
		 data2 : IN STD_LOGIC;
		 data3 : IN STD_LOGIC;
		 data4 : IN STD_LOGIC;
		 data5 : IN STD_LOGIC;
		 data10 : IN STD_LOGIC;
		 data11 : IN STD_LOGIC;
		 data12 : IN STD_LOGIC;
		 data13 : IN STD_LOGIC;
		 data14 : IN STD_LOGIC;
		 data15 : IN STD_LOGIC;
		 data16 : IN STD_LOGIC;
		 data17 : IN STD_LOGIC;
		 data18 : IN STD_LOGIC;
		 data19 : IN STD_LOGIC;
		 data20 : IN STD_LOGIC;
		 data21 : IN STD_LOGIC;
		 data22 : IN STD_LOGIC;
		 data23 : IN STD_LOGIC;
		 data24 : IN STD_LOGIC;
		 data25 : IN STD_LOGIC;
		 data26 : IN STD_LOGIC;
		 data27 : IN STD_LOGIC;
		 data28 : IN STD_LOGIC;
		 data29 : IN STD_LOGIC;
		 data30 : IN STD_LOGIC;
		 data31 : IN STD_LOGIC;
		 data32 : IN STD_LOGIC;
		 data33 : IN STD_LOGIC;
		 data34 : IN STD_LOGIC;
		 data35 : IN STD_LOGIC;
		 data36 : IN STD_LOGIC;
		 data37 : IN STD_LOGIC;
		 data38 : IN STD_LOGIC;
		 data39 : IN STD_LOGIC;
		 data40 : IN STD_LOGIC;
		 data41 : IN STD_LOGIC;
		 data42 : IN STD_LOGIC;
		 data43 : IN STD_LOGIC;
		 data44 : IN STD_LOGIC;
		 data45 : IN STD_LOGIC;
		 data46 : IN STD_LOGIC;
		 data47 : IN STD_LOGIC;
		 data48 : IN STD_LOGIC;
		 data49 : IN STD_LOGIC;
		 data50 : IN STD_LOGIC;
		 data51 : IN STD_LOGIC;
		 data52 : IN STD_LOGIC;
		 data53 : IN STD_LOGIC;
		 data54 : IN STD_LOGIC;
		 data55 : IN STD_LOGIC;
		 data56 : IN STD_LOGIC;
		 data57 : IN STD_LOGIC;
		 data58 : IN STD_LOGIC;
		 data59 : IN STD_LOGIC;
		 data6 : IN STD_LOGIC;
		 data60 : IN STD_LOGIC;
		 data61 : IN STD_LOGIC;
		 data62 : IN STD_LOGIC;
		 data63 : IN STD_LOGIC;
		 data64 : IN STD_LOGIC;
		 data65 : IN STD_LOGIC;
		 data66 : IN STD_LOGIC;
		 data7 : IN STD_LOGIC;
		 data8 : IN STD_LOGIC;
		 data9 : IN STD_LOGIC;
		 sel : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
		 result : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT ua_ct4
	PORT(clock : IN STD_LOGIC;
		 cnt_en : IN STD_LOGIC;
		 sclr : IN STD_LOGIC;
		 q : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	ct4q :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	DOPZU :  STD_LOGIC_VECTOR(81 DOWNTO 0);
SIGNAL	S1 :  STD_LOGIC;
SIGNAL	S2 :  STD_LOGIC;
SIGNAL	S2_1 :  STD_LOGIC;
SIGNAL	Y_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_11 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_6 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_7 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_12 :  STD_LOGIC;
SIGNAL	DFF_inst4 :  STD_LOGIC;
SIGNAL	DFF_inst5 :  STD_LOGIC;


BEGIN 
Adr <= SYNTHESIZED_WIRE_0;
SYNTHESIZED_WIRE_4 <= '0';



b2v_inst : pzumpr
PORT MAP(clock => S2_1,
		 address => SYNTHESIZED_WIRE_0,
		 q => DOPZU);


b2v_inst1 : ua_ct10
PORT MAP(clock => S1,
		 sload => SYNTHESIZED_WIRE_1,
		 aclr => Reset,
		 data => DOPZU(81 DOWNTO 72),
		 q => SYNTHESIZED_WIRE_0);


SYNTHESIZED_WIRE_7 <= SYNTHESIZED_WIRE_11 OR SYNTHESIZED_WIRE_2;


PROCESS(Clk_25MHz)
BEGIN
IF (RISING_EDGE(Clk_25MHz)) THEN
	S2 <= SYNTHESIZED_WIRE_11;
END IF;
END PROCESS;


SYNTHESIZED_WIRE_1 <= DOPZU(7) XOR SYNTHESIZED_WIRE_3;


b2v_inst13 : ua_ms67x1
PORT MAP(data0 => P(0),
		 data1 => P(1),
		 data2 => P(2),
		 data3 => P(3),
		 data4 => P(4),
		 data5 => P(5),
		 data10 => P(10),
		 data11 => P(11),
		 data12 => P(12),
		 data13 => P(13),
		 data14 => P(14),
		 data15 => P(15),
		 data16 => P(16),
		 data17 => P(17),
		 data18 => P(18),
		 data19 => P(19),
		 data20 => P(20),
		 data21 => P(21),
		 data22 => P(22),
		 data23 => P(23),
		 data24 => P(24),
		 data25 => P(25),
		 data26 => P(26),
		 data27 => P(27),
		 data28 => P(28),
		 data29 => P(29),
		 data30 => P(30),
		 data31 => P(31),
		 data32 => P(32),
		 data33 => P(33),
		 data34 => P(34),
		 data35 => P(35),
		 data36 => P(36),
		 data37 => P(37),
		 data38 => P(38),
		 data39 => P(39),
		 data40 => P(40),
		 data41 => P(41),
		 data42 => P(42),
		 data43 => P(43),
		 data44 => P(44),
		 data45 => P(45),
		 data46 => P(46),
		 data47 => P(47),
		 data48 => P(48),
		 data49 => P(49),
		 data50 => P(50),
		 data51 => P(51),
		 data52 => P(52),
		 data53 => P(53),
		 data54 => P(54),
		 data55 => P(55),
		 data56 => P(56),
		 data57 => P(57),
		 data58 => P(58),
		 data59 => P(59),
		 data6 => P(6),
		 data60 => P(60),
		 data61 => P(61),
		 data62 => P(62),
		 data63 => P(63),
		 data64 => X,
		 data65 => Z,
		 data66 => SYNTHESIZED_WIRE_4,
		 data7 => P(7),
		 data8 => P(8),
		 data9 => P(9),
		 sel => DOPZU(6 DOWNTO 0),
		 result => SYNTHESIZED_WIRE_3);


SYNTHESIZED_WIRE_5 <= Reset AND Clk_25MHz;



S2_1 <= S2 XOR SYNTHESIZED_WIRE_5;


Y_ALTERA_SYNTHESIZED(0) <= DOPZU(8) AND Clk;


b2v_inst2 : ua_ct4
PORT MAP(clock => Clk_25MHz,
		 cnt_en => SYNTHESIZED_WIRE_6,
		 sclr => Clk,
		 q => ct4q);


Y_ALTERA_SYNTHESIZED(1) <= DOPZU(9) AND Clk;


Y_ALTERA_SYNTHESIZED(2) <= DOPZU(10) AND Clk;


Y_ALTERA_SYNTHESIZED(3) <= DOPZU(11) AND Clk;


Y_ALTERA_SYNTHESIZED(4) <= DOPZU(12) AND Clk;


Y_ALTERA_SYNTHESIZED(5) <= DOPZU(13) AND Clk;


Y_ALTERA_SYNTHESIZED(6) <= DOPZU(14) AND Clk;


Y_ALTERA_SYNTHESIZED(7) <= DOPZU(15) AND Clk;


Y_ALTERA_SYNTHESIZED(8) <= DOPZU(16) AND Clk;


Y_ALTERA_SYNTHESIZED(9) <= DOPZU(17) AND Clk;


Y_ALTERA_SYNTHESIZED(10) <= DOPZU(18) AND Clk;


PROCESS(Clk_25MHz)
BEGIN
IF (RISING_EDGE(Clk_25MHz)) THEN
	S1 <= SYNTHESIZED_WIRE_7;
END IF;
END PROCESS;


Y_ALTERA_SYNTHESIZED(11) <= DOPZU(19) AND Clk;


Y_ALTERA_SYNTHESIZED(12) <= DOPZU(20) AND Clk;


Y_ALTERA_SYNTHESIZED(13) <= DOPZU(21) AND Clk;


Y_ALTERA_SYNTHESIZED(14) <= DOPZU(22) AND Clk;


Y_ALTERA_SYNTHESIZED(15) <= DOPZU(23) AND Clk;


Y_ALTERA_SYNTHESIZED(16) <= DOPZU(24) AND Clk;


Y_ALTERA_SYNTHESIZED(17) <= DOPZU(25) AND Clk;


Y_ALTERA_SYNTHESIZED(18) <= DOPZU(26) AND Clk;


Y_ALTERA_SYNTHESIZED(19) <= DOPZU(27) AND Clk;


Y_ALTERA_SYNTHESIZED(20) <= DOPZU(28) AND Clk;


PROCESS(SYNTHESIZED_WIRE_12)
BEGIN
IF (RISING_EDGE(SYNTHESIZED_WIRE_12)) THEN
	DFF_inst4 <= ct4q(1);
END IF;
END PROCESS;


Y_ALTERA_SYNTHESIZED(21) <= DOPZU(29) AND Clk;


Y_ALTERA_SYNTHESIZED(22) <= DOPZU(30) AND Clk;


Y_ALTERA_SYNTHESIZED(23) <= DOPZU(31) AND Clk;


Y_ALTERA_SYNTHESIZED(24) <= DOPZU(32) AND Clk;


Y_ALTERA_SYNTHESIZED(25) <= DOPZU(33) AND Clk;


Y_ALTERA_SYNTHESIZED(26) <= DOPZU(34) AND Clk;


Y_ALTERA_SYNTHESIZED(27) <= DOPZU(35) AND Clk;


Y_ALTERA_SYNTHESIZED(28) <= DOPZU(36) AND Clk;


Y_ALTERA_SYNTHESIZED(29) <= DOPZU(37) AND Clk;


Y_ALTERA_SYNTHESIZED(30) <= DOPZU(38) AND Clk;


PROCESS(SYNTHESIZED_WIRE_12)
BEGIN
IF (RISING_EDGE(SYNTHESIZED_WIRE_12)) THEN
	DFF_inst5 <= ct4q(2);
END IF;
END PROCESS;


Y_ALTERA_SYNTHESIZED(31) <= DOPZU(39) AND Clk;


Y_ALTERA_SYNTHESIZED(32) <= DOPZU(40) AND Clk;


Y_ALTERA_SYNTHESIZED(33) <= DOPZU(41) AND Clk;


Y_ALTERA_SYNTHESIZED(34) <= DOPZU(42) AND Clk;


Y_ALTERA_SYNTHESIZED(35) <= DOPZU(43) AND Clk;


Y_ALTERA_SYNTHESIZED(36) <= DOPZU(44) AND Clk;


Y_ALTERA_SYNTHESIZED(37) <= DOPZU(45) AND Clk;


Y_ALTERA_SYNTHESIZED(38) <= DOPZU(46) AND Clk;


Y_ALTERA_SYNTHESIZED(39) <= DOPZU(47) AND Clk;


Y_ALTERA_SYNTHESIZED(40) <= DOPZU(48) AND Clk;


PROCESS(SYNTHESIZED_WIRE_12)
BEGIN
IF (RISING_EDGE(SYNTHESIZED_WIRE_12)) THEN
	SYNTHESIZED_WIRE_11 <= ct4q(3);
END IF;
END PROCESS;


Y_ALTERA_SYNTHESIZED(41) <= DOPZU(49) AND Clk;


Y_ALTERA_SYNTHESIZED(42) <= DOPZU(50) AND Clk;


Y_ALTERA_SYNTHESIZED(43) <= DOPZU(51) AND Clk;


Y_ALTERA_SYNTHESIZED(44) <= DOPZU(52) AND Clk;


Y_ALTERA_SYNTHESIZED(45) <= DOPZU(53) AND Clk;


Y_ALTERA_SYNTHESIZED(46) <= DOPZU(54) AND Clk;


Y_ALTERA_SYNTHESIZED(47) <= DOPZU(55) AND Clk;


Y_ALTERA_SYNTHESIZED(48) <= DOPZU(56) AND Clk;


Y_ALTERA_SYNTHESIZED(49) <= DOPZU(57) AND Clk;


Y_ALTERA_SYNTHESIZED(50) <= DOPZU(58) AND Clk;


SYNTHESIZED_WIRE_12 <= NOT(Clk_25MHz);



Y_ALTERA_SYNTHESIZED(51) <= DOPZU(59) AND Clk;


Y_ALTERA_SYNTHESIZED(52) <= DOPZU(60) AND Clk;


Y_ALTERA_SYNTHESIZED(53) <= DOPZU(61) AND Clk;


Y_ALTERA_SYNTHESIZED(54) <= DOPZU(62) AND Clk;


Y_ALTERA_SYNTHESIZED(55) <= DOPZU(63) AND Clk;


Y_ALTERA_SYNTHESIZED(56) <= DOPZU(64) AND Clk;


Y_ALTERA_SYNTHESIZED(57) <= DOPZU(65) AND Clk;


Y_ALTERA_SYNTHESIZED(58) <= DOPZU(66) AND Clk;


Y_ALTERA_SYNTHESIZED(59) <= DOPZU(67) AND Clk;


Y_ALTERA_SYNTHESIZED(60) <= DOPZU(68) AND Clk;


SYNTHESIZED_WIRE_6 <= NOT(SYNTHESIZED_WIRE_11);



Y_ALTERA_SYNTHESIZED(61) <= DOPZU(69) AND Clk;


Y_ALTERA_SYNTHESIZED(62) <= DOPZU(70) AND Clk;


Y_ALTERA_SYNTHESIZED(63) <= DOPZU(71) AND Clk;


SYNTHESIZED_WIRE_2 <= DFF_inst4 AND DFF_inst5;

Y <= Y_ALTERA_SYNTHESIZED;

END bdf_type;