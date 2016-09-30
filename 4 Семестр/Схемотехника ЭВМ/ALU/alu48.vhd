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
-- CREATED		"Fri Oct 14 08:25:38 2011"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY alu48 IS 
	PORT
	(
		S3 :  IN  STD_LOGIC;
		S2 :  IN  STD_LOGIC;
		S1 :  IN  STD_LOGIC;
		S0 :  IN  STD_LOGIC;
		M :  IN  STD_LOGIC;
		CRPn :  IN  STD_LOGIC;
		A :  IN  STD_LOGIC_VECTOR(47 DOWNTO 0);
		B :  IN  STD_LOGIC_VECTOR(47 DOWNTO 0);
		CRn :  OUT  STD_LOGIC;
		AB :  OUT  STD_LOGIC;
		F :  OUT  STD_LOGIC_VECTOR(47 DOWNTO 0)
	);
END alu48;

ARCHITECTURE bdf_type OF alu48 IS 

COMPONENT alu24
	PORT(S3 : IN STD_LOGIC;
		 S2 : IN STD_LOGIC;
		 S1 : IN STD_LOGIC;
		 S0 : IN STD_LOGIC;
		 M : IN STD_LOGIC;
		 CRPn : IN STD_LOGIC;
		 A : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 B : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 AB : OUT STD_LOGIC;
		 CRn : OUT STD_LOGIC;
		 F : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	F_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(47 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;


BEGIN 



b2v_inst : alu24
PORT MAP(S3 => S3,
		 S2 => S2,
		 S1 => S1,
		 S0 => S0,
		 M => M,
		 CRPn => CRPn,
		 A => A(23 DOWNTO 0),
		 B => B(23 DOWNTO 0),
		 AB => SYNTHESIZED_WIRE_1,
		 CRn => SYNTHESIZED_WIRE_0,
		 F => F_ALTERA_SYNTHESIZED(23 DOWNTO 0));


b2v_inst1 : alu24
PORT MAP(S3 => S3,
		 S2 => S2,
		 S1 => S1,
		 S0 => S0,
		 M => M,
		 CRPn => SYNTHESIZED_WIRE_0,
		 A => A(47 DOWNTO 24),
		 B => B(47 DOWNTO 24),
		 AB => SYNTHESIZED_WIRE_2,
		 CRn => CRn,
		 F => F_ALTERA_SYNTHESIZED(47 DOWNTO 24));


AB <= SYNTHESIZED_WIRE_1 AND SYNTHESIZED_WIRE_2;

F <= F_ALTERA_SYNTHESIZED;

END bdf_type;