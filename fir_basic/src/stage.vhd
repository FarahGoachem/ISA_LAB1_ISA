library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_data.all;

entity stage is
port (  clk, rst_n, enable : in std_logic;
		reg_in : in signed(nbit-1 downto 0);
		sum_in : in signed(nbit -1 downto 0);
		b_coeff : in std_logic_vector(nbit-1 downto 0);
		reg_out : out signed(nbit-1 downto 0);
		sum_out : out signed(nbit-1 downto 0) );

end entity;

architecture struct of stage is

component multiplier is
port( 
	op1 : in signed(nbit-1 downto 0);
	op2 : in signed(nbit-1 downto 0);
	dout : out signed(2*nbit-1 downto 0)
	);
end component;

component adder is
port( 
	op1 : in signed(nbit-1 downto 0);
	op2 : in signed(nbit-1 downto 0);
	dout : out signed(nbit-1 downto 0)
	);
end component;

component reg is
port ( 
	in_1 : in std_logic_vector (nbit-1 downto 0);
	clk,en,Rst_n : in std_logic;
	out_1 : out std_logic_vector (nbit-1 downto 0));
end component;

signal sig_reg_out : std_logic_vector(nbit -1 downto 0);
signal sig_reg_out_signed : signed(nbit-1 downto 0);
signal sig_mul_out : signed(2*nbit-1 downto 0);

begin

FF : reg port map(std_logic_vector(reg_in), clk, enable, rst_n, sig_reg_out);

sig_reg_out_signed <= signed(sig_reg_out);

mul : multiplier port map(sig_reg_out_signed, signed(b_coeff), sig_mul_out);

add : adder port map(sig_mul_out(2*nbit-1 downto nbit), sum_in, sum_out); 

reg_out <= signed(sig_reg_out);


end architecture;


