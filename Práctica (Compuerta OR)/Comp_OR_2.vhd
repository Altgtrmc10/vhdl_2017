library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Comp_OR_2 is
	port(a,b: in STD_LOGIC;
		 f: out STD_LOGIC);
end Comp_OR_2;

architecture Flujo_Datos of Comp_OR_2 is
begin
	f <= a OR b;
end Flujo_Datos;