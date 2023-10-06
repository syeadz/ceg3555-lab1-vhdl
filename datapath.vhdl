library ieee;
use ieee.std_logic_1164.all;

entity datapath is
  port
  (
    clk                      : in std_logic;
    selG, loadGM, leftShift  : in std_logic;
    selD, loadDM, rightShift : in std_logic;
    clearA                   : in std_logic;
    loadA                    : in std_logic;
    led_signals              : out std_logic_vector(7 downto 0)
  );
end entity;

architecture rtl of datapath is
  signal gMask_data_in, gMask_data_out : std_logic_vector(7 downto 0) := "00000001";
  signal dMask_data_in, dMask_data_out : std_logic_vector(7 downto 0) := "10000000";

  signal gMask_enable, dMask_enable : std_logic := '1';
  signal gMask_or_dMask_data        : std_logic_vector(7 downto 0);

  signal aff_data_in, aff_data_out : std_logic_vector(7 downto 0) := (others => '0');

  signal temp_data : std_logic_vector(7 downto 0) := (others => '0');
begin

  dmask_enable <= selD and loadDM after 10 ns;

  dMaskShftReg : entity work.shftrightreg8bit port map
    (
    clk      => clk,
    reset    => '0',
    enable   => dmask_enable,
    data_in  => dMask_data_in,
    data_out => dMask_data_out
    );

  dMask_data_in <= dMask_data_out(0) & dMask_data_out(7 downto 1) after 10 ns;
  
  gmask_enable  <= selG and loadGM after 10 ns;

  gMaskShftReg : entity work.shftleftreg8bit port
    map (
    clk      => clk,
    reset    => '0',
    enable   => gmask_enable,
    data_in  => gMask_data_in,
    data_out => gMask_data_out
    );

  gMask_data_in       <= gMask_data_out(6 downto 0) & gMask_data_out(7) after 10 ns;
  
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
    q      => aff_data_in
    );

  affichageReg : entity work.register8bit port
    map (
    clk      => clk,
    reset    => clearA,
    enable   => '1',
    data_in  => aff_data_in,
    data_out => aff_data_out
    );

  aff_data_in(0) <= (gmask_data_out(0) and selG) or (dmask_data_out(0) and selD);
  aff_data_in(1) <= (gmask_data_out(1) and selG) or (dmask_data_out(1) and selD);
  aff_data_in(2) <= (gmask_data_out(2) and selG) or (dmask_data_out(2) and selD);
  aff_data_in(3) <= (gmask_data_out(3) and selG) or (dmask_data_out(3) and selD);
  aff_data_in(4) <= (gmask_data_out(4) and selG) or (dmask_data_out(4) and selD);
  aff_data_in(5) <= (gmask_data_out(5) and selG) or (dmask_data_out(5) and selD);
  aff_data_in(6) <= (gmask_data_out(6) and selG) or (dmask_data_out(6) and selD);
  aff_data_in(7) <= (gmask_data_out(7) and selG) or (dmask_data_out(7) and selD);

  led_signals <= aff_data_in;
end rtl;