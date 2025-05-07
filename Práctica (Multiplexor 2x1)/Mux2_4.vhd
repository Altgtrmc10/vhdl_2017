library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Mux2_4 is
	port (D0, D1, S0: in STD_LOGIC; O: out STD_LOGIC);
end Mux2_4;

architecture Mixed of Mux2_4 is
	signal S1,S2: STD_LOGIC;
begin 
	S1 <= D0 and not S0;
	S2 <= D1 and S0;
	O <= S1 or S2;
end Mixed;