library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity clk_gen is
  port (
    END_SIM : in  std_logic;
    clk     : out std_logic;
    rst_n   : out std_logic);
end clk_gen;

architecture beh of clk_gen is

  constant Ts : time := 10 ns;
  
  signal clk_i : std_logic;
  
begin  -- beh

  process
  begin  -- process
    if (clk_i = 'U') then
      clk_i <= '0';
    else
      clk_i <= not(clk_i);
    end if;
    wait for Ts/2;
  end process;

  clk <= clk_i and not(END_SIM);

  process
  begin  -- process
    rst_n <= '0';
    wait for 2*Ts/2;
    rst_n <= '1';
    wait;
  end process;

end beh;
