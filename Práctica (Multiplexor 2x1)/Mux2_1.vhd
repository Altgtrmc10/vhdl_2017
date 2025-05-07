library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Mux2_1 is
	port (D0, D1, S0: in STD_LOGIC; O: out STD_LOGIC);
end Mux2_1;

architecture Behavioral_1 of Mux2_1 is
begin
	O <= D1 when (S0 = '1') else D0;
end Behavioral_1;