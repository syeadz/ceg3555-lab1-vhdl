library ieee;
use ieee.std_logic_1164.all;

entity lab1_tb is
end;

architecture rtl of lab1_tb is
  signal clk_tb, enable_tb      : std_logic;
  signal g_tb, d_tb, g_reset_tb : std_logic;
  signal led_signals_tb         : std_logic_vector(7 downto 0);

  signal sim_end  : boolean := false;
  constant period : time    := 50 ns;
begin
  uut : entity work.lab1
    port map
    (
      clk         => clk_tb,
      enable      => enable_tb,
      g           => g_tb,
      d           => d_tb,
      g_reset     => g_reset_tb,
      led_signals => led_signals_tb
    );

  clock_process : process
  begin
    while (not sim_end) loop
      clk_tb <= '1';
      wait for period/2;
      clk_tb <= '0';
      wait for period/2;
    end loop;
    wait;
  end process;

  stim_proc : process
  begin
    enable_tb  <= '1';
    g_reset_tb <= '0';
    g_tb       <= '0';
    d_tb       <= '0';
    wait for period;
    assert (led_signals_tb = "00000000") report "Error 1" severity error;

    g_tb <= '1';
    d_tb <= '0';
    wait for period;
    assert led_signals_tb = "00000001" report "Error 2" severity error;

    g_tb <= '0';
    d_tb <= '1';
    wait for period;
    assert led_signals_tb = "10000000" report "Error 3" severity error;
    g_tb <= '1';
    d_tb <= '1';
    wait for period;
    assert led_signals_tb = "01000010" report "Error 4" severity error;

    g_tb <= '0';
    d_tb <= '1';
    wait for period;
    assert led_signals_tb = "00100000" report "Error 5" severity error;

    g_tb <= '1';
    d_tb <= '0';
    wait for period;
    assert led_signals_tb = "00000100" report "Error 6" severity error;

    g_tb <= '1';
    d_tb <= '1';
    wait for period;
    assert led_signals_tb = "00011000" report "Error 7" severity error;

    g_tb <= '1';
    d_tb <= '1';
    wait for period;
    assert led_signals_tb = "00011000" report "Error 8" severity error;
    g_tb <= '0';
    d_tb <= '0';
    wait for period;
    assert led_signals_tb = "00000000" report "Error 9" severity error;

    g_tb <= '0';
    d_tb <= '0';
    wait for period;
    assert led_signals_tb = "00000000" report "Error 10" severity error;

    g_tb <= '1';
    d_tb <= '1';
    wait for period;
    assert led_signals_tb = "00100100" report "Error 11" severity error;

    g_tb <= '1';
    d_tb <= '0';
    wait for period;
    assert led_signals_tb = "01000000" report "Error 12" severity error;

    g_tb <= '0';
    d_tb <= '1';
    wait for period;
    assert led_signals_tb = "00000010" report "Error 13" severity error;

    g_tb <= '0';
    d_tb <= '0';
    wait for period;
    assert led_signals_tb = "00000000" report "Error 14" severity error;

    g_tb <= '1';
    d_tb <= '0';
    wait for period;
    assert led_signals_tb = "10000000" report "Error 15" severity error;

    g_tb <= '1';
    d_tb <= '0';
    wait for period;
    assert led_signals_tb = "00000001" report "Error 16" severity error;

    g_tb <= '0';
    d_tb <= '1';
    wait for period;
    assert led_signals_tb = "00000001" report "Error 17" severity error;

    g_tb <= '0';
    d_tb <= '1';
    wait for period;
    assert led_signals_tb = "10000000" report "Error 18" severity error;
    g_tb <= '1';
    d_tb <= '1';
    wait for period;
    assert led_signals_tb = "01000010" report "Error 19" severity error;

    g_tb       <= '1';
    d_tb       <= '1';
    g_reset_tb <= '1';
    wait for period;
    assert led_signals_tb = "00000000" report "Error 19" severity error;

    g_tb       <= '1';
    d_tb       <= '1';
    g_reset_tb <= '1';
    wait for period;
    assert led_signals_tb = "00000000" report "Error 19" severity error;

    g_tb       <= '1';
    d_tb       <= '1';
    g_reset_tb <= '0';
    wait for period;
    assert led_signals_tb = "00100100" report "Error 20" severity error;

    g_tb       <= '0';
    d_tb       <= '1';
    g_reset_tb <= '0';
    wait for period;
    assert led_signals_tb = "00010000" report "Error 21" severity error;

    g_tb       <= '1';
    d_tb       <= '0';
    g_reset_tb <= '0';
    wait for period;
    assert led_signals_tb = "00001000" report "Error 22" severity error;

    g_tb       <= '0';
    d_tb       <= '0';
    g_reset_tb <= '0';
    wait for period;
    assert led_signals_tb = "00000000" report "Error 23" severity error;

    g_tb       <= '0';
    d_tb       <= '0';
    g_reset_tb <= '0';
    wait for period;
    assert led_signals_tb = "00000000" report "Error 24" severity error;

    g_tb       <= '1';
    d_tb       <= '0';
    g_reset_tb <= '0';
    wait for period;
    assert led_signals_tb = "00010000" report "Error 25" severity error;

    g_tb       <= '0';
    d_tb       <= '1';
    g_reset_tb <= '0';
    wait for period;
    assert led_signals_tb = "00001000" report "Error 26" severity error;

    sim_end <= true;
    wait;
  end process;
end rtl;