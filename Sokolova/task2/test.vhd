library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity test is end entity;

architecture beh of test is
signal clk, rst, b : std_logic;
signal inp : unsigned(7 downto 0);

begin
	DUT : entity work.avg port map (clk => clk, rst => rst, b => b, inp => inp);

	process is 
	begin
		rst <= '1';
		wait for 20ns;
				
		rst <= '0';
		wait for 1000000 ns;
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
	variable prev_b: std_logic;
	variable s: unsigned(7 downto 0);
	begin
		s := conv_unsigned(0, 8);
		prev_b := '0';
		while true loop
			wait until
				(clk'event and clk = '1');
			s := s + 5;
			if (prev_b = '0') then
				b <= '1';
				prev_b := '1';
			else 
				b <= '0';
				prev_b := '0';
			end if;	
			 
			inp <= s; 
		end loop;
	end process; 
		 
end beh;
