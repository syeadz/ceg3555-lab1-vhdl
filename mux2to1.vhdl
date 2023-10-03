library ieee;
use ieee.std_logic_1164.all;

entity mux2to1 is
  port
  (
    sel    : in std_logic;
    d      : in std_logic_vector(1 downto 0);
    enable : in std_logic;
    q      : out std_logic
  );
end;

architecture rtl of mux2to1 is
begin
  q <= ((not sel and d(1)) or (sel and d(0))) and enable;
end;