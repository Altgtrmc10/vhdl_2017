library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity Sumador_Completo is
   Port(a    : in STD_LOGIC;
        b    : in STD_LOGIC;
        cin  : in STD_LOGIC;
        f    : out STD_LOGIC;
        cout : out STD_LOGIC);
end Sumador_Completo;
 
architecture Behavioral of Sumador_Completo is
begin
   f <= a xor b xor cin;
   cout <= (a and b) or (cin and (a xor b));
end Behavioral;