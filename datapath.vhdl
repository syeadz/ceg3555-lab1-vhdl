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
  signal gMask_data_in, gMask_data_out, gMask_temp : std_logic_vector(7 downto 0) := "00000001";
  signal dMask_data_in, dMask_data_out, dMask_temp : std_logic_vector(7 downto 0) := "10000000";
  signal gMask_or_dMask_data                       : std_logic_vector(7 downto 0);
  signal affichage_data_in, affichage_data_out     : std_logic_vector(7 downto 0) := (others => '0');
begin

  dMaskShftReg : entity work.shftrightreg8bit port map
    (
    clk      => clk,
    reset    => '0',
    enable   => '1',
    data_in  => dMask_data_in,
    data_out => dMask_data_out,
    shift    => selD
    );

  dMask_data_in <= dMask_data_out after 75 ns;


  gMaskShftReg : entity work.shftleftreg8bit port
    map (
    clk      => clk,
    reset    => '0',
    enable   => '1',
    data_in  => gMask_data_in,
    data_out => gMask_data_out,
    shift   => selG
    );

  gMask_data_in <= gMask_data_out after 75 ns;

  gMask_or_dMask_data <= gMask_data_out or dMask_data_out;

  muxAff : entity work.mux32to8 port
    map (
    sel0   => selG,
    sel1   => selD,
    enable => '1',
    d0     => "00000000",
    d1     => gMask_data_out,
    d2     => dMask_data_out,
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