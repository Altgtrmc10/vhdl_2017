library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TV is
	port(p1,p2,p3: in STD_LOGIC;
		 a,b,c,d: out STD_LOGIC);
end TV;

architecture Behavioral of TV is
	signal snp1,snp2,snp3: STD_LOGIC;
begin
	snp1 <= not p1;
	snp2 <= not p2;
	snp3 <= not p3;
	a <= p1 and p2 and p3;
	b <= not(p1 and p2 and p3);
	c <= (p1 and p2) or (p1 and p3) or (p2 and p3);
	d <= (snp1 and snp2) or (snp2 and snp3) or (snp1 and snp3);
end Behavioral;	