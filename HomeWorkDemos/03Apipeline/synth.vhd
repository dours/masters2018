

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
 
package p is 
  type tarr is array (0 to 7) of unsigned (15 downto 0); 
end p;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use work.p.all;  

entity synth is
port (
  clk : in std_logic; 
  inp : in tarr; 
  min : out unsigned (15 downto 0)
); 
end synth;

architecture rtl of synth is 
signal inpr : tarr;
begin

   process (clk) is 
   begin
     if clk'event and clk = '1' then 
         inpr <= inp;
     end if;
   end process; 

   process (clk) is 
   variable m : unsigned(15 downto 0); 
   begin
     if clk'event and clk = '1' then 
       m := X"FFFF";
       for i in inpr'range loop 
           if m > inpr(i) then m := inpr(i); end if;
       end loop; 

       min <= m; 
     end if;
   end process; 

end rtl;



