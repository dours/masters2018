

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
 
package p is 
  type tarr is array (0 to 7) of unsigned (15 downto 0); 
  type tdim2 is array (0 to 7 ) of tarr; 
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
signal inpr : tdim2;
signal mina : tarr; 
begin

   process (clk) is 
   begin
     if clk'event and clk = '1' then 
         inpr(0) <= inp;
         for i in 1 to 7 loop inpr(i) <= inpr(i - 1); end loop; 
     end if;
   end process; 

   process (clk) is 
   variable m : unsigned(15 downto 0); 
   begin
     if clk'event and clk = '1' then 
       mina(0) <= inpr(0)(0); 
       for i in 1 to 7 loop 
           if mina(i - 1) > inpr(i)(i) then 
               mina(i) <= inpr(i)(i);
           else
               mina(i) <= mina(i - 1);
           end if; 
       end loop; 

       min <= mina(7); 
     end if;
   end process; 

end rtl;



