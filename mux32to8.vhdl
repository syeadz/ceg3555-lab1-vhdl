library ieee;
use ieee.std_logic_1164.all;

entity mux32to8 is
  port
  (
    sel0, sel1     : in std_logic;
    d0, d1, d2, d3 : in std_logic_vector(7 downto 0);
    enable         : in std_logic;
    q              : out std_logic_vector(7 downto 0)
  );
end;

architecture rtl of mux32to8 is
begin
  mux0 : entity work.mux4to1 port map
    (
    sel0   => sel0,
    sel1   => sel1,
    enable => enable,
    d0     => d0(0),
    d1     => d1(0),
    d2     => d2(0),
    d3     => d3(0),
    q      => q(0)
    );

  mux1 : entity work.mux4to1 port
    map (
    sel0   => sel0,
    sel1   => sel1,
    enable => enable,
    d0     => d0(1),
    d1     => d1(1),
    d2     => d2(1),
    d3     => d3(1),
    q      => q(1)
    );

  mux2 : entity work.mux4to1 port
    map (
    sel0   => sel0,
    sel1   => sel1,
    enable => enable,
    d0     => d0(2),
    d1     => d1(2),
    d2     => d2(2),
    d3     => d3(2),
    q      => q(2)
    );

  mux3 : entity work.mux4to1 port
    map (
    sel0   => sel0,
    sel1   => sel1,
    enable => enable,
    d0     => d0(3),
    d1     => d1(3),
    d2     => d2(3),
    d3     => d3(3),
    q      => q(3)
    );

  mux4 : entity work.mux4to1 port
    map (
    sel0   => sel0,
    sel1   => sel1,
    enable => enable,
    d0     => d0(4),
    d1     => d1(4),
    d2     => d2(4),
    d3     => d3(4),
    q      => q(4)
    );

  mux5 : entity work.mux4to1 port
    map (
    sel0   => sel0,
    sel1   => sel1,
    enable => enable,
    d0     => d0(5),
    d1     => d1(5),
    d2     => d2(5),
    d3     => d3(5),
    q      => q(5)
    );

  mux6 : entity work.mux4to1 port
    map (
    sel0   => sel0,
    sel1   => sel1,
    enable => enable,
    d0     => d0(6),
    d1     => d1(6),
    d2     => d2(6),
    d3     => d3(6),
    q      => q(6)
    );

  mux7 : entity work.mux4to1 port
    map (
    sel0   => sel0,
    sel1   => sel1,
    enable => enable,
    d0     => d0(7),
    d1     => d1(7),
    d2     => d2(7),
    d3     => d3(7),
    q      => q(7)
    );
end;