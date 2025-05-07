library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
 
entity FlipFlop_JK is
	port(J,K,clock: in std_logic;
		 Q,Qn: out std_logic);
end FlipFlop_JK;
 
architecture Behavioral of FlipFlop_JK is
begin
	process(clock)
		variable tmp: std_logic;
	begin
		if(clock='1' and CLOCK'EVENT) then
			if(J='0' and K='0')then
				tmp:=tmp;
			elsif(J='1' and K='1')then
				tmp:= not tmp;
			elsif(J='0' and K='1')then
				tmp:='0';
			else
				tmp:='1';
			end if;
		end if;
		Q <= tmp;
		Qn <= not tmp;
	end process;
end Behavioral;