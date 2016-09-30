library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity sram is
    Port ( CLK : in  STD_LOGIC;
		reset : in std_logic;
           A : out  STD_LOGIC_VECTOR (17 downto 0);
           D : inout  STD_LOGIC_VECTOR (15 downto 0);
           WE : out  STD_LOGIC;
           OE : out  STD_LOGIC;
		   end_test : out  STD_LOGIC; 
           OK : out  STD_LOGIC);
end sram;

architecture rtl of sram is
constant cycle_num	: std_logic_vector(5 downto 0):="001111";
signal cnt_cycle	: std_logic_vector(5 downto 0);

signal ADDR:std_logic_vector(17 downto 0);
signal DATA:std_logic_vector(15 downto 0);
signal CHECK:std_logic;
signal OEN:std_logic;
type STATE_TYPE is (START,working,WR,WR1,WR2,RD,RD1);
signal STATE:STATE_TYPE:=START;
begin

DATA<=ADDR(0) & not ADDR(1) & ADDR(2) & not ADDR(3) & ADDR(4) & not ADDR(5) 
    & ADDR(6) & not ADDR(7) & ADDR(8) & not ADDR(9) & ADDR(10) & not ADDR(11) 
    & ADDR(12) & not ADDR(13) & ADDR(14) & not ADDR(15);
OE<=OEN;
D<=DATA when OEN='1' else (others=>'Z');
A<=ADDR;

process(CLK, reset)
begin
   if reset='0'  then
			OEN<='1';
			OK<='0';
			cnt_cycle<=(others=>'0');
            WE<='1';
            STATE<=start;
			addr<=(others=>'0');
			CHECK<='1';
			end_test<='0';
	elsif clk'event and clk='1' then 
      case STATE is
         when START =>
            OEN<='1';
			--OK<='0';
			cnt_cycle<=(others=>'0');
            WE<='1';
            STATE<=WR;
			addr<=(others=>'0');
			--CHECK<='1';
			--end_test<='0';
			
         when working =>
            OEN<='1';
            WE<='1';
			addr<=(others=>'0');
			if cnt_cycle=cycle_num then
				end_test<='1';
				OK<=CHECK;
				STATE<=START; --WORKING;
			else
				STATE<=WR;
			end if;
			
         when WR =>
            WE<='0';
            STATE<=WR1;
         when WR1 =>
            WE<='1';
            STATE<=WR2;
         when WR2 =>
            ADDR<=ADDR+1;
            if(ADDR="111111111111111111") then
               STATE<=RD;
               
            else
               STATE<=WR;
            end if;
            
         when RD =>
            OEN<='0';
            STATE<=RD1;
            if(D/=DATA) then
               CHECK<='0';
            end if;
            end_test<='0';
         when RD1 =>
            ADDR<=ADDR+1;
            if(ADDR="111111111111111111") then
               STATE<=working;
				cnt_cycle<=cnt_cycle+1;
               
            else
               STATE<=RD;
            end if;
         end case;
   end if;
end process;

end rtl;

