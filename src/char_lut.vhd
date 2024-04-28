library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.numeric_std.all;

entity char_lut is
  port (
    address  : in  std_logic_vector(4 downto 0);
    char_out : out std_logic_vector(7 downto 0)
  );
end entity;

architecture arch_char_lut of char_lut is

  type LUT_t is array (natural range 0 to 26) of integer;
  constant LUT: LUT_t := (
    0 => 122, -- z  0111 1010
	1 => 97, -- a   0110 0001
	2 => 98, -- b   0110 0010
	3 => 99, -- c   0110 0011
	4 => 100, -- d  0110 0100
	5 => 101, -- e  0110 0101
	6 => 102, -- f  0110 0110
	7 => 103, -- g  0110 0111
	8 => 104, -- h  0110 1000
	9 => 105, -- i  0110 1001
	10 => 106, -- j 0110 1010
	11 => 107, -- k 0110 1011
	12 => 108, -- l 0110 1100
	13 => 109, -- m 0110 1101
	14 => 110, -- n 0110 1110
	15 => 111, -- o 0110 1111
	16 => 112, -- p 0111 0000
	17 => 113, -- q 0111 0001
	18 => 114, -- r 0111 0010
	19 => 115, -- s 0111 0011
	20 => 116, -- t 0111 0100
	21 => 117, -- u 0111 0101
	22 => 118, -- v 0111 0110
	23 => 119, -- w 0111 0111
	24 => 120, -- x 0111 1000
	25 => 121, -- y 0111 1001
	26 => 122  -- z 0111 1010 
	);
	
begin
  char_out <= std_logic_vector(to_signed(LUT(to_integer(unsigned(address))),8));
end architecture;