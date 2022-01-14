library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity data_maker is  
  port (
    clk     : in  std_logic;
    rst_n   : in  std_logic;
    Vout    : out std_logic;
    Dout    : out std_logic_vector(7 downto 0);
    H0      : out std_logic_vector(7 downto 0);
    H1      : out std_logic_vector(7 downto 0);
    H2      : out std_logic_vector(7 downto 0);
    H3      : out std_logic_vector(7 downto 0);
	H4   	: out std_logic_vector(7 downto 0);
	H5   	: out std_logic_vector(7 downto 0);
	H6   	: out std_logic_vector(7 downto 0);
    H7  	: out std_logic_vector(7 downto 0);
	H8   	: out std_logic_vector(7 downto 0);
	END_SIM : out std_logic);
end data_maker;

architecture beh of data_maker is

  constant tco : time := 1 ns;

  signal sEndSim : std_logic;
  signal END_SIM_i : std_logic_vector(0 to 10);  

begin  -- beh

  H0 <= conv_std_logic_vector(-1,8);
  H1 <= conv_std_logic_vector(-2,8);
  H2 <= conv_std_logic_vector(6,8);
  H3 <= conv_std_logic_vector(34,8);  
  H4 <= conv_std_logic_vector(51,8);  
  H5 <= conv_std_logic_vector(34,8);  
  H6 <= conv_std_logic_vector(6,8);  
  H7 <= conv_std_logic_vector(-2,8);  
  H8 <= conv_std_logic_vector(-1,8);  

  process (clk, rst_n)
    file fp_in : text open READ_MODE is "./samples_netlist.txt";
    variable line_in : line;
    variable x : integer;
  begin  -- process
    if rst_n = '0' then                 -- asynchronous reset (active low)
      Dout <= (others => '0') after tco;      
  -- Vout <= '0', '1' after 20 ns, '0' after 50 ns, '1' after 70 ns, '0' after 140 ns, '1' after 180 ns;
	  Vout <=  '0', '1' after 18 ns, '0' after 138 ns, '1' after 178 ns;
      --Vout <= '1' after 10 ns;
      sEndSim <= '0' after tco;
    elsif clk'event and clk = '1' then  -- rising clock edge
      if not endfile(fp_in) then
        readline(fp_in, line_in);
        read(line_in, x);
        Dout <= conv_std_logic_vector(x, 8) after tco;
        --Vout <= '1' after 300 ps;
        sEndSim <= '0' after tco;
      else
        Vout <= '0' after tco/2;        
        sEndSim <= '1' after tco;
      end if;
    end if;
  end process;

  process (clk, rst_n)
  begin  -- process
    if rst_n = '0' then                 -- asynchronous reset (active low)
      END_SIM_i <= (others => '0') after tco;
    elsif clk'event and clk = '1' then  -- rising clock edge
      END_SIM_i(0) <= sEndSim after tco;
      END_SIM_i(1 to 10) <= END_SIM_i(0 to 9) after tco;
    end if;
  end process;

  END_SIM <= END_SIM_i(10);  

end beh;
