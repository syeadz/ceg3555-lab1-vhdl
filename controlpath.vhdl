library ieee;
use ieee.std_logic_1164.all;

entity controlpath is
  port
  (
    clk, reset, enable, g, d, gReset : in std_logic;
    selG, loadGM, leftShift          : out std_logic;
    selD, loadDM, rightShift         : out std_logic;
    clearA                           : out std_logic;
    loadA                            : out std_logic;
    clk_out                          : out std_logic
  );
end;

architecture rtl of controlpath is
  signal s0, s1, s2, s3, s4 : std_logic;
  signal s0_cond            : std_logic;
  signal s1_cond            : std_logic;
  signal s2_cond            : std_logic;
  signal s3_cond            : std_logic;
  signal s4_cond            : std_logic;
begin
  s0_cond <= not(s1 or s2 or s3 or s4);

  s0_ff : entity work.enardFF_2 port map
    (
    i_resetBar => s0_cond,
    i_d        => '1',
    i_enable   => '1',
    i_clock    => clk,
    o_q        => s0,
    o_qBar     => open
    );
  s1_cond <= g and d;

  s1_ff : entity work.enardFF_2 port
    map
    (
    i_resetBar => "not"(reset),
    i_d        => s1_cond,
    i_enable   => '1',
    i_clock    => clk,
    o_q        => s1,
    o_qBar     => open
    );

  s2_cond <= d and not s1_cond;
  s2_ff : entity work.enardFF_2 port
    map
    (
    i_resetBar => "not"(reset),
    i_d        => s2_cond,
    i_enable   => '1',
    i_clock    => clk,
    o_q        => s2,
    o_qBar     => open
    );

  s3_cond <= g and not s1_cond;

  s3_ff : entity work.enardFF_2 port
    map
    (
    i_resetBar => "not"(reset),
    i_d        => s3_cond,
    i_enable   => '1',
    i_clock    => clk,
    o_q        => s3,
    o_qBar     => open
    );

  s4_cond <= not g and not d;

  s4_ff : entity work.enardFF_2 port
    map
    (
    i_resetBar => "not"(reset),
    i_d        => s4_cond,
    i_enable   => '1',
    i_clock    => clk,
    o_q        => s4,
    o_qBar     => open
    );

  selG       <= g;
  selD       <= d;
  clearA     <= gReset or s4 or s0;
  loadGM     <= '1';
  loadDM     <= '1';
  loadA      <= '1';
  rightShift <= s1 or s2;
  leftShift  <= s1 or s3;
  clk_out    <= clk;
end;