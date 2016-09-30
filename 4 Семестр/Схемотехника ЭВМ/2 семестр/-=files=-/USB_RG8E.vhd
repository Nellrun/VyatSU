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
-- CREATED		"Wed Aug 24 19:41:19 2011"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY USB_RG8E IS 
	PORT
	(
		C :  IN  STD_LOGIC;
		E :  IN  STD_LOGIC;
		DI :  IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		DO :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END USB_RG8E;

ARCHITECTURE bdf_type OF USB_RG8E IS 

SIGNAL	DO_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(7 DOWNTO 0);


BEGIN 



PROCESS(C)
BEGIN
IF (RISING_EDGE(C)) THEN
	IF (E = '1') THEN
	DO_ALTERA_SYNTHESIZED(0) <= DI(0);
	END IF;
END IF;
END PROCESS;


PROCESS(C)
BEGIN
IF (RISING_EDGE(C)) THEN
	IF (E = '1') THEN
	DO_ALTERA_SYNTHESIZED(6) <= DI(6);
	END IF;
END IF;
END PROCESS;


PROCESS(C)
BEGIN
IF (RISING_EDGE(C)) THEN
	IF (E = '1') THEN
	DO_ALTERA_SYNTHESIZED(7) <= DI(7);
	END IF;
END IF;
END PROCESS;


PROCESS(C)
BEGIN
IF (RISING_EDGE(C)) THEN
	IF (E = '1') THEN
	DO_ALTERA_SYNTHESIZED(1) <= DI(1);
	END IF;
END IF;
END PROCESS;


PROCESS(C)
BEGIN
IF (RISING_EDGE(C)) THEN
	IF (E = '1') THEN
	DO_ALTERA_SYNTHESIZED(2) <= DI(2);
	END IF;
END IF;
END PROCESS;


PROCESS(C)
BEGIN
IF (RISING_EDGE(C)) THEN
	IF (E = '1') THEN
	DO_ALTERA_SYNTHESIZED(3) <= DI(3);
	END IF;
END IF;
END PROCESS;


PROCESS(C)
BEGIN
IF (RISING_EDGE(C)) THEN
	IF (E = '1') THEN
	DO_ALTERA_SYNTHESIZED(4) <= DI(4);
	END IF;
END IF;
END PROCESS;


PROCESS(C)
BEGIN
IF (RISING_EDGE(C)) THEN
	IF (E = '1') THEN
	DO_ALTERA_SYNTHESIZED(5) <= DI(5);
	END IF;
END IF;
END PROCESS;

DO <= DO_ALTERA_SYNTHESIZED;

END bdf_type;