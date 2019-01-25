library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

package p is
    constant intsize : integer := 32;
    subtype int is unsigned(intsize - 1 downto 0); 
    subtype int_tmp is unsigned(intsize * 2 - 1 downto 0);
    subtype int_res is unsigned(intsize * 3 - 1 downto 0);
    type input_data is record
        a, b, c, x: int;
    end record;
    type input_data_arr is array(0 to 3) of input_data;
    type valid_data_arr is array(0 to 3) of std_logic;
end;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use work.p.all;

entity Quadratic is
port(
    clk, rst, valid_gen, ready_val : in std_logic;
    inp : in input_data;
    x : out input_data;
    y : out int_res;
    valid, ready : out std_logic
);
end Quadratic;

architecture rtl of Quadratic is
signal x_stored : input_data_arr := (others => (others => conv_unsigned(0, 32)));
signal y_stored_0 : int_tmp := conv_unsigned(0, intsize * 2);
signal y_stored_1 : int_tmp := conv_unsigned(0, intsize * 2);
signal y_stored_2 : int_res := conv_unsigned(0, intsize * 3);
signal v_stored : valid_data_arr := (others => '0');
begin
ready <= ready_val;

process(clk) is
begin
    if rising_edge(clk) then
        if rst = '1' then
            x_stored <= (others => (others => conv_unsigned(0, 32)));
            y_stored_0 <= conv_unsigned(0, intsize * 2);
            y_stored_1 <= conv_unsigned(0, intsize * 2);
            y_stored_2 <= conv_unsigned(0, intsize * 3);
            v_stored <= (others => '0');
        else
            if ready_val = '1' then
                for i in 1 to 3 loop
                    x_stored(i) <= x_stored(i - 1);
                end loop;
                for i in 1 to 3 loop
                    v_stored(i) <= v_stored(i - 1);
                end loop;
                x_stored(0) <= inp;
                v_stored(0) <= valid_gen;
                
                y_stored_0 <= x_stored(0).a * x_stored(0).x;
                y_stored_1 <= y_stored_0 + x_stored(1).b;
                y_stored_2 <= y_stored_1 * x_stored(2).x;
                x <= x_stored(3);
                y <= y_stored_2 + x_stored(3).c;
                valid <= v_stored(3);
            else
                valid <= '0';
            end if;
        end if;
    end if;
end process;
end rtl;