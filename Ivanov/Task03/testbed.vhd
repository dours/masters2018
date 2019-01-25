library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use work.p.all;

entity testbed is
port(
error : out std_logic
);
end testbed;

architecture behavioral of testbed is
signal clk : std_logic := '0';
signal rst : std_logic;
signal in_ready, in_valid : std_logic;
signal in_gen : input_data;
signal out_ready, out_valid : std_logic;
signal out_gen : input_data;
signal out_res : int_res;

constant half_period : time := 2ns;
begin

GEN : entity work.Generator port map (
    clk => clk, rst => rst, ready => in_ready, gen => in_gen, valid => in_valid
);

DUT : entity work.Quadratic port map (
    clk => clk, rst => rst,
    valid_gen => in_valid, ready => in_ready,
    valid => out_valid, ready_val => out_ready,
    inp => in_gen,
    x => out_gen, y => out_res 
);

VAL : entity work.Validator port map (
    clk => clk, rst => rst,
    x => out_gen,
    y => out_res,
    valid => out_valid,
    ready => out_ready,
    error => error
);

process is begin
    clk <= not clk;
    wait for half_period;
end process;

process is begin
    rst <= '1';
    for i in 0 to 9 loop
        wait until rising_edge(clk);
    end loop;
    rst <= '0';
    wait;
end process;

end behavioral;
