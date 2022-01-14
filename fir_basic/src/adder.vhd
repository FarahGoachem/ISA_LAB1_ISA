library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_data.all;

entity adder is
port(  
	op1 : in signed(nbit-1 downto 0);
	op2 : in signed(nbit-1 downto 0);
	dout : out signed(nbit-1 downto 0)
	);
end entity;

architecture struct of adder is

begin

dout <= op1 + op2;


end architecture;
