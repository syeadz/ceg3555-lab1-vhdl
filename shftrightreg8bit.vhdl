library ieee;
use ieee.std_logic_1164.all;

entity shftrightreg8bit is
  port
  (
    clk      : in std_logic;
    reset    : in std_logic;
    enable   : in std_logic;
    data_in  : in std_logic_vector(7 downto 0);
    data_out : out std_logic_vector(7 downto 0);
    shift    : in std_logic
  );
end;

architecture rtl of shftrightreg8bit is
  signal int_data_out                   : std_logic_vector(7 downto 0);
  signal d0, d1, d2, d3, d4, d5, d6, d7 : std_logic;
begin
  d0 <= (data_in(0) and not shift) or (data_in(1) and shift);
  d1 <= (data_in(1) and not shift) or (data_in(2) and shift);
  d2 <= (data_in(2) and not shift) or (data_in(3) and shift);
  d3 <= (data_in(3) and not shift) or (data_in(4) and shift);
  d4 <= (data_in(4) and not shift) or (data_in(5) and shift);
  d5 <= (data_in(5) and not shift) or (data_in(6) and shift);
  d6 <= (data_in(6) and not shift) or (data_in(7) and shift);
  d7 <= (data_in(7) and not shift) or (data_in(0) and shift);

  q0 : entity work.enardFF_2 port map
    (
    i_resetBar => "not"(reset),
    i_d        => d0,
    i_enable   => enable,
    i_clock    => clk,
    o_q        => int_data_out(0),
    o_qBar     => open
    );

  q1 : entity work.enardFF_2 port
    map (
    i_resetBar => "not"(reset),
    i_d        => d1,
    i_enable   => enable,
    i_clock    => clk,
    o_q        => int_data_out(1),
    o_qBar     => open
    );

  q2 : entity work.enardFF_2 port
    map (
    i_resetBar => "not"(reset),
    i_d        => d2,
    i_enable   => enable,
    i_clock    => clk,
    o_q        => int_data_out(2),
    o_qBar     => open
    );

  q3 : entity work.enardFF_2 port
    map (
    i_resetBar => "not"(reset),
    i_d        => d3,
    i_enable   => enable,
    i_clock    => clk,
    o_q        => int_data_out(3),
    o_qBar     => open
    );

  q4 : entity work.enardFF_2 port
    map (
    i_resetBar => "not"(reset),
    i_d        => d4,
    i_enable   => enable,
    i_clock    => clk,
    o_q        => int_data_out(4),
    o_qBar     => open
    );

  q5 : entity work.enardFF_2 port
    map (
    i_resetBar => "not"(reset),
    i_d        => d5,
    i_enable   => enable,
    i_clock    => clk,
    o_q        => int_data_out(5),
    o_qBar     => open
    );

  q6 : entity work.enardFF_2 port
    map (
    i_resetBar => "not"(reset),
    i_d        => d6,
    i_enable   => enable,
    i_clock    => clk,
    o_q        => int_data_out(6),
    o_qBar     => open
    );

  q7 : entity work.enardFF_2 port
    map (
    i_resetBar => "not"(reset),
    i_d        => d7,
    i_enable   => enable,
    i_clock    => clk,
    o_q        => int_data_out(7),
    o_qBar     => open
    );

  data_out <= int_data_out;
end rtl;