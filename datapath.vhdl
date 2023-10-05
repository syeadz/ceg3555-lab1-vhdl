library ieee;
use ieee.std_logic_1164.all;

entity datapath is
  port
  (
    clk                      : in std_logic;
    selG, loadGM, leftShift  : in std_logic;
    selD, loadDM, rightShift : in std_logic;
    gReset                   : in std_logic;
    loadA                    : in std_logic;
    led_lights               : out std_logic_vector(7 downto 0)
  );
end entity;

architecture rtl of datapath is
  signal shiftRight, shiftLeft                     : std_logic;
  signal gMask_data_in, gMask_data_out, gMask_temp : std_logic_vector(7 downto 0) := "10000000";
  signal dMask_data_in, dMask_data_out, dMask_temp : std_logic_vector(7 downto 0) := "00000001";
  signal gMask_or_dMask_data                       : std_logic_vector(7 downto 0);
  signal affichage_data_in, affichage_data_out     : std_logic_vector(7 downto 0) := (others => '0');
begin
  muxRightShift : entity work.mux2to1 port map
    (
    sel    => selD,
    d0     => '0',
    d1     => '1',
    enable => '1',
    q      => shiftRight
    );

  dMaskShftReg : entity work.shftrightreg8bit port
    map (
    clk      => clk,
    reset    => '0',
    enable   => loadDM,
    data_in  => gMask_data_in,
    data_out => gMask_data_out
    );

  gMask_temp(0) <= (gmask_data_out(0) and shiftLeft) or (gMask_data_in(0) and not shiftLeft);
  gMask_temp(1) <= (gmask_data_out(1) and shiftLeft) or (gMask_data_in(1) and not shiftLeft);
  gMask_temp(2) <= (gmask_data_out(2) and shiftLeft) or (gMask_data_in(2) and not shiftLeft);
  gMask_temp(3) <= (gmask_data_out(3) and shiftLeft) or (gMask_data_in(3) and not shiftLeft);
  gMask_temp(4) <= (gmask_data_out(4) and shiftLeft) or (gMask_data_in(4) and not shiftLeft);
  gMask_temp(5) <= (gmask_data_out(5) and shiftLeft) or (gMask_data_in(5) and not shiftLeft);
  gMask_temp(6) <= (gmask_data_out(6) and shiftLeft) or (gMask_data_in(6) and not shiftLeft);
  gMask_temp(7) <= (gmask_data_out(7) and shiftLeft) or (gMask_data_in(7) and not shiftLeft);
  gMask_data_in <= gMask_temp after 10 ns;

  muxLeftShift : entity work.mux2to1 port
    map
    (
    sel    => selD,
    d0     => '0',
    d1     => '1',
    enable => '1',
    q      => shiftLeft
    );

  gMaskShftReg : entity work.shftleftreg8bit port
    map (
    clk      => clk,
    reset    => '0',
    enable   => loadGM,
    data_in  => gMask_data_in,
    data_out => dMask_data_out
    );

  dMask_temp(0) <= (dmask_data_out(0) and shiftRight) or (dMask_data_in(0) and not shiftRight);
  dMask_temp(1) <= (dmask_data_out(1) and shiftRight) or (dMask_data_in(1) and not shiftRight);
  dMask_temp(2) <= (dmask_data_out(2) and shiftRight) or (dMask_data_in(2) and not shiftRight);
  dMask_temp(3) <= (dmask_data_out(3) and shiftRight) or (dMask_data_in(3) and not shiftRight);
  dMask_temp(4) <= (dmask_data_out(4) and shiftRight) or (dMask_data_in(4) and not shiftRight);
  dMask_temp(5) <= (dmask_data_out(5) and shiftRight) or (dMask_data_in(5) and not shiftRight);
  dMask_temp(6) <= (dmask_data_out(6) and shiftRight) or (dMask_data_in(6) and not shiftRight);
  dMask_temp(7) <= (dmask_data_out(7) and shiftRight) or (dMask_data_in(7) and not shiftRight);
  dMask_data_in <= dMask_temp after 10 ns;

  gMask_or_dMask_data <= gMask_data_out or dMask_data_out;

  muxAff : entity work.mux32to8 port
    map (
    sel0   => selG,
    sel1   => selD,
    enable => '1',
    d0     => "00000000",
    d1     => dMask_data_out,
    d2     => gMask_data_out,
    d3     => gMask_or_dMask_data,
    q      => affichage_data_in
    );

  affichageReg : entity work.register8bit port
    map (
    clk      => clk,
    reset    => gReset,
    enable   => '1',
    data_in  => affichage_data_in,
    data_out => affichage_data_out
    );

  led_lights <= affichage_data_in;
end rtl;