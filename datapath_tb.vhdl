library ieee;
use ieee.std_logic_1164.all;

entity datapath_tb is
end entity;

architecture rtl of datapath_tb is
  signal clk_tb                            : std_logic;
  signal selG_tb, loadGM_tb, leftShift_tb  : std_logic;
  signal selD_tb, loadDM_tb, rightShift_tb : std_logic;
  signal gReset_tb                         : std_logic;
  signal loadA_tb                          : std_logic;

  signal led_signals_tb                    : std_logic_vector(7 downto 0);

  signal sim_end  : boolean := false;
  constant period : time    := 50 ns;
begin
  uut : entity work.datapath port map
    (
    clk        => clk_tb,
    selG       => selG_tb,
    loadGM     => loadGM_tb,
    leftShift  => leftShift_tb,
    selD       => selD_tb,
    loadDM     => loadDM_tb,
    rightShift => rightShift_tb,
    gReset     => gReset_tb,
    loadA      => loadA_tb,
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
    gReset_tb <= '0';
    selG_tb       <= '0';
    selD_tb       <= '0';
    wait for period;
    assert (led_signals_tb = "00000000") report "Error 1" severity error;

    selG_tb <= '1';
    selD_tb <= '0';
    wait for period;
    assert led_signals_tb = "00000001" report "Error 2" severity error;

    selG_tb <= '0';
    selD_tb <= '1';
    wait for period;
    assert led_signals_tb = "10000000" report "Error 3" severity error;
    selG_tb <= '1';
    selD_tb <= '1';
    wait for period;
    assert led_signals_tb = "01000010" report "Error 4" severity error;

    selG_tb <= '0';
    selD_tb <= '1';
    wait for period;
    assert led_signals_tb = "00100000" report "Error 5" severity error;

    selG_tb <= '1';
    selD_tb <= '0';
    wait for period;
    assert led_signals_tb = "00000100" report "Error 6" severity error;

    selG_tb <= '1';
    selD_tb <= '1';
    wait for period;
    assert led_signals_tb = "00011000" report "Error 7" severity error;

    selG_tb <= '1';
    selD_tb <= '1';
    wait for period;
    assert led_signals_tb = "00011000" report "Error 8" severity error;
    selG_tb <= '0';
    selD_tb <= '0';
    wait for period;
    assert led_signals_tb = "00000000" report "Error 9" severity error;

    selG_tb <= '0';
    selD_tb <= '0';
    wait for period;
    assert led_signals_tb = "00000000" report "Error 10" severity error;

    selG_tb <= '1';
    selD_tb <= '1';
    wait for period;
    assert led_signals_tb = "00100100" report "Error 11" severity error;

    selG_tb <= '1';
    selD_tb <= '0';
    wait for period;
    assert led_signals_tb = "01000000" report "Error 12" severity error;

    selG_tb <= '0';
    selD_tb <= '1';
    wait for period;
    assert led_signals_tb = "00000010" report "Error 13" severity error;

    selG_tb <= '0';
    selD_tb <= '0';
    wait for period;
    assert led_signals_tb = "00000000" report "Error 14" severity error;

    selG_tb <= '1';
    selD_tb <= '0';
    wait for period;
    assert led_signals_tb = "10000000" report "Error 15" severity error;

    selG_tb <= '1';
    selD_tb <= '0';
    wait for period;
    assert led_signals_tb = "00000001" report "Error 16" severity error;

    selG_tb <= '0';
    selD_tb <= '1';
    wait for period;
    assert led_signals_tb = "00000001" report "Error 17" severity error;

    selG_tb <= '0';
    selD_tb <= '1';
    wait for period;
    assert led_signals_tb = "10000000" report "Error 18" severity error;

    selG_tb <= '1';
    selD_tb <= '1';
    wait for period;
    assert led_signals_tb = "01000010" report "Error 19" severity error;

    selG_tb       <= '1';
    selD_tb       <= '1';
    gReset_tb <= '1';
    wait for period;
    assert led_signals_tb = "00000000" report "Error 20" severity error;

    selG_tb       <= '1';
    selD_tb       <= '1';
    gReset_tb <= '1';
    wait for period;
    assert led_signals_tb = "00000000" report "Error 21" severity error;

    selG_tb       <= '1';
    selD_tb       <= '1';
    gReset_tb <= '0';
    wait for period;
    assert led_signals_tb = "00100100" report "Error 22" severity error;

    selG_tb       <= '0';
    selD_tb       <= '1';
    gReset_tb <= '0';
    wait for period;
    assert led_signals_tb = "00010000" report "Error 23" severity error;

    selG_tb       <= '1';
    selD_tb       <= '0';
    gReset_tb <= '0';
    wait for period;
    assert led_signals_tb = "00001000" report "Error 24" severity error;

    selG_tb       <= '0';
    selD_tb       <= '0';
    gReset_tb <= '0';
    wait for period;
    assert led_signals_tb = "00000000" report "Error 25" severity error;

    selG_tb       <= '0';
    selD_tb       <= '0';
    gReset_tb <= '0';
    wait for period;
    assert led_signals_tb = "00000000" report "Error 26" severity error;

    selG_tb       <= '1';
    selD_tb       <= '0';
    gReset_tb <= '0';
    wait for period;
    assert led_signals_tb = "00010000" report "Error 27" severity error;

    selG_tb       <= '0';
    selD_tb       <= '1';
    gReset_tb <= '0';
    wait for period;
    assert led_signals_tb = "00001000" report "Error 28" severity error;

    sim_end <= true;
    wait;
  end process;
end;