library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;


entity my_fir is
port (
      VIN, RST_n, clk : in std_logic;
      DIN  : in  std_logic_vector(7 downto 0);
      DIN_2: std_logic_vector ( 7 downto 0);
      DIN_3: std_logic_vector ( 7 downto 0);
      H0   : in std_logic_vector(7 downto 0);
      H1   : in std_logic_vector(7 downto 0);
      H2   : in std_logic_vector(7 downto 0);
      H3   : in std_logic_vector(7 downto 0);
      H4   : in std_logic_vector(7 downto 0);
      H5   : in std_logic_vector(7 downto 0);
      H6   : in std_logic_vector(7 downto 0);
      H7   : in std_logic_vector(7 downto 0);
      H8   : in std_logic_vector(7 downto 0);
      VOUT : out  std_logic;
      DOUT : out std_logic_vector(7 downto 0);
      DOUT_2 : out std_logic_vector(7 downto 0);
      DOUT_3 : out std_logic_vector(7 downto 0)
      );
end entity ;

architecture behavioural of my_fir is
 
component FD port ( D,CK,RESET,ENABLE :  in std_logic;
       Q : out std_logic );
end component ;

component stage1 port   (DIN,DIN_2,DIN_3,H0,H1,H2,H3,H4,H5,H6,H7,H8:in signed(7 downto 0 );
enable,rst_n,clk: in std_logic;
DOUT:out signed(7 downto 0));
end component ;

component stage2 port  (DIN,DIN_2,DIN_3,H0,H1,H2,H3,H4,H5,H6,H7,H8:in signed(7 downto 0 );
enable,rst_n,clk: in std_logic;
DOUT:out signed(7 downto 0));
end component ;

component stage3 port  (DIN,DIN_2,DIN_3,H0,H1,H2,H3,H4,H5,H6,H7,H8:in signed(7 downto 0 );
enable,rst_n,clk: in std_logic;
DOUT:out signed(7 downto 0));
end component ;

component REG port (D:	In	signed(7 downto 0);
                CK:	    In	std_logic;
                RESET:	In	std_logic;
                ENABLE: In 	std_logic;
                Q:	    Out	signed(7 downto 0));
end component ;

signal H0_s,H1_s,H2_s,H3_s,H4_s,H5_s,H6_s,H7_s,H8_s,Din_s,Din2_s,Din3_s,Dout_s,Dout2_s,Dout3_s,Dout_reg,Dout2_reg,Dout3_reg : signed ( 7 downto 0);
signal Din_reg,Din2_reg,Din3_reg,Din_reg1,Din2_reg1,Din3_reg1,Din_reg2,Din2_reg2,Din3_reg2,Din_reg3,Din2_reg3,Din3_reg3 : signed (7 downto 0);
signal vin_sig,vin_sig2,vin_sig3,vin_sig4 : std_logic ;

begin

  
  H0_s <= signed (H0);
  H1_s <= signed (H1);
  H2_s <= signed (H2);
  H3_s <= signed (H3);
  H4_s <= signed (H4);
  H5_s <= signed (H5);
  H6_s <= signed (H6);
  H7_s <= signed (H7);
  H8_s <= signed (H8);
  
Din_s  <=signed (DIN);
Din2_s <=signed (DIN_2);
Din3_s <=signed (DIN_3);

--reg01 : reg port map (Din_s,clk,RST_N,'1',Din_reg);
--reg02 : reg port map (Din2_s,clk,RST_N,'1',Din2_reg);
--reg03 : reg port map (Din3_s,clk,RST_N,'1',Din3_reg);




out1 : stage1 port map (Din_s,Din2_s,Din3_s,H0_s,H1_s,H2_s,H3_s,H4_s,H5_s,H6_s,H7_s,H8_s,VIN,RST_n,clk,Dout_s);
out2 :  stage2 port map (Din_s,Din2_s,Din3_s,H0_s,H1_s,H2_s,H3_s,H4_s,H5_s,H6_s,H7_s,H8_s,VIN,RST_n,clk,Dout2_s);
out3 : stage3 port map  (Din_s,Din2_s,Din3_s,H0_s,H1_s,H2_s,H3_s,H4_s,H5_s,H6_s,H7_s,H8_s,VIn,RST_n,clk,Dout3_s);


reg1 : reg port map (Dout_s,clk,RST_N,VIN,Dout_reg);
reg2 : reg port map (Dout2_s,clk,RST_N,VIN,Dout2_reg);
reg3 : reg port map (Dout3_s,clk,RST_N,VIN,Dout3_reg);

 DOUT <= std_logic_vector(Dout_reg ); 
 DOUT_2 <= std_logic_vector(Dout2_reg ); 
 DOUT_3 <= std_logic_vector(Dout3_reg); 



  FF1 : FD port map (VIN,clk,RST_n,'1',Vout);
 --ff2 : fd  port map (vin_sig,rst_n,clk,'1',vout);
 -- ff3 : fd port map ( vin_sig2,rst_n,clk,'1',vout);
  --ff4 :fd port map ( vin_sig3,rst_n,clk,'1',vin_sig4);
  --ff5 : fd port map ( vin_sig4,rst_n , clk,'1',vout);
	
end architecture ;
