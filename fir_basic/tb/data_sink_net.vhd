library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity data_sink is
  port (
    clk   : in std_logic;
    rst_n : in std_logic;
    vin   : in std_logic;
    Din   : in std_logic_vector(7 downto 0));
end data_sink;

architecture beh of data_sink is

begin  -- beh

  process (clk, rst_n)
    file res_fp : text open WRITE_MODE is "./results_net.txt";
    variable line_out : line;    
  begin  -- process
    if rst_n = '0' then                 -- asynchronous reset (active low)
      null;
    elsif clk'event and clk = '1' then  -- rising clock edge
      if (vin = '1') then
        write(line_out, conv_integer(signed(Din)));
        writeline(res_fp, line_out);
      end if;
    end if;
  end process;

end beh;
