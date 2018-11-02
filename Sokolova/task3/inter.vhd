library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
 
package p is 
  --type rpix is array (0 to 1) of unsigned (15 downto 0); --rows
  --type tpix is array (0 to 1) of rpix;							--pixel table 
  --type tdim2 is array (0 to 3) of tpix; 
  
  type r is array (0 to 3) of unsigned (5 downto 0);
  type rr is array (0 to 3) of r;
  
  type b is array (0 to 3) of unsigned (17 downto 0);
  
  type h is array (0 to 3) of std_logic;

end p;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use work.p.all;  

entity inter is
port (
	clk, aresetn : in std_logic;
	I_tvalid : in std_logic;
	I_tready : out std_logic;
	
	O_tvalid : out std_logic;
	O_tready : in std_logic;
	
		
	inp  : in r; 
	x, y : in unsigned (5 downto 0);
	br   : out unsigned (17 downto 0);
	
	inp_out  : out r; 
	x_out, y_out : out unsigned (5 downto 0)
	
); 
end inter;

architecture rtl of inter is 
signal inpr : rr;
signal xr   : r;
signal yr   : r;
signal hasD_r : h;
signal bpix : b;

begin 
	process (clk) is 
   begin
		
     if clk'event and clk = '1' then
			if aresetn = '0' then 
				inpr <= (others => (others => (others => '0')));
				xr <= (others => (others => '0'));
				yr <= (others => (others => '0'));
				hasD_r <= (others => '0');
				
			else 
				if O_tready = '1' then
					for i in 1 to 3 loop 
						inpr(i) <= inpr(i - 1); 
						xr(i) <= xr(i - 1);
						yr(i) <= yr(i - 1);
						hasD_r(i) <= hasD_r(i - 1);
					end loop;
							
					inpr(0) <= inp;
					xr(0) <= x;
					yr(0) <= y;
					hasD_r(0) <= I_tvalid;
			
				end if;
				
				
					
			end if;
     end if;
   end process; 
	
	--process (O_tready) is
	--begin
		I_tready <= O_tready;
	--end process;	

   process (clk) is 
	variable x1: r;
	variable y1: r;
	variable res : unsigned (17 downto 0);
   begin
		if clk'event and clk = '1' and O_tready = '1' then
			bpix(0) <= conv_unsigned(inpr(0)(0) * (64 - xr(0)) * (64 - yr(0)), 18);
			
			bpix(1) <= conv_unsigned(bpix(0) + inpr(1)(1) * (64 - xr(1)) * yr(1), 18);
			
			bpix(2) <= conv_unsigned(bpix(1) + inpr(2)(2) * xr(2) * (64 - yr(2)), 18);
			
			res := conv_unsigned(bpix(2) + inpr(3)(3) * xr(3) * yr(3), 18);
			--bpix(3) <= res;
			
			
			br <= res;
			O_tvalid <= hasD_r(3);
			inp_out <= inpr(3);
			x_out <= xr(3);
			y_out <= xr(3);
				
	   end if;
	end process;

end rtl;