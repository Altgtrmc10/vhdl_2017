library ieee;
use ieee. std_logic_1164.all;
use ieee. std_logic_arith.all;
use ieee. std_logic_unsigned.all;
 
entity FlipFlop_SR is
	port (S,R,clk: in std_logic;
		  Q,Qn: inout std_logic);
end FlipFlop_SR;
 
architecture Behavioral of FlipFlop_SR is
begin
	process (clk, S, R)
	begin
		if (clk'event and clk = '1') then
			if (S = '0' and R = '1') then
				Q <= '0';
				Qn <= '1';
			elsif (S = '1' and R = '0') then
				Q <= '1';
				Qn <= '0';
			elsif (S = '0' and R = '0') then
				Q <= Q;
				Qn <= Qn;
			else
				Q <= '-';
				Qn <= '-';
			end if;
		end if;
	end process;
end Behavioral;