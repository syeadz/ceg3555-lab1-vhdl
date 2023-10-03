library ieee;
use ieee.std_logic_1164.all;

entity mux4to1_tb is
end;

architecture rtl of mux4to1_tb is
  signal sel0_tb   : std_logic;
  signal sel1_tb   : std_logic;
  signal enable_tb : std_logic;
  signal d_tb      : std_logic_vector(3 downto 0);
  signal q_tb      : std_logic;

  constant period : time := 10 ns;
begin
  uut : entity work.mux4to1 port map
    (
    sel0   => sel0_tb,
    sel1   => sel1_tb,
    enable => enable_tb,
    d0     => d_tb(0),
    d1     => d_tb(1),
    d2     => d_tb(2),
    d3     => d_tb(3),
    q      => q_tb
    );

  stim_proc : process
  begin
    enable_tb <= '1';
    sel0_tb   <= '0';
    sel1_tb   <= '0';
    d_tb <= "0000";
    wait for period;
    assert q_tb = '0' report "Failed test 1" severity error;

    enable_tb <= '1';
    sel0_tb   <= '0';
    sel1_tb   <= '0';
    d_tb <= "0001";
    wait for period;
    assert q_tb = '1' report "Failed test 2" severity error;

    enable_tb <= '1';
    sel0_tb   <= '1';
    sel1_tb   <= '0';
    d_tb    <= "0010";
    wait for period;
    assert q_tb = '1' report "Failed test 3" severity error;

    enable_tb <= '1';
    sel0_tb   <= '0';
    sel1_tb   <= '1';
    d_tb    <= "0100";
    wait for period;
    assert q_tb = '1' report "Failed test 4" severity error;

    enable_tb <= '1';
    sel0_tb   <= '1';
    sel1_tb   <= '1';
    d_tb    <= "1000";
    wait for period;
    assert q_tb = '1' report "Failed test 5" severity error;

    enable_tb <= '0';
    sel0_tb   <= '1';
    sel1_tb   <= '0';
    d_tb    <= "1111";
    wait for period;
    assert q_tb = '0' report "Failed test 6" severity error;

    report "Testbench finished";
    wait;
  end process;
end architecture;