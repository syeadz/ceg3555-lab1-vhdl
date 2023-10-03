library ieee;
use ieee.std_logic_1164.all;

entity mux2to1_tb is
end;

architecture rtl of mux2to1_tb is
  signal sel_tb    : std_logic;
  signal d0_tb     : std_logic;
  signal d1_tb     : std_logic;
  signal q_tb      : std_logic;
  signal enable_tb : std_logic;

  constant period : time := 10 ns;
begin
  uut : entity work.mux2to1 port map
    (
    sel    => sel_tb,
    enable => enable_tb,
    d0     => d0_tb,
    d1     => d1_tb,
    q      => q_tb
    );

  stim_proc : process
  begin

    enable_tb <= '1';

    sel_tb <= '0';
    d0_tb  <= '0';
    d1_tb  <= '0';
    wait for period;
    assert q_tb = '0' report "m0 failed" severity error;

    sel_tb <= '0';
    d0_tb  <= '0';
    d1_tb  <= '1';
    wait for period;
    assert q_tb = '0' report "m1 failed" severity error;

    sel_tb <= '0';
    d0_tb  <= '1';
    d1_tb  <= '0';
    wait for period;
    assert q_tb = '1' report "m2 failed" severity error;

    sel_tb <= '0';
    d0_tb  <= '1';
    d1_tb  <= '1';
    wait for period;
    assert q_tb = '1' report "m3 failed" severity error;

    sel_tb <= '1';
    d0_tb  <= '0';
    d1_tb  <= '0';
    wait for period;
    assert q_tb = '0' report "m4 failed" severity error;

    sel_tb <= '1';
    d0_tb  <= '0';
    d1_tb  <= '1';
    wait for period;
    assert q_tb = '1' report "m5 failed" severity error;

    sel_tb <= '1';
    d0_tb  <= '1';
    d1_tb  <= '0';
    wait for period;
    assert q_tb = '0' report "m6 failed" severity error;

    sel_tb <= '1';
    d0_tb  <= '1';
    d1_tb  <= '1';
    wait for period;
    assert q_tb = '1' report "m7 failed" severity error;

    enable_tb <= '0';
    sel_tb    <= '1';
    d0_tb     <= '1';
    d1_tb     <= '1';
    wait for period;
    assert q_tb = '0' report "enable failed" severity error;

    report "Testbench finished";
    wait;
  end process;
end architecture;