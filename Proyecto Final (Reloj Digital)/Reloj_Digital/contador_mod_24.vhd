library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity contador_mod_24 is
    PORT (clk: IN  STD_LOGIC;
          clk_en: IN  STD_LOGIC;
          areset: IN  STD_LOGIC;
          aload: IN  STD_LOGIC;
          data: IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
          cnt_out: OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
end contador_mod_24;

architecture Behavioral of contador_mod_24 is
    -- Señal temporal para el contador.
    signal cnt_tmp_u: STD_LOGIC_VECTOR(3 DOWNTO 0) := x"0";
    signal cnt_tmp_d: STD_LOGIC_VECTOR(3 DOWNTO 0) := x"0";
begin
    proceso_contador: process (aload, areset, clk, clk_en, data) begin
        if areset = '1' then
            cnt_tmp_u <= x"0";
            cnt_tmp_d <= x"0";
        elsif aload = '1' then
            cnt_tmp_u <= data(3 DOWNTO 0);
            cnt_tmp_d <= data(7 DOWNTO 4);
        elsif rising_edge(clk) then
            if clk_en = '1' then
                if cnt_tmp_d = x"2" AND cnt_tmp_u = x"3" then
                    cnt_tmp_u <= x"0";
                    cnt_tmp_d <= x"0";
                elsif cnt_tmp_u = "1001" then
                    cnt_tmp_d <= cnt_tmp_d + 1;
                    cnt_tmp_u <= x"0";
                else
                    cnt_tmp_u <= cnt_tmp_u + 1;
                end if;
            end if;
        end if;
    end process;
    cnt_out <= cnt_tmp_d & cnt_tmp_u;
end Behavioral;