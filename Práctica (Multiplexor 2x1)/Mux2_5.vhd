library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Mux2_5 is
	port (D0, D1, S0: in STD_LOGIC; O: out STD_LOGIC);
end Mux2_5;

architecture Data_Flow of Mux2_5 is
	signal TEMP: STD_LOGIC_VECTOR(2 downto 0);
begin 
	O <= '0' when TEMP = "000" else
		 '1' when TEMP = "001" else
		 '0' when TEMP = "010" else
		 '1' when TEMP = "011" else
		 '0' when TEMP = "100" else
		 '0' when TEMP = "101" else
		 '1' when TEMP = "110" else
		 '1';
	TEMP <= S0 & D1 & D0;
end Data_Flow;