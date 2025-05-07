library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.VITAL_PRIMITIVES.ALL;

entity Comp_AND_1 is
	port(a,b: in STD_LOGIC;
		 f: out STD_LOGIC);
end Comp_AND_1;

architecture Estructural of Comp_AND_1 is
begin
	f <= VitalAND2(a,b);
end Estructural;