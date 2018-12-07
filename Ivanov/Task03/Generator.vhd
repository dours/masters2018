library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.math_real.all;
use work.p.all;

entity Generator is
port(
    clk, rst : in std_logic;
    gen : out input_data;
    valid : out std_logic;
    ready : in std_logic
);
end Generator;

architecture rtl of Generator is

constant test_0 : input_data := (
    a => conv_unsigned(0, 32), b => conv_unsigned(0, 32),
    c => conv_unsigned(0, 32), x => conv_unsigned(0, 32)
);
constant test_1 : input_data := (
    a => conv_unsigned(0, 32), b => conv_unsigned(0, 32),
    c => conv_unsigned(1, 32), x => conv_unsigned(0, 32)
);
constant test_2 : input_data := (
    a => conv_unsigned(0, 32), b => conv_unsigned(0, 32),
    c => conv_unsigned(2, 32), x => conv_unsigned(0, 32)
);
constant test_3 : input_data := (
    a => conv_unsigned(0, 32), b => conv_unsigned(0, 32),
    c => conv_unsigned(3, 32), x => conv_unsigned(0, 32)
);

constant tests_amount : integer := 4;
type tests_type is array(0 to tests_amount - 1) of input_data; 
constant tests : tests_type := (
    test_0, test_1, test_2, test_3
);
begin
    
process(clk)
variable current_test : integer := 0; 
begin
    if rising_edge(clk) then
        if rst = '1' then
            valid <= '0';
            current_test := 0;
        else
            if ready = '1' then
                valid <= '1';
                gen <= tests(current_test);
                current_test := current_test + 1;
                if current_test = tests_amount then
                    current_test := 0;
                end if;
            end if;
        end if;
    end if;
end process;

end rtl;
