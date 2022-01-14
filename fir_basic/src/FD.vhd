library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_data.all;

entity FD is 
port ( 
	in_1 : in std_logic;
	clk,en,Rst_n : in std_logic;
	out_1 : out std_logic);
end entity ;



architecture behavioral of FD is 
begin


process ( clk, rst_n) 
begin
if ( rst_n <= '0' ) then
	out_1 <=  '0';
else
		if (clk'event and clk = '1') then
				if ( en = '1') then
					out_1 <= in_1;
				end if;
			
		end if;
end if;
 end process ;
end architecture ; 

