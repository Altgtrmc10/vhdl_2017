library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Mux2_2 is
	port (D0, D1, S0: in STD_LOGIC; O: out STD_LOGIC);
end Mux2_2;

architecture Behavioral_2 of Mux2_2 is
begin
	Multiplexor: process(D0,D1,S0)
	begin
		if(S0 = '1') then
			O <= D1;
		else
			O <= D0;
		end if;
	end process;
end Behavioral_2;