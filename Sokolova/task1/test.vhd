library ieee;
use ieee.std_logic_1164.all;

entity test is end entity;

architecture rtl of test is
signal in_vector : std_logic_vector(9 downto 0);
signal in_exit: integer;

begin
	DUT : entity work.multiplexer port map (
		in_vector => in_vector, in_exit => in_exit);

	process is
	begin
		in_vector <= B"1010101010";
		in_exit   <= 0;
		wait for 1 ns;
		
		in_vector <= B"1010101010";
		in_exit   <= 1;
		wait for 1 ns;
		
		in_vector <= B"1010101010";
		in_exit   <= 2;
		wait for 1 ns;
		
		in_vector <= B"1010101010";
		in_exit   <= 3;
		wait for 1 ns; 
		
	end process;
end rtl;	
	