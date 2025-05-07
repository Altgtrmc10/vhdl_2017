-- This is the NAND gate
library ieee;
use ieee.std_logic_1164.all;

entity NAND_Gate is 
   port(A,B,C: in std_logic;
        F: out std_logic);
end NAND_Gate;

architecture Func of NAND_Gate is 
begin
   F <= not(A and B and C);
end Func;

-- This is the NOT gate
library ieee;
use ieee.std_logic_1164.all;

entity NOT_Gate is
   port(InPort: in std_logic;
        OutPort: out std_logic);
end NOT_Gate;

architecture Func of NOT_Gate is 
begin
   OutPort <= not InPort;
end Func;

-- This is the 2to4 Decoder
library ieee;
use ieee.std_logic_1164.all;

entity Dec_2x4_E is
   port(A0,A1,E: in std_logic;
        D0,D1,D2,D3: out std_logic);
end Dec_2x4_E;

architecture Func of Dec_2x4_E is
   component NAND_Gate is        --Import NAND Gate entity
      port(A,B,C: in std_logic;
           F: out std_logic);
   end component;
   component NOT_Gate is         --Import NOT Gate entity
      port(InPort: in std_logic;
           OutPort: out std_logic);
   end component;
   signal InvA0,InvA1,InvE: std_logic;
begin
   GI1: NOT_Gate port map (A0,InvA0);
   GI2: NOT_Gate port map (A1,InvA1);
   GI3: NOT_Gate port map (E,InvE);
   GA1: NAND_Gate port map (InvA0,InvA1,InvE,D0);
   GA2: NAND_Gate port map (A0,InvA1,InvE,D1);
   GA3: NAND_Gate port map (InvA0,A1,InvE,D2);
   GA4: NAND_Gate port map (A1,A0,InvE,D3);
end Func;