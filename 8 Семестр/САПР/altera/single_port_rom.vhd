library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity single_port_rom is

	port
	(
		addr	: in natural range 0 to 127;
		clk		: in std_logic;
		q		: out std_logic_vector(3 downto 0)
	);
	
end entity;

architecture rtl of single_port_rom is

	-- Build a 2-D array type for the RoM
	subtype word_t is std_logic_vector(3 downto 0);
	type memory_t is array(255 downto 0) of word_t;
		
	function init_rom
		return memory_t is
		variable tmp : memory_t := (others => (others => '0'));
		begin
			for addr_pos in 0 to 127 loop
				-- Initialize each address with the address itself
				tmp(addr_pos) := std_logic_vector(to_unsigned(addr_pos, 4));
			end loop;
		return tmp;
	end init_rom;
	
	-- Declare the ROM signal and specify a default value.	Quartus II
	-- will create a memory initialization file (.mif) based on the 
	-- default value.
	signal rom : memory_t := (
		0 => "1000", -- Prog 0
		1 => "0100",
		2 => "0010",
		3 => "0001",
		4 => "1000",
		5 => "0100",
		6 => "0010",
		7 => "0001",
		8 => "1000", -- Prog 1
		9 => "0100",
		10 => "0010",
		11 => "0001",
		12 => "1000",
		13 => "0100",
		14 => "0010",
		15 => "0001",
		16 => "0001", -- Prog 2
		17 => "0010",
		18 => "0100",
		19 => "1000",
		20 => "0001",
		21 => "0010",
		22 => "0100",
		23 => "1000",
		24 => "0101", -- Prog 3
		25 => "1010",
		26 => "0101",
		27 => "1010",
		28 => "0101",
		29 => "1010",
		30 => "0101",
		31 => "1010",
		32 => "0101",
		33 => "0000", -- Prog 4
		34 => "1000",
		35 => "1100",
		36 => "1110",
		37 => "1111",
		38 => "1110",
		39 => "1100",
		40 => "1000",
		41 => "0000", -- Prog 5
		42 => "0001",
		43 => "0011",
		44 => "0111",
		45 => "1111",
		46 => "0111",
		47 => "0011",
		48 => "0001",
		OTHERS => "0000"
	);
	
begin
	
	process(clk)
	begin
		if(rising_edge(clk)) then
			q <= rom(addr);
		end if;
	end process;
		
end rtl;
