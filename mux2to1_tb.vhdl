library ieee;
use ieee.std_logic_1164.all;

entity mux2to1_tb is
end;

architecture rtl of mux2to1_tb is
  signal sel_tb    : std_logic;
  signal d_tb      : std_logic_vector(1 downto 0);
  signal q_tb      : std_logic;
  signal enable_tb : std_logic;

  constant period : time := 10 ns;
begin
  uut : entity work.mux2to1 port map
    (
    sel    => sel_tb,
    enable => enable_tb,
    d      => d_tb,
    q      => q_tb
    );

  stim_proc : process
  begin

    enable_tb <= '1';

    sel_tb <= '0';
    d_tb   <= "00";
    wait for period;
    assert q_tb = '0' report "m0 failed" severity error;

    sel_tb <= '0';
    d_tb   <= "01";
    wait for period;
    assert q_tb = '0' report "m1 failed" severity error;

    sel_tb <= '0';
    d_tb   <= "10";
    wait for period;
    assert q_tb = '1' report "m2 failed" severity error;

    sel_tb <= '0';
    d_tb   <= "11";
    wait for period;
    assert q_tb = '1' report "m3 failed" severity error;

    sel_tb <= '1';
    d_tb   <= "00";
    wait for period;
    assert q_tb = '0' report "m4 failed" severity error;

    sel_tb <= '1';
    d_tb   <= "01";
    wait for period;
    assert q_tb = '1' report "m5 failed" severity error;

    sel_tb <= '1';
    d_tb   <= "10";
    wait for period;
    assert q_tb = '0' report "m6 failed" severity error;

    sel_tb <= '1';
    d_tb   <= "11";
    wait for period;
    assert q_tb = '1' report "m7 failed" severity error;

    enable_tb <= '0';
    sel_tb    <= '1';
    d_tb      <= "10";
    wait for period;
    assert q_tb = '0' report "enable failed" severity error;

    report "Testbench finished";
    wait;
  end process;
end architecture;