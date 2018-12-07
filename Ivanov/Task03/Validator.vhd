library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use work.p.all;

entity Validator is
port(
    clk, rst : in std_logic;
    x : in input_data;
    y : in int_res;
    valid : in std_logic;
    ready : out std_logic;
    error : out std_logic
);
end Validator;

architecture rtl of Validator is
constant stalling_frequency : integer := 7; 
signal stalling_delta : integer := 0;
begin

process(clk)
variable y_true : int_res;
begin
    if rst = '1' then
        error <= '0';
        ready <= '0';
    else
        if rising_edge(clk) then
            if valid = '1' then
                y_true := x.a * x.x * x.x + x.b * x.x + x.c;
                if (y_true /= y) then
                    error <= '1';
                else
                    error <= '0';
                end if;
                assert (y_true = y);
                --assert(y = conv_unsigned(0, intsize * 3));
            end if;
            stalling_delta <= stalling_delta + 1;
            if stalling_delta = stalling_frequency then
                stalling_delta <= 0;
                ready <= '0';
            else
                ready <= '1';
            end if;
        end if;
    end if;
end process;

end rtl;
