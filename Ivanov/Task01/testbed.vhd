library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity test is end entity;

architecture rtl of test is
	signal a, b, result: std_logic_vector(23 downto 0);
	signal k: std_logic_vector(2 downto 0);
begin
	DUT : entity work.CondVecSum port map (
		a => a, b => b, k => k, result => result
	);
	process is
	variable a0, a1, a2: unsigned(7 downto 0); 
    variable b0, b1, b2: unsigned(7 downto 0); 
	begin
        a0 := B"00000000"; a1 := B"11111111"; a2 := B"11111111";
        b0 := B"00001111"; b1 := B"00001111"; b2 := B"00001111";
        a <= std_logic_vector(a2) & std_logic_vector(a1) & std_logic_vector(a0);
        b <= std_logic_vector(b2) & std_logic_vector(b1) & std_logic_vector(b0);
        k <= "110";
		wait for 1 ns;
	end process;
end rtl;