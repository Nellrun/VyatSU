-- Copyright (C) 1991-2009 Altera Corporation
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
-- VERSION		"Version 9.1 Build 222 10/21/2009 SJ Web Edition"
-- CREATED		"Mon Jan 31 10:15:14 2011"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY test2 IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		res :  IN  STD_LOGIC;
		xpin :  IN  STD_LOGIC_VECTOR(8 DOWNTO 0);
		apin :  OUT  STD_LOGIC_VECTOR(8 DOWNTO 0);
		ctpin :  OUT  STD_LOGIC_VECTOR(6 DOWNTO 0);
		outpin :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0);
		ypin :  OUT  STD_LOGIC_VECTOR(8 DOWNTO 0)
	);
END test2;

ARCHITECTURE bdf_type OF test2 IS 

COMPONENT reg
	PORT(clock : IN STD_LOGIC;
		 data : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
	);
END COMPONENT;

COMPONENT ilireset
	PORT(data : IN STD_LOGIC_VECTOR(2 DOWNTO 0 , 0 TO 0);
		 result : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT dc4
	PORT(data : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 eq0 : OUT STD_LOGIC;
		 eq1 : OUT STD_LOGIC;
		 eq2 : OUT STD_LOGIC;
		 eq3 : OUT STD_LOGIC;
		 eq4 : OUT STD_LOGIC;
		 eq5 : OUT STD_LOGIC;
		 eq6 : OUT STD_LOGIC;
		 eq7 : OUT STD_LOGIC;
		 eq8 : OUT STD_LOGIC;
		 eq9 : OUT STD_LOGIC;
		 eq10 : OUT STD_LOGIC;
		 eq11 : OUT STD_LOGIC;
		 eq12 : OUT STD_LOGIC;
		 eq13 : OUT STD_LOGIC;
		 eq14 : OUT STD_LOGIC;
		 eq15 : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT ct4pm
	PORT(sclr : IN STD_LOGIC;
		 updown : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 cnt_en : IN STD_LOGIC;
		 aload : IN STD_LOGIC;
		 data : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	a :  STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL	ct :  STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL	g :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	h :  STD_LOGIC;
SIGNAL	j :  STD_LOGIC;
SIGNAL	k :  STD_LOGIC;
SIGNAL	m :  STD_LOGIC;
SIGNAL	mu :  STD_LOGIC;
SIGNAL	nct :  STD_LOGIC_VECTOR(0 TO 0);
SIGNAL	nx[1] :  STD_LOGIC;
SIGNAL	nx[2] :  STD_LOGIC;
SIGNAL	nx[3] :  STD_LOGIC;
SIGNAL	nx[5] :  STD_LOGIC;
SIGNAL	nx[6] :  STD_LOGIC;
SIGNAL	o :  STD_LOGIC;
SIGNAL	out :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	p :  STD_LOGIC;
SIGNAL	q :  STD_LOGIC;
SIGNAL	te :  STD_LOGIC;
SIGNAL	ty :  STD_LOGIC;
SIGNAL	v :  STD_LOGIC;
SIGNAL	w :  STD_LOGIC;
SIGNAL	w1 :  STD_LOGIC;
SIGNAL	w2 :  STD_LOGIC;
SIGNAL	x :  STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL	y[0] :  STD_LOGIC;
SIGNAL	y[1] :  STD_LOGIC;
SIGNAL	y[2] :  STD_LOGIC;
SIGNAL	y[3] :  STD_LOGIC;
SIGNAL	y[4] :  STD_LOGIC;
SIGNAL	y[7] :  STD_LOGIC;
SIGNAL	y[8] :  STD_LOGIC;
SIGNAL	y[9] :  STD_LOGIC;
SIGNAL	yy :  STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL	z1 :  STD_LOGIC;

SIGNAL	GDFX_TEMP_SIGNAL_0 :  STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_3 :  STD_LOGIC_VECTOR(2 DOWNTO 0 , 0 TO 0);
SIGNAL	GDFX_TEMP_SIGNAL_1 :  STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_2 :  STD_LOGIC_VECTOR(4 DOWNTO 0);

BEGIN 

GDFX_TEMP_SIGNAL_0 <= (x(6 DOWNTO 5) & x(3 DOWNTO 1));
GDFX_TEMP_SIGNAL_3 <= (z1 & y[9] & y[7]);
GDFX_TEMP_SIGNAL_1 <= (y[8] & y[7] & y[9] & a(5) & y[4] & y[3] & y[2] & y[1] & y[0]);
GDFX_TEMP_SIGNAL_2 <= (nct(0) & g(2 DOWNTO 0) & v);

 <= NOT(GDFX_TEMP_SIGNAL_0);
 <= NOT(GDFX_TEMP_SIGNAL_0);
 <= NOT(GDFX_TEMP_SIGNAL_0);
 <= NOT(GDFX_TEMP_SIGNAL_0);
 <= NOT(GDFX_TEMP_SIGNAL_0);


h <= a(3) OR a(1);


o <= p AND nx[3];


j <= m OR o;


y[4] <= x(4) AND j;


q <= a(6) AND x(5);


y[3] <= q AND nx[6];


ty <= q AND x(6);


mu <= a(4) OR ty;


y[7] <= x(7) AND mu;


y[8] <= a(8) AND x(8);


te <= a(7) OR p;


m <= a(6) AND nx[5];


w1 <= te AND x(3);


w2 <= h AND x(1);


y[9] <= w2 OR w1;


z1 <= a(7) AND nx[3];


b2v_inst25 : reg
PORT MAP(clock => clk,
		 data => GDFX_TEMP_SIGNAL_1,
		 q => yy);


ct(6) <= NOT(nx[5] AND a(6));

ct(5 DOWNTO 1) <= GDFX_TEMP_SIGNAL_2;



p <= a(4) AND nx[2];




nct <= NOT(ct(0));



w <= a(2) OR a(0);


y[0] <= w AND x(0);


k <= a(0) AND x(0);


y[1] <= y[9] OR k;


y[2] <= nx[1] AND h;


b2v_inst9 : ilireset
PORT MAP(data => GDFX_TEMP_SIGNAL_3,
		 result => ct(0));


b2v_UAinst1 : dc4
PORT MAP(data => out,
		 eq0 => a(8),
		 eq1 => a(0),
		 eq2 => a(1),
		 eq3 => a(2),
		 eq4 => a(3),
		 eq5 => a(4),
		 eq6 => a(5),
		 eq7 => a(6),
		 eq8 => a(7));


b2v_UAinst27 : ct4pm
PORT MAP(sclr => ct(0),
		 updown => ct(6),
		 clock => clk,
		 cnt_en => ct(5),
		 aload => res,
		 data => ct(4 DOWNTO 1),
		 q => out);

apin <= a;
x <= xpin;
ctpin <= ct;
outpin <= out;
ypin <= yy;

g <= "000";
v <= '1';
END bdf_type;