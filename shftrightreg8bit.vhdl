library ieee;
use ieee.std_logic_1164.all;

entity shftrightreg8bit is
  port
  (
    clk      : in std_logic;
    reset    : in std_logic;
    enable   : in std_logic;
    data_out : out std_logic_vector(7 downto 0)
  );
end;

architecture rtl of shftrightreg8bit is
  signal feedback  : std_logic_vector(7 downto 0) := "10000000";
  signal int_data_out : std_logic_vector(7 downto 0);
begin
  reg0 : entity work.register8bit port map (
    clk      => clk,
    reset    => reset,
    enable   => enable,
    data_in  => feedback,
    data_out => int_data_out
  );

  data_out <= int_data_out;

  feedback <= int_data_out(0) & int_data_out(7 downto 1) after 10 ns;
end rtl;