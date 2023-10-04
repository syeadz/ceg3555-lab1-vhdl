library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shftleftreg8bit_tb is
end;

architecture rtl of shftleftreg8bit_tb is
  signal clk_tb      : std_logic;
  signal reset_tb    : std_logic;
  signal enable_tb   : std_logic;
  signal data_out_tb : std_logic_vector(7 downto 0);

  signal sim_end  : boolean := false;
  constant period : time    := 50 ns;
begin
  uut : entity work.shftleftreg8bit
    port map
    (
      clk      => clk_tb,
      reset    => reset_tb,
      enable   => enable_tb,
      data_out => data_out_tb
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
    reset_tb <= '0';
    enable_tb <= '1';
    wait for period;

    for i in 0 to 7 loop
      wait for period;
    end loop;

    enable_tb <= '0';
    wait for period;

    for i in 0 to 7 loop
      wait for period;
    end loop;

    sim_end <= true;
    wait;
  end process;

end rtl;