library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Comp_AND_3 is
	port(a,b: in STD_LOGIC;
		 f: out STD_LOGIC);
end Comp_AND_3;

architecture Funcional of Comp_AND_3 is
begin
	process (a,b)
	begin
		if (a = '1' AND b = '1') then
			f <= '1';
		else
			f <= '0';
		end if;
	end process;
end Funcional;