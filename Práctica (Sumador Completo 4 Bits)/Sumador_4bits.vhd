library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity Sumador_4bits is
    Port(A    : in   STD_LOGIC_VECTOR (3 downto 0);
         B    : in   STD_LOGIC_VECTOR (3 downto 0);
         Cin  : in   STD_LOGIC;
         F    : out  STD_LOGIC_VECTOR (3 downto 0);
         Cout : out  STD_LOGIC);
end Sumador_4bits;
 
architecture Behavioral of Sumador_4bits is
   COMPONENT Sumador_Completo --Declaración del componente.
		PORT(a    : IN  std_logic;
			 b    : IN  std_logic;
			 cin  : IN  std_logic;
			 f    : OUT std_logic;
			 cout : OUT std_logic);
   END COMPONENT;
   --Señal intermedia para conectar el carry entre sumadores completos.
   signal C : std_logic_vector(2 downto 0);
begin
   Inst_SC0: Sumador_Completo PORT MAP(  --Instanciación Sumador Completo 0 (SC0).
        a    => A(0),
        b    => B(0),
        cin  => Cin,
        f    => F(0),
        cout => C(0));
   Inst_SC1: Sumador_Completo PORT MAP(  --Instanciación SC1.
        a    => A(1),
        b    => B(1),
        cin  => C(0),
        f    => F(1),
        cout => C(1));
   Inst_SC2: Sumador_Completo PORT MAP(  --Instanciación SC2.
        a    => A(2),
        b    => B(2),
        cin  => C(1),
        f    => F(2),
        cout => C(2));
   Inst_SC3: Sumador_Completo PORT MAP(  --Instanciación SC3.
        a    => A(3),
        b    => B(3),
        cin  => C(2),
        f    => F(3),
        cout => Cout);
end Behavioral;