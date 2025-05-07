library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Comp_OR_3 is
	port(a,b: in STD_LOGIC;
		 f: out STD_LOGIC);
end Comp_OR_3;

architecture Funcional of Comp_OR_3 is
begin
	process (a,b)
	begin
		if (a = '0' AND b = '0') then
			f <= '0';
		else
			f <= '1';
		end if;
	end process;
end Funcional;