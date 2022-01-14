library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

 entity REG is

 Port (	D:	In	signed(7 downto 0);
                CK:	In	std_logic;
                RESET:	In	std_logic;
                ENABLE: In 	std_logic;
                Q:	Out	signed(7 downto 0));

end entity ;


architecture behavioral of REG is 
begin

process ( CK,RESET) 
begin

if ( CK'event and CK='1') then 
  
  if ( RESET ='0') then 
 Q<= (others=> '0');
 elsif (ENABLE ='1') then
  Q<= D;
end if ;
end if ;
end process ;

end behavioral ;



