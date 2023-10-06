library ieee;
use ieee.std_logic_1164.all;

entity controlpath_tb is
end;

architecture rtl of controlpath_tb is
  signal clk_tb, reset_tb, enable_tb : std_logic;
  signal g_tb, d_tb, gReset_tb       : std_logic;
  signal sim_end                     : boolean;

  constant period : time := 50 ns;
begin
  uut : entity work.controlpath port map
    (
    clk    => clk_tb,
    reset  => reset_tb,
    enable => enable_tb,
    g      => g_tb,
    d      => d_tb,
    gReset => gReset_tb
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
    reset_tb  <= '0';
    enable_tb <= '1';
    g_tb      <= '0';
    d_tb      <= '0';
    gReset_tb <= '0';
    wait for period;

    g_tb      <= '1';
    d_tb      <= '1';
    gReset_tb <= '0';
    wait for period;

    g_tb      <= '0';
    d_tb      <= '1';
    gReset_tb <= '0';
    wait for period;

    g_tb      <= '1';
    d_tb      <= '0';
    gReset_tb <= '0';
    wait for period;

    g_tb      <= '1';
    d_tb      <= '1';
    gReset_tb <= '1';
    wait for period;

    sim_end <= true;
    wait;
  end process;
end;