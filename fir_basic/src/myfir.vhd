library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_data.all;

entity myfir is 
port(
	clk : in std_logic;
	rst_n : in std_logic;
	Din : in std_logic_vector(7 downto 0);
	vin : in std_logic;
	H0 : in std_logic_vector(7 downto 0);
	H1 : in std_logic_vector(7 downto 0);
	H2 : in std_logic_vector(7 downto 0);
	H3 : in std_logic_vector(7 downto 0);
	H4 : in std_logic_vector(7 downto 0);
	H5 : in std_logic_vector(7 downto 0);
	H6 : in std_logic_vector(7 downto 0);
	H7 : in std_logic_vector(7 downto 0);
	H8 : in std_logic_vector(7 downto 0);
	Dout : out std_logic_vector (7 downto 0);
	Vout : out std_logic
	);
end entity;

architecture struct of myfir is

component stage is
port (  clk, rst_n, enable : in std_logic;
		reg_in : in signed(nbit-1 downto 0);
		sum_in : in signed(nbit -1 downto 0);
		b_coeff : in std_logic_vector(nbit-1 downto 0);
		reg_out : out signed(nbit-1 downto 0);
		sum_out : out signed(nbit-1 downto 0) );
end component;

component multiplier is
port( 
	op1 : in signed(nbit-1 downto 0);
	op2 : in signed(nbit-1 downto 0);
	dout : out signed(2*nbit-1 downto 0)
	);
end component;

component vout_gen is
port ( CLK : in std_logic;
		RST_n: in std_logic;
		VIN : in std_logic;
		VOUT : out std_logic );
end component;

component reg is
port ( 
	in_1 : in std_logic_vector (nbit-1 downto 0);
	clk,en,Rst_n : in std_logic;
	out_1 : out std_logic_vector (nbit-1 downto 0));
end component;

component FD is
port ( 
	in_1 : in std_logic;
	clk,en,Rst_n : in std_logic;
	out_1 : out std_logic);
end component;

--signals for keeping all the coefficient together
type coeff_matrix is array (0 to fil_order) of std_logic_vector(nbit-1 downto 0);
signal coeff_matrix_sig : coeff_matrix;

--signals for linking the stage inputs and outputs
type stage_out is array (0 to fil_order) of signed(nbit-1 downto 0);
type sum_out is array (0 to fil_order) of signed(nbit-1 downto 0);

signal stage_out_arr : stage_out;
signal sum_out_arr : sum_out;
signal vin_sig: std_logic;
--signals for stage 0 (it's instanciated differently from the other stages)
signal mul0_out : signed(2*nbit-1 downto 0);
signal sig_reg_in_std : std_logic_vector(nbit-1 downto 0);
signal sig_reg_in : signed(nbit-1 downto 0);

signal enable : std_logic;
signal vout_sig : std_logic;

begin

enable <= vin and vout_sig;

--assignment of coefficient to signals matrix for using the generate later
coeff_matrix_sig(0) <= H0;
coeff_matrix_sig(1) <= H1;
coeff_matrix_sig(2) <= H2;
coeff_matrix_sig(3) <= H3;
coeff_matrix_sig(4) <= H4;
coeff_matrix_sig(5) <= H5;
coeff_matrix_sig(6) <= H6;
coeff_matrix_sig(7) <= H7;
coeff_matrix_sig(8) <= H8;

--input sampling register
in_reg : reg port map(din, clk, vin, rst_n, sig_reg_in_std);
sig_reg_in <= signed(sig_reg_in_std);

--multiplier for coeff 0 instance
mul0 : multiplier port map(sig_reg_in, signed(coeff_matrix_sig(0)), mul0_out);

--linking output of mul0 to first sum
sum_out_arr(0) <= mul0_out(2*nbit-1 downto nbit);

--linking input register to first stage of the filter
stage_out_arr(0) <= signed(sig_reg_in);

--generation of fil_order-1 stages composed of a reg, a mult and an adder
stage_gen : for i in 1 to fil_order generate
	stages : stage port map(clk, rst_n, vin_sig, stage_out_arr(i-1), sum_out_arr(i-1), coeff_matrix_sig(i), stage_out_arr(i), sum_out_arr(i));
	end generate;

--instance of output register
out_reg : reg port map (std_logic_vector(sum_out_arr(fil_order)), clk, vin_sig, rst_n, dout);

--vout generator instance (basically it delays vin of 1 cc, could be a problem if vin is 'X'? )
vout_instance : FD port map (VIN,clk,'1',rst_n,vin_sig);
vout_2 :FD port map ( vin_sig, clk,'1',rst_n,vout);

end architecture;
