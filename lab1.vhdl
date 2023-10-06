library ieee;
use ieee.std_logic_1164.all;

entity lab1 is
  port
  (
    clk, enable, reset : in std_logic;
    g, d, g_reset      : in std_logic;
    led_signals        : out std_logic_vector(7 downto 0)
  );
end;

architecture rtl of lab1 is
  signal selG, loadGM, leftShift  : std_logic;
  signal selD, loadDM, rightShift : std_logic;
  signal clearA                   : std_logic;
  signal loadA                    : std_logic;
  signal clk_out                  : std_logic;
begin
  controlpath : entity work.controlpath port map
    (
    clk        => clk,
    enable     => enable,
    reset      => reset,
    g          => g,
    d          => d,
    gReset     => g_reset,
    selG       => selG,
    selD       => selD,
    loadA      => loadA,
    clearA     => clearA,
    loadGM     => loadGM,
    loadDM     => loadDM,
    leftShift  => leftShift,
    rightShift => rightShift
    );

  datapath : entity work.datapath port
    map
    (
    clk         => clk,
    selG        => selG,
    selD        => selD,
    loadA       => loadA,
    clearA      => clearA,
    loadGM      => loadGM,
    loadDM      => loadDM,
    leftShift   => leftShift,
    rightShift  => rightShift,
    led_signals => led_signals
    );
end;