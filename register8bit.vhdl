library ieee;
use ieee.std_logic_1164.all;

entity register8bit is
  port
  (
    clk      : in std_logic;
    reset    : in std_logic;
    enable   : in std_logic;
    data_in  : in std_logic_vector(7 downto 0);
    data_out : out std_logic_vector(7 downto 0)
  );
end register8bit;

architecture rtl of register8bit is
  signal int_data_out : std_logic_vector(7 downto 0);
begin
  q0 : entity work.enardFF_2 port map
    (
    i_resetBar => "not"(reset),
    i_d        => data_in(0),
    i_enable   => enable,
    i_clock    => clk,
    o_q        => int_data_out(0),
    o_qBar     => open
    );

  q1 : entity work.enardFF_2 port
    map (
    i_resetBar => "not"(reset),
    i_d        => data_in(1),
    i_enable   => enable,
    i_clock    => clk,
    o_q        => int_data_out(1),
    o_qBar     => open
    );

  q2 : entity work.enardFF_2 port
    map (
    i_resetBar => "not"(reset),
    i_d        => data_in(2),
    i_enable   => enable,
    i_clock    => clk,
    o_q        => int_data_out(2),
    o_qBar     => open
    );

  q3 : entity work.enardFF_2 port
    map (
    i_resetBar => "not"(reset),
    i_d        => data_in(3),
    i_enable   => enable,
    i_clock    => clk,
    o_q        => int_data_out(3),
    o_qBar     => open
    );

  q4 : entity work.enardFF_2 port
    map (
    i_resetBar => "not"(reset),
    i_d        => data_in(4),
    i_enable   => enable,
    i_clock    => clk,
    o_q        => int_data_out(4),
    o_qBar     => open
    );

  q5 : entity work.enardFF_2 port
    map (
    i_resetBar => "not"(reset),
    i_d        => data_in(5),
    i_enable   => enable,
    i_clock    => clk,
    o_q        => int_data_out(5),
    o_qBar     => open
    );

  q6 : entity work.enardFF_2 port
    map (
    i_resetBar => "not"(reset),
    i_d        => data_in(6),
    i_enable   => enable,
    i_clock    => clk,
    o_q        => int_data_out(6),
    o_qBar     => open
    );

  q7 : entity work.enardFF_2 port
    map (
    i_resetBar => "not"(reset),
    i_d        => data_in(7),
    i_enable   => enable,
    i_clock    => clk,
    o_q        => int_data_out(7),
    o_qBar     => open
    );

  data_out <= int_data_out;
end rtl;