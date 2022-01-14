library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

 entity FD is

 Port (	D:	In	std_logic;
                CK:	In	std_logic;
                RESET:	In	std_logic;
                ENABLE: In 	std_logic;
                Q:	Out	std_logic );

end entity ;


architecture behavioral of FD is 
begin

process ( CK) 
begin

if ( CK'event and CK='1') then 
  
  if ( RESET ='0') then 
 Q<= '0';
 elsif (ENABLE ='1') then
  Q<= D;
end if ;
end if ;
end process ;



end behavioral ;

