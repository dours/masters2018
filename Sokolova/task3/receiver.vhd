-- is NOT ready to recieve data from the I_* channel
-- once in 6 clock cycles 


library ieee;
use ieee.std_logic_1164.all; 
use ieee.std_logic_arith.all;

use work.p.all; 


entity reciever is 
generic (Width : integer := 6); 
port (
	clk, aresetn : in std_logic; 
	I_tvalid : in std_logic; 
	I_tready : out std_logic;
  
	I_inp : in r; 
	I_x, I_y : in unsigned (Width - 1 downto 0);
	I_br   : in unsigned (17 downto 0)
); 
end reciever;

architecture rtl of reciever is 

signal freezeWhen7 : unsigned(7 downto 0); 

begin

  I_tready <= '1' when freezeWhen7 /= conv_unsigned(5, 8) else '0'; 

  process (clk, aresetn) is 
  variable res : unsigned (17 downto 0);
  variable x1  : r;
  variable y1  : r;
  
  variable br : unsigned (17 downto 0);
  variable b0 : unsigned (17 downto 0);
  variable b1 : unsigned (17 downto 0);
  variable b2 : unsigned (17 downto 0);
  variable b3 : unsigned (17 downto 0);
  
  begin
    if aresetn = '0' then
		freezeWhen7 <= conv_unsigned(0, 8);  
    elsif clk'event and clk = '1' then
      if freezeWhen7 = conv_unsigned(5, 8) then 
        freezeWhen7 <= conv_unsigned(0, 8); 
      else  
        freezeWhen7 <= conv_unsigned(1, 8) + freezeWhen7; 
      end if; 
		
			b0 := conv_unsigned(I_inp(0) * (64 - I_x) * (64 - I_y), 18);
			b1 := conv_unsigned(I_inp(1) * (64 - I_x) * I_y, 18);
			b2 := conv_unsigned(I_inp(2) * I_x * (64 - I_y), 18);
			b3 := conv_unsigned(I_inp(3) * I_x * I_y, 18);
			--br := conv_unsigned(I_inp(0) * (64 - I_x) * (64 - I_y) + I_inp(1) * (64 - I_x) * I_y + 
			--			I_inp(2) * I_x * (64 - I_y) + I_inp(3) * I_x * I_y, 18);
			br := b0 + b1 + b2 + b3;
		
		if I_tvalid = '1' then	
			assert I_br = br;
		end if;
		
    end if; 
  end process; 

end rtl; 