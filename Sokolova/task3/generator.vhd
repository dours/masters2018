library ieee;
use ieee.std_logic_1164.all; 
use ieee.std_logic_arith.all;

use work.p.all; 

entity generator is 
generic (Width : integer := 6); 
port (
	clk, aresetn : in std_logic; 
	O_tvalid : out std_logic; 
	O_tready : in std_logic;
  
	O_inp : out r; 
	O_x, O_y : out unsigned (Width - 1 downto 0)
); 
end generator;

architecture rtl of generator is 

signal counter : r; 
signal x, y : unsigned (Width - 1 downto 0);
signal O_tvalid_prim : std_logic; 
signal skipWhen6 : unsigned(7 downto 0); 

begin
  O_inp  <= counter;
  O_x <= x;
  O_y <= y;
 
  O_tvalid <= O_tvalid_prim; 
  O_tvalid_prim <= '1' when skipWhen6 /= conv_unsigned(6, 8) else '0'; 

  process (clk, aresetn) is 
  variable c : unsigned (Width - 1 downto 0);
  begin
    if aresetn = '0' then 
		x <= conv_unsigned(0, Width);
		y <= conv_unsigned(0, Width);
		
		c := conv_unsigned(0, Width);
		counter(0) <= c;
		for i in 1 to 3 loop
			c := c + 1;
			counter(i) <= c;
		end loop; 
       
      skipWhen6 <= conv_unsigned(0, 8); 
		
    elsif clk'event and clk = '1' then 
      if O_tready = '1' then
         if skipWhen6 = conv_unsigned(6, 8) then 
             skipWhen6 <= conv_unsigned(0, 8); 
         else  
             skipWhen6 <= skipWhen6 + conv_unsigned(1, 8);
         end if; 
         if O_tvalid_prim = '1' then 
				x <= conv_unsigned(1 + x, Width);
				y <= conv_unsigned(1 + y, Width);
			
				for i in 0 to 3 loop
					c := c + 1;
					counter(i) <= c;
				end loop;  
			end if;
      end if; 
    end if; 
  end process; 

end rtl; 