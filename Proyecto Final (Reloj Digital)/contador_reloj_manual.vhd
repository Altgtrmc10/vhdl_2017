library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity contador_reloj_manual is
    PORT (clk: IN  STD_LOGIC;
          clk_en: IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
          areset: IN  STD_LOGIC;
          aload: IN  STD_LOGIC;
          data: IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
          cnt_out: OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
end contador_reloj_manual;

architecture Behavioral of contador_reloj_manual is
    -- Contadores de minutos, y horas.
    signal cnt_tmp_m: STD_LOGIC_VECTOR(7 DOWNTO 0) := x"00";
    signal cnt_tmp_h: STD_LOGIC_VECTOR(7 DOWNTO 0) := x"00";
begin
    contador_min: entity work.contador_mod_60 PORT MAP (
        clk     => clk,
        clk_en  => clk_en(0),
        areset  => areset,
        aload   => aload,
        data    => data(7 DOWNTO 0),
        cnt_out => cnt_tmp_m,
        acarreo => OPEN
    );
    contador_hr: entity work.contador_mod_24 PORT MAP (
        clk     => clk,
        clk_en  => clk_en(1),
        areset  => areset,
        aload   => aload,
        data    => data(15 DOWNTO 8),
        cnt_out => cnt_tmp_h
    );
    cnt_out <= cnt_tmp_h & cnt_tmp_m;
end Behavioral;