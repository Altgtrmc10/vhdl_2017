library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reloj_digital is
    PORT (clk: IN  STD_LOGIC;
          areset: IN  STD_LOGIC;
          selec: IN  STD_LOGIC;
          increm: IN  STD_LOGIC;
          cancel: IN  STD_LOGIC;
          lucecita: OUT STD_LOGIC;
          edo_out: OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
          -- Entradas adicionales para visualización
          ver_ms: IN  STD_LOGIC;
          seg: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
          mux: OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
end reloj_digital;

architecture Behavioral of reloj_digital is
    type estados_reloj is (
        Reset,
        Automatico,
        IniciarAjuste,
        AjustarMinutos,
        AjustarHoras,
        FinalizarAjuste
    );
    signal estado: estados_reloj := Automatico;
    signal clk1Hz_s: STD_LOGIC := '0';
    signal clk2Hz_s: STD_LOGIC := '0';
    signal clk4Hz_s: STD_LOGIC := '0';
    signal contador_tmp_a: STD_LOGIC_VECTOR(23 DOWNTO 0) := x"000000";
    signal contador_tmp_m: STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0000";
    signal digito3: STD_LOGIC_VECTOR(3 DOWNTO 0) := x"0";
    signal digito2: STD_LOGIC_VECTOR(3 DOWNTO 0) := x"0";
    signal digito1: STD_LOGIC_VECTOR(3 DOWNTO 0) := x"0";
    signal digito0: STD_LOGIC_VECTOR(3 DOWNTO 0) := x"0";
    signal clk_en: STD_LOGIC_VECTOR(1 DOWNTO 0);
    signal aload_a: STD_LOGIC := '0';
    signal aload_m: STD_LOGIC := '0';
    signal data_a: STD_LOGIC_VECTOR(23 DOWNTO 0) := x"000000";
    signal data_m: STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0000";
    signal lucecita_s: STD_LOGIC := '0';
begin
    c1h_i: entity work.clk1Hz PORT MAP (
        clk     => clk,
        reset   => areset,
        clk_out => clk1Hz_s
    );
    c2h_i: entity work.clk2Hz PORT MAP (
        clk     => clk,
        reset   => areset,
        clk_out => clk2Hz_s
    );
    c4h_i: entity work.clk4Hz PORT MAP (
        clk     => clk,
        reset   => areset,
        clk_out => clk4Hz_s
    );
    cnt_a_i: entity work.contador_reloj_automatico PORT MAP (
        clk     => clk1Hz_s,
        clk_en  => '1',
        areset  => areset,
        aload   => aload_a,
        data    => data_a,
        cnt_out => contador_tmp_a
    );
    cnt_m_i: entity work.contador_reloj_manual PORT MAP (
        clk     => clk4Hz_s,
        clk_en  => clk_en,
        areset  => areset,
        aload   => aload_m,
        data    => data_m,
        cnt_out => contador_tmp_m
    );
    seg_i: entity work.siete_segmentos_4bits_completo PORT MAP (
        clk    => clk,
        reset  => areset,
        D0     => digito0,
        D1     => digito1,
        D2     => digito2,
        D3     => digito3,
        salida => seg,
        MUX    => mux
    );
    proceso_visualizador: process (contador_tmp_a, contador_tmp_m, estado, ver_ms) begin
        if (estado = Automatico) then
            if ver_ms = '0' then
                digito3 <= contador_tmp_a(23 DOWNTO 20); -- Horas, decenas
                digito2 <= contador_tmp_a(19 DOWNTO 16); -- Horas, unidades
                digito1 <= contador_tmp_a(15 DOWNTO 12); -- Minutos, decenas
                digito0 <= contador_tmp_a(11 DOWNTO 8); -- Minutos, unidades
            else
                digito3 <= contador_tmp_a(15 DOWNTO 12); -- Minutos, decenas
                digito2 <= contador_tmp_a(11 DOWNTO 8); -- Minutos, unidades
                digito1 <= contador_tmp_a(7 DOWNTO 4); -- Segundos, decenas
                digito0 <= contador_tmp_a(3 DOWNTO 0); -- Segundos, unidades
            end if;
        else
            digito3 <= contador_tmp_m(15 DOWNTO 12); -- Horas, decenas
            digito2 <= contador_tmp_m(11 DOWNTO 8); -- Horas, unidades
            digito1 <= contador_tmp_m(7 DOWNTO 4); -- Minutos, decenas
            digito0 <= contador_tmp_m(3 DOWNTO 0); -- Minutos, unidades
        end if;
    end process;
    proceso_fsm: process (areset, clk4Hz_s, selec) begin
        if (areset = '1') then
            estado <= Reset;
        elsif rising_edge(clk4Hz_s) then
            if (estado = Reset) then
                estado <= Automatico;
            elsif (cancel = '1') then
                estado <= Automatico;
            elsif (estado = IniciarAjuste) then
                estado <= AjustarMinutos;
            elsif (estado = FinalizarAjuste) then
                estado <= Automatico;
            elsif (selec = '1') then
                case estado is
                    when Automatico =>
                        estado <= IniciarAjuste;
                    when AjustarMinutos =>
                        estado <= AjustarHoras;
                    when AjustarHoras =>
                        estado <= FinalizarAjuste;
                    when others =>
                        estado <= Automatico;
                end case;
            end if;
        end if;
    end process;
    proceso_clk_en: process (estado, increm) begin
        case estado is
            when AjustarMinutos =>
                clk_en <= "0" & increm;
            when AjustarHoras =>
                clk_en <= increm & "0";
            when others =>
                clk_en <= "00";
        end case;
    end process;
    proceso_mostrar_estado: process (estado) begin
        case estado is
            when Reset =>
                edo_out <= "111";
            when IniciarAjuste =>
                edo_out <= "110";
            when Automatico =>
                edo_out <= "101";
            when AjustarMinutos =>
                edo_out <= "010";
            when AjustarHoras =>
                edo_out <= "100";
            when FinalizarAjuste =>
                edo_out <= "011";
            when others =>
                edo_out <= "000";
        end case;
    end process;
    proceso_carga: process (clk4Hz_s, estado) begin
        if rising_edge(clk4Hz_s) then
            if (estado = IniciarAjuste) then
                aload_m <= '1';
                aload_a <= '0';
            elsif (estado = FinalizarAjuste) then
                aload_m <= '0';
                aload_a <= '1';
            else
                aload_m <= '0';
                aload_a <= '0';
            end if;
        end if;
    end process;
    data_a <= contador_tmp_m & x"00";
    data_m <= contador_tmp_a(23 DOWNTO 8);
    proceso_sigue_funcionando: process (clk2Hz_s, estado, ver_ms) begin
        if estado /= Automatico OR ver_ms = '1' then
            lucecita_s <= '0';
        elsif rising_edge(clk2Hz_s) then
            lucecita_s <= NOT lucecita_s;
        end if;
    end process;
    lucecita <= lucecita_s;
end Behavioral;