library ieee;
use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;

package my_data is
	constant nbit: integer := 8;
	constant fil_order: integer := 8;
	constant n_coeff: integer := (fil_order+1);
	type b_coeff is array(natural range <>) of std_logic_vector(nbit-1 downto 0);
end package;
