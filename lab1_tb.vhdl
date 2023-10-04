library ieee;
use ieee.std_logic_1164.all;

entity lab1_tb is
end;

architecture rtl of lab1_tb is
  signal clk_tb, enable_tb        : std_logic;
  signal g_tb, d_tb, g_reset_tb : std_logic;
  signal led_signals_tb                     : std_logic_vector(7 downto 0);

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
    enable_tb <= '1';
    g_reset_tb  <= '0';
    g_tb      <= '0';
    d_tb      <= '0';
    wait for period;
    assert (led_signals_tb = "00000000") report "Error 1" severity error;

    g_tb      <= '1';
    d_tb      <= '0';
    wait for period;
    assert led_signals_tb = "00000001" report "Error 2" severity error;

    g_tb      <= '0';
    d_tb      <= '1';
    wait for period;
    assert led_signals_tb = "10000000" report "Error 3" severity error;


    g_tb      <= '1';
    d_tb      <= '1';
    wait for period;
    assert led_signals_tb = "10000001" report "Error 4" severity error;

    g_tb      <= '0';
    d_tb      <= '1';
    wait for period;
    assert led_signals_tb = "01000000" report "Error 5" severity error;

    g_tb      <= '1';
    d_tb      <= '0';
    wait for period;
    assert led_signals_tb = "00000010" report "Error 6" severity error;

    g_tb      <= '1';
    d_tb      <= '1';
    wait for period;
    assert led_signals_tb = "00100100" report "Error 7" severity error;

    g_tb      <= '1';
    d_tb      <= '1';
    wait for period;
    assert led_signals_tb = "00011000" report "Error 8" severity error;


    g_tb      <= '0';
    d_tb      <= '0';
    wait for period;
    assert led_signals_tb = "00000000" report "Error 8" severity error;

    sim_end <= true;
    wait;
  end process;
end rtl;