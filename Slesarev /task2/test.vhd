library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_arith.all;
    use ieee.std_logic_unsigned.all;

entity test is end entity;

architecture Behavioral of test is
    signal clk, reset, output : std_logic;
begin
	DUT : entity work.task2 port map (clk => clk, reset => reset, output => output);
	
	process is
	   constant period: time := 1 ns;
	begin
	   while true loop
	       clk <= '0';
	       wait for period;
	       clk <= '1';
	       wait for period;
	   end loop;
	end process;
end Behavioral;
