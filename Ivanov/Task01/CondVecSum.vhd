library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity CondVecSum is port (
	a, b : in std_logic_vector(23 downto 0);
	k : in std_logic_vector(2 downto 0);
	result : out std_logic_vector(23 downto 0)
);
end entity;

architecture rtl of CondVecSum is
begin
    process(a, b, k) is
    variable a_cur, b_cur, res_cur: unsigned(7 downto 0);
    begin
        for i in 0 to 2 loop
            if k(i) = '1' then
                a_cur := unsigned(a((i + 1) * 8 - 1 downto i * 8));
                b_cur := unsigned(b((i + 1) * 8 - 1 downto i * 8));
                res_cur := a_cur + b_cur;
            else 
                res_cur := unsigned(b((i + 1) * 8 - 1 downto i * 8));
            end if;
            result((i + 1) * 8 - 1 downto i * 8) <= std_logic_vector(res_cur);
        end loop;
    end process;
end architecture;