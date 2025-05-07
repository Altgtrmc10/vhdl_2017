library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity contador_reloj_automatico is
    PORT (clk: IN  STD_LOGIC;
          clk_en: IN  STD_LOGIC;
          areset: IN  STD_LOGIC;
          aload: IN  STD_LOGIC;
          data: IN  STD_LOGIC_VECTOR(23 DOWNTO 0);
          cnt_out: OUT STD_LOGIC_VECTOR(23 DOWNTO 0));
end contador_reloj_automatico;

architecture Behavioral of contador_reloj_automatico is
    -- Contador de segundos, minutos, y horas.
    signal cnt_tmp_s: STD_LOGIC_VECTOR(7 DOWNTO 0) := x"00";
    signal cnt_tmp_m: STD_LOGIC_VECTOR(7 DOWNTO 0) := x"00";
    signal cnt_tmp_h: STD_LOGIC_VECTOR(7 DOWNTO 0) := x"00";
    -- Señales de acarreo necesarias.
    signal acarreo_s: STD_LOGIC := '0';
    signal acarreo_m: STD_LOGIC := '0';
begin
    contador_seg: entity work.contador_mod_60 PORT MAP (
        clk     => clk,
        clk_en  => clk_en,
        areset  => areset,
        aload   => aload,
        data    => data(7 DOWNTO 0),
        cnt_out => cnt_tmp_s,
        acarreo => acarreo_s
    );
    contador_min: entity work.contador_mod_60 PORT MAP (
        clk     => acarreo_s,
        clk_en  => clk_en,
        areset  => areset,
        aload   => aload,
        data    => data(15 DOWNTO 8),
        cnt_out => cnt_tmp_m,
        acarreo => acarreo_m
    );
    contador_hr: entity work.contador_mod_24 PORT MAP (
        clk     => acarreo_m,
        clk_en  => clk_en,
        areset  => areset,
        aload   => aload,
        data    => data(23 DOWNTO 16),
        cnt_out => cnt_tmp_h
    );
    cnt_out <= cnt_tmp_h & cnt_tmp_m & cnt_tmp_s;
end Behavioral;