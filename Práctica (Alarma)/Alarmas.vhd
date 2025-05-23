library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Alarmas is
	port(iar,iig,sm1,sm2,sifr,shumo,sco,shume: in STD_LOGIC;
		 arob,ainc,ahume,aco,aenc: inout STD_LOGIC);
end Alarmas;

architecture Behavioral of Alarmas is
begin
	arob <= ((not iig and sifr) or sm1 or sm2) and iar;
	ainc <= shumo;
	ahume <= shume;
	aco <= sco;
	aenc <= arob or ainc or ahume or aco;
end Behavioral;