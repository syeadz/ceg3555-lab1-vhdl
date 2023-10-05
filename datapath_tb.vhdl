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
    loadA      => loadA_tb
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
    gReset_tb     <= '0';
    selG_tb       <= '0';
    loadGM_tb     <= '1';
    leftShift_tb  <= '0';
    selD_tb       <= '0';
    loadDM_tb     <= '1';
    rightShift_tb <= '0';
    loadA_tb      <= '0';
    wait for period*2;

    selG_tb       <= '1';
    selD_tb       <= '0';
    wait for period*2;

    selG_tb       <= '1';
    selD_tb       <= '0';
    wait for period*2;

    selG_tb       <= '0';
    selD_tb       <= '1';
    wait for period*2;

    selG_tb       <= '0';
    selD_tb       <= '1';
    wait for period*2;

    selG_tb       <= '1';
    selD_tb       <= '1';
    wait for period*2;

    selG_tb       <= '1';
    selD_tb       <= '1';
    wait for period*2;

    sim_end <= true;
    wait;
  end process;
end;