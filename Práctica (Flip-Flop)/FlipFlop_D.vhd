library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity FlipFlop_D is
	port(D,clk: in std_logic;
		 Q: out std_logic);
end FlipFlop_D;

architecture Behavioral of FlipFlop_D is
begin
	process (clk)
	begin
		if (clk'event and clk='1') then
			Q <= D;
		end if;
	end process;
end Behavioral;