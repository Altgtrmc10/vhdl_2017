library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.VITAL_PRIMITIVES.ALL;

entity Mux2_3 is
	port (D0, D1, S0: in STD_LOGIC; O: out STD_LOGIC);
end Mux2_3;

architecture Structural of Mux2_3 is
	signal S1,S2,S3: STD_LOGIC;
begin
	S1 <= NOT S0;
	S2 <= VitalAND2(D0,S1);
	S3 <= VitalAND2(S0,D1);
	O <= VitalOR2(S2,S3);
end Structural;