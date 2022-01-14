library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity stage2 is 
port (DIN,DIN_2,DIN_3,H0,H1,H2,H3,H4,H5,H6,H7,H8:in signed(7 downto 0 );
enable,rst_n,clk: in std_logic;
DOUT:out signed(7 downto 0));
end entity ;

architecture behavioral of stage2 is 
component REG port  (D:	In	signed(7 downto 0);
                CK:	In	std_logic;
                RESET:	In	std_logic;
                ENABLE: In 	std_logic;
                Q:	Out	signed(7 downto 0));
end component ;

component FD port ( D,CK,RESET,ENABLE :  in std_logic;
       Q : out std_logic );
end component ;


--signal sum8,sum7,sum1,sum2,sum3,sum4,sum5,sum6 : signed(15 downto 0);
signal sum8,sum7,sum1,sum2,sum3,sum4,sum5,sum6 : signed(7 downto 0);
signal mul0, mul1, mul2, mul3, mul4, mul5, mul6, mul7, mul8 : signed (15 downto 0);
signal din3_reg,din2_reg,din_reg,din3_reg2,din2_reg2,din_reg2,din3_reg3,din2_reg3 : signed(7 downto 0);
signal mul0_pip,mul1_pip,sum4_pip,mul2_pip,mul3_pip,mul4_pip,mul5_pip,mul5_pip2,mul6_pip,mul6_pip2,mul7_pip,mul7_pip2,mul8_pip,mul8_pip2 : signed (7 downto 0);

begin

--we : fd port map (enable,clk,rst_n,'1',enable);
--qq : fd port map (enable,rst_n,'1',en);

mul0 <= DIN_2*H0;
mul1 <= DIN*H1;
reg12 :reg port map (mul0(15 downto 8),clk,rst_n,enable,mul0_pip);
reg13 :reg port map (mul1(15 downto 8),clk,rst_n,enable,mul1_pip);
sum1 <= mul0_pip + mul1_pip;


reg2 : reg port map (DIN_3, clk, rst_n, enable, din3_reg);
mul2 <= din3_reg*H2;
reg14 :reg port map (mul2(15 downto 8),clk,rst_n,enable,mul2_pip);
sum2 <= sum1 + mul2_pip;


reg3 : reg port map (DIN_2, clk, rst_n, enable, din2_reg);
mul3 <= din2_reg*H3;
reg15 :reg port map (mul3(15 downto 8),clk,rst_n,enable,mul3_pip);
sum3 <= sum2 + mul3_pip;


reg4 : reg port map (DIN, clk, rst_n, enable, din_reg);
mul4 <= din_reg*H4;
reg16 :reg port map (mul4(15 downto 8),clk,rst_n,enable,mul4_pip);
sum4 <= sum3 + mul4_pip;
reg174 :reg port map (sum4,clk,rst_n,enable,sum4_pip);

reg5 : reg port map (din3_reg, clk, rst_n, enable, din3_reg2);
mul5 <= din3_reg2*H5;
reg151 :reg port map (mul5(15 downto 8),clk,rst_n,enable,mul5_pip);
reg161 :reg port map (mul5_pip,clk,rst_n,enable,mul5_pip2);

sum5 <= sum4_pip + mul5_pip2;


reg6 : reg port map (din2_reg, clk, rst_n, enable, din2_reg2);
mul6 <= din2_reg2*H6;
reg1741 :reg port map (mul6(15 downto 8),clk,rst_n,enable,mul6_pip);
reg185 :reg port map (mul6_pip,clk,rst_n,enable,mul6_pip2);
sum6 <= sum5 + mul6_pip2;


reg7 : reg port map (din_reg, clk, rst_n, enable, din_reg2);
mul7 <= din_reg2*H7;
reg199 :reg port map (mul7(15 downto 8),clk,rst_n,enable,mul7_pip);
reg100 :reg port map (mul7_pip,clk,rst_n,enable,mul7_pip2);
sum7 <= sum6 + mul7_pip2;


reg8 : reg port map (din3_reg2, clk, rst_n, enable, din3_reg3);
mul8 <= din3_reg3*H8;
reg1123 :reg port map (mul8(15 downto 8),clk,rst_n,enable,mul8_pip);
reg1234 :reg port map (mul8_pip,clk,rst_n,enable,mul8_pip2);
sum8 <= sum7 + mul8_pip2;

dout <= sum8;


end architecture ;



