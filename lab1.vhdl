library ieee;
use ieee.std_logic_1164.all;

entity lab1 is
  port
  (
    clk, enable   : in std_logic;
    g, d, g_reset : in std_logic;
    led_signals   : out std_logic_vector(7 downto 0)
  );
end;

architecture rtl of lab1 is
  signal aff_data_in  : std_logic_vector(7 downto 0) := "00000000";
  signal aff_data_out : std_logic_vector(7 downto 0) := "00000000";

  signal gmask_data_out : std_logic_vector(7 downto 0) := "00000001";
  signal gmask_enable   : std_logic                    := '1';

  signal dmask_data_out : std_logic_vector(7 downto 0) := "10000000";
  signal dmask_enable   : std_logic                    := '1';

  signal mask_reset : std_logic := '0';
begin
  aff : entity work.register8bit port map
    (
    clk      => clk,
    reset    => g_reset,
    enable   => enable,
    data_in  => aff_data_in,
    data_out => aff_data_out
    );

  gmask : entity work.shftleftreg8bit port
    map
    (
    clk      => clk,
    reset    => mask_reset,
    enable   => gmask_enable,
    data_out => gmask_data_out
    );

  dmask : entity work.shftrightreg8bit port
    map
    (
    clk      => clk,
    reset    => mask_reset,
    enable   => dmask_enable,
    data_out => dmask_data_out
    );

  gmask_enable   <= g and not g_reset after 10 ns;
  dmask_enable   <= d and not g_reset after 10 ns;
  aff_data_in(0) <= (gmask_data_out(0) and g and not g_reset) or (dmask_data_out(0) and d and not g_reset);
  aff_data_in(1) <= (gmask_data_out(1) and g and not g_reset) or (dmask_data_out(1) and d and not g_reset);
  aff_data_in(2) <= (gmask_data_out(2) and g and not g_reset) or (dmask_data_out(2) and d and not g_reset);
  aff_data_in(3) <= (gmask_data_out(3) and g and not g_reset) or (dmask_data_out(3) and d and not g_reset);
  aff_data_in(4) <= (gmask_data_out(4) and g and not g_reset) or (dmask_data_out(4) and d and not g_reset);
  aff_data_in(5) <= (gmask_data_out(5) and g and not g_reset) or (dmask_data_out(5) and d and not g_reset);
  aff_data_in(6) <= (gmask_data_out(6) and g and not g_reset) or (dmask_data_out(6) and d and not g_reset);
  aff_data_in(7) <= (gmask_data_out(7) and g and not g_reset) or (dmask_data_out(7) and d and not g_reset);

  led_signals <= aff_data_in;
end;