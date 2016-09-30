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
-- VERSION		"Version 9.1 Build 350 03/24/2010 Service Pack 2 SJ Web Edition"
-- CREATED		"Fri Oct 14 08:19:50 2011"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY alu32 IS 
	PORT
	(
		S3 :  IN  STD_LOGIC;
		S2 :  IN  STD_LOGIC;
		S1 :  IN  STD_LOGIC;
		S0 :  IN  STD_LOGIC;
		M :  IN  STD_LOGIC;
		CRPn :  IN  STD_LOGIC;
		A :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		B :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		CRn :  OUT  STD_LOGIC;
		AB :  OUT  STD_LOGIC;
		F :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END alu32;

ARCHITECTURE bdf_type OF alu32 IS 

COMPONENT aluip3
	PORT(S3 : IN STD_LOGIC;
		 S2 : IN STD_LOGIC;
		 S0 : IN STD_LOGIC;
		 S1 : IN STD_LOGIC;
		 M : IN STD_LOGIC;
		 Cn : IN STD_LOGIC;
		 A : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 B : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 Gn : OUT STD_LOGIC;
		 Cn4 : OUT STD_LOGIC;
		 Pn : OUT STD_LOGIC;
		 AeqB : OUT STD_LOGIC;
		 F : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;

COMPONENT aluip4
	PORT(P4n : IN STD_LOGIC;
		 P3n : IN STD_LOGIC;
		 P2n : IN STD_LOGIC;
		 P1n : IN STD_LOGIC;
		 G4n : IN STD_LOGIC;
		 G3n : IN STD_LOGIC;
		 G2n : IN STD_LOGIC;
		 G1n : IN STD_LOGIC;
		 Cn : IN STD_LOGIC;
		 Pn : OUT STD_LOGIC;
		 Gn : OUT STD_LOGIC;
		 Cz : OUT STD_LOGIC;
		 Cy : OUT STD_LOGIC;
		 Cx : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	C1 :  STD_LOGIC;
SIGNAL	C2 :  STD_LOGIC;
SIGNAL	C3 :  STD_LOGIC;
SIGNAL	C4 :  STD_LOGIC;
SIGNAL	C5 :  STD_LOGIC;
SIGNAL	C6 :  STD_LOGIC;
SIGNAL	C7 :  STD_LOGIC;
SIGNAL	F_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	G0 :  STD_LOGIC;
SIGNAL	G1 :  STD_LOGIC;
SIGNAL	G2 :  STD_LOGIC;
SIGNAL	G3 :  STD_LOGIC;
SIGNAL	G4 :  STD_LOGIC;
SIGNAL	G5 :  STD_LOGIC;
SIGNAL	G6 :  STD_LOGIC;
SIGNAL	G7 :  STD_LOGIC;
SIGNAL	P0 :  STD_LOGIC;
SIGNAL	P1 :  STD_LOGIC;
SIGNAL	P2 :  STD_LOGIC;
SIGNAL	P3 :  STD_LOGIC;
SIGNAL	P4 :  STD_LOGIC;
SIGNAL	P5 :  STD_LOGIC;
SIGNAL	P6 :  STD_LOGIC;
SIGNAL	P7 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_6 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_7 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_8 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_9 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_10 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_11 :  STD_LOGIC;


BEGIN 



b2v_inst : aluip3
PORT MAP(S3 => S3,
		 S2 => S2,
		 S0 => S0,
		 S1 => S1,
		 M => M,
		 Cn => CRPn,
		 A => A(3 DOWNTO 0),
		 B => B(3 DOWNTO 0),
		 Gn => G0,
		 Pn => P0,
		 AeqB => SYNTHESIZED_WIRE_0,
		 F => F_ALTERA_SYNTHESIZED(3 DOWNTO 0));


b2v_inst1 : aluip4
PORT MAP(P4n => P3,
		 P3n => P2,
		 P2n => P1,
		 P1n => P0,
		 G4n => G3,
		 G3n => G2,
		 G2n => G1,
		 G1n => G0,
		 Cn => CRPn,
		 Pn => SYNTHESIZED_WIRE_9,
		 Gn => SYNTHESIZED_WIRE_11,
		 Cz => C3,
		 Cy => C2,
		 Cx => C1);


b2v_inst10 : aluip3
PORT MAP(S3 => S3,
		 S2 => S2,
		 S0 => S0,
		 S1 => S1,
		 M => M,
		 Cn => C5,
		 A => A(23 DOWNTO 20),
		 B => B(23 DOWNTO 20),
		 Gn => G5,
		 Pn => P5,
		 AeqB => SYNTHESIZED_WIRE_5,
		 F => F_ALTERA_SYNTHESIZED(23 DOWNTO 20));


b2v_inst12 : aluip3
PORT MAP(S3 => S3,
		 S2 => S2,
		 S0 => S0,
		 S1 => S1,
		 M => M,
		 Cn => C6,
		 A => A(27 DOWNTO 24),
		 B => B(27 DOWNTO 24),
		 Gn => G6,
		 Pn => P6,
		 AeqB => SYNTHESIZED_WIRE_4,
		 F => F_ALTERA_SYNTHESIZED(27 DOWNTO 24));


b2v_inst13 : aluip3
PORT MAP(S3 => S3,
		 S2 => S2,
		 S0 => S0,
		 S1 => S1,
		 M => M,
		 Cn => C7,
		 A => A(31 DOWNTO 28),
		 B => B(31 DOWNTO 28),
		 Gn => G7,
		 Pn => P7,
		 AeqB => SYNTHESIZED_WIRE_6,
		 F => F_ALTERA_SYNTHESIZED(31 DOWNTO 28));


AB <= SYNTHESIZED_WIRE_0 AND SYNTHESIZED_WIRE_1 AND SYNTHESIZED_WIRE_2 AND SYNTHESIZED_WIRE_3 AND SYNTHESIZED_WIRE_4 AND SYNTHESIZED_WIRE_5 AND SYNTHESIZED_WIRE_6 AND SYNTHESIZED_WIRE_7;


b2v_inst2 : aluip4
PORT MAP(P4n => P7,
		 P3n => P6,
		 P2n => P5,
		 P1n => P4,
		 G4n => G7,
		 G3n => G6,
		 G2n => G5,
		 G1n => G4,
		 Cn => C4,
		 Pn => SYNTHESIZED_WIRE_8,
		 Gn => SYNTHESIZED_WIRE_10,
		 Cz => C7,
		 Cy => C6,
		 Cx => C5);


b2v_inst3 : aluip4
PORT MAP(P2n => SYNTHESIZED_WIRE_8,
		 P1n => SYNTHESIZED_WIRE_9,
		 G2n => SYNTHESIZED_WIRE_10,
		 G1n => SYNTHESIZED_WIRE_11,
		 Cn => CRPn,
		 Cy => CRn,
		 Cx => C4);


b2v_inst6 : aluip3
PORT MAP(S3 => S3,
		 S2 => S2,
		 S0 => S0,
		 S1 => S1,
		 M => M,
		 Cn => C1,
		 A => A(7 DOWNTO 4),
		 B => B(7 DOWNTO 4),
		 Gn => G1,
		 Pn => P1,
		 AeqB => SYNTHESIZED_WIRE_2,
		 F => F_ALTERA_SYNTHESIZED(7 DOWNTO 4));


b2v_inst7 : aluip3
PORT MAP(S3 => S3,
		 S2 => S2,
		 S0 => S0,
		 S1 => S1,
		 M => M,
		 Cn => C2,
		 A => A(11 DOWNTO 8),
		 B => B(11 DOWNTO 8),
		 Gn => G2,
		 Pn => P2,
		 AeqB => SYNTHESIZED_WIRE_1,
		 F => F_ALTERA_SYNTHESIZED(11 DOWNTO 8));


b2v_inst8 : aluip3
PORT MAP(S3 => S3,
		 S2 => S2,
		 S0 => S0,
		 S1 => S1,
		 M => M,
		 Cn => C3,
		 A => A(15 DOWNTO 12),
		 B => B(15 DOWNTO 12),
		 Gn => G3,
		 Pn => P3,
		 AeqB => SYNTHESIZED_WIRE_3,
		 F => F_ALTERA_SYNTHESIZED(15 DOWNTO 12));


b2v_inst9 : aluip3
PORT MAP(S3 => S3,
		 S2 => S2,
		 S0 => S0,
		 S1 => S1,
		 M => M,
		 Cn => C4,
		 A => A(19 DOWNTO 16),
		 B => B(19 DOWNTO 16),
		 Gn => G4,
		 Pn => P4,
		 AeqB => SYNTHESIZED_WIRE_7,
		 F => F_ALTERA_SYNTHESIZED(19 DOWNTO 16));

F <= F_ALTERA_SYNTHESIZED;

END bdf_type;