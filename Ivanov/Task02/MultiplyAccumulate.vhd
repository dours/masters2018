library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity MultiplyAccumulate is
    port(
        rst, clk, inp_valid: in std_logic;
        inp_a, inp_b: in unsigned(7 downto 0);
        outp_result: out unsigned(19 downto 0)
    );
end entity;

architecture Behavioral of MultiplyAccumulate is
signal
    acc: unsigned(19 downto 0);
begin
    process(clk) is begin
        if clk'event and clk = '1' then
            if rst = '1' then
                acc <= conv_unsigned(0, 20);
            elsif inp_valid = '1' then
                acc <= acc + inp_a * inp_b;
            end if;
        end if;
    end process;
    
    process (acc) is begin
      outp_result <= acc;
    end process; 
end Behavioral;
