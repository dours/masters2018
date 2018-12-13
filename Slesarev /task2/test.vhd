library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_arith.all;
    use ieee.std_logic_unsigned.all;

entity test is end entity;

architecture Behavioral of test is
    signal clk, reset, output : std_logic;
    signal i_a, i_b : integer;
begin
	DUT1 : entity work.task2 port map (clk => clk, i_a => i_a, i_b => i_b, reset => reset, output => output);
	
	process is 
    begin
        reset <= '1';
        wait for 20ns;
                
        reset <= '0';
        wait for 1000000 ns;
    end process;
	
	process is
	   constant period: time := 1 ns;
	begin
	   while true loop
	       clk <= '0';
	       wait for period;
	       clk <= '1';
	       i_a <= 1;
	       i_b <= 5;
	       wait for period;
	   end loop;
	end process;
end Behavioral;
