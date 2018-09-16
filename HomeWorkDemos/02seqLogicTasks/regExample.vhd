----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/14/2018 12:36:59 PM
-- Design Name: 
-- Module Name: regExample - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity regExample is
  Port (
    rst, clk : in std_logic;
    inp : in std_logic_vector(7 downto 0); 
    outp : out std_logic_vector(31 downto 0)
  
   );
end regExample;

architecture Behavioral of regExample is

type tarr is  array (0 to 3) of std_logic_vector(7 downto 0);
signal tmp : tarr;

begin

process (clk) is 
begin
  if clk'event and clk = '1' then 
    if rst = '1' then 
       tmp <= (others => (others => '0')); 
    else 
       for i in 0 to 2 loop
         tmp(i + 1) <= tmp(i); 
       end loop;
       tmp(0) <= inp;
     end if;
  end if;
end process;

process (tmp) is 
begin
  outp <= tmp(3) & tmp(2) & tmp(1) & tmp(0); 
end process; 


end Behavioral;
