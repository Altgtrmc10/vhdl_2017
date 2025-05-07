library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
 
entity FlipFlop_T is
	port(T, clock: in std_logic;
	     Q: out std_logic);
end FlipFlop_T;
 
architecture Behavioral of FlipFlop_T is
	signal tmp: std_logic;
begin
	process (clock)
	begin
		if clock'event and clock='1' then
			if T='0' then
				tmp <= tmp;
			elsif T='1' then
				tmp <= not (tmp);
			end if;
		end if;
	end process;
	Q <= tmp;
end Behavioral;