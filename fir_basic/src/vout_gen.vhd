library ieee;
use ieee.std_logic_1164.all;

entity vout_gen is
port ( CLK : in std_logic;
		RST_n: in std_logic;
		VIN : in std_logic;
		VOUT : out std_logic );
end entity;

architecture struct of vout_gen is

signal sig : std_logic;

begin

--p1 : process (clk)
--begin
	--if (clk'event and clk = '1') then
		--if (Rst_n = '0') then
			--vout <= '0';
		--else	
			--sig <= vin;	
			--vout <= sig;
			
--		end if;	
--	end if;
--end process;

p1 : process (clk, rst_n)
begin
	if (rst_n = '0') then
		sig <= '0';
		vout <= '0';
else
	if (clk'event and clk = '1') then
		if (vin = '1') then 
			sig <= '1';
			vout <= sig;	
		else
			sig <= '0';
			vout <= sig;	
		end if;
	end if;
	end if;
end process;


end architecture;
