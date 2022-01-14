library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_data.all;

entity reg is 
port ( 
	in_1 : in std_logic_vector (nbit-1 downto 0);
	clk,en,Rst_n : in std_logic;
	out_1 : out std_logic_vector (nbit-1 downto 0));
end entity ;



architecture behavioral of reg is 
begin
--process ( clk) 
--begin
--if ( clk='1' and clk'event ) then
--  if (Rst_n ='0') then
--    out_1 <= (others => '0') ;
--  elsif (en ='1') then
--    out_1 <= in_1;
--  end if ;
--end if;
-- end process ;



process ( clk, rst_n) 
begin
if ( rst_n <= '0' ) then
	out_1 <= (others => '0');
else
		if (clk'event and clk = '1') then
				if ( en = '1') then
					out_1 <= in_1;
				end if;
			
		end if;
end if;
 end process ;
end architecture ; 


