library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;

entity test is end entity;

architecture beh of test is
signal clk, rst : std_logic;
signal inp : unsigned(7 downto 0);  
begin
  
  DUT : entity work.regExample port map (clk => clk, rst => rst, inp => std_logic_vector(inp)); 
  
  process is 
  begin
    rst <= '1';
    wait for 20 ns;
    rst <= '0';
    wait for 1000000ns;
  end process;
  
  process is 
  begin
    clk <= '1';
    while true loop 
       clk <= '0';
       wait for 5 ns;
       clk <= '1';
       wait for 5 ns;
    end loop; 
  end process;

  process is 
  begin
    inp <= conv_unsigned(0, 8); 
    wait for 3 ns;
    while true loop
      inp <= inp + conv_unsigned(1, 8); 
      wait for 10 ns;
    end loop;
  end process;
  
end beh;
  