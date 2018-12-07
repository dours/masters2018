library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity testbed is end entity;

architecture Behavioral of testbed is
signal rst, inp_valid: std_logic;
signal inp_a, inp_b: unsigned(7 downto 0);
signal clk: std_logic := '0';
constant half_period: time := 5 ns;
begin
    DUT : entity work.MultiplyAccumulate port map(clk => clk, rst => rst, inp_a => inp_a, inp_b => inp_b, inp_valid => inp_valid);
    
    process is begin
        rst <= '1';
        for i in 0 to 9 loop
            wait until clk'event and clk = '1';
        end loop;
        rst <= '0';
        wait;
    end process;
    
    process is begin
        while true loop 
            clk <= not clk;
            wait for half_period;
        end loop; 
    end process;
    
    process is begin
        inp_a <= conv_unsigned(1, 8);
        inp_b <= conv_unsigned(1, 8);
        while true loop
            wait until clk'event and clk = '1';
            inp_valid <= '1';
            wait until clk'event and clk = '1';
            inp_valid <= '0';
            inp_b <= inp_b + 1;
        end loop;
    end process;
end Behavioral;
