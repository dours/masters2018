library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_arith.all;

entity task2 is 
    port (
        clk, reset : in std_logic;
        output : out std_logic
    );
end;

architecture Behavioral of task2 is
    type statetype is (S0, S1);
    signal state, nextstate: statetype;
    signal acc: integer := 0;
    signal a: integer := 3;
    signal b: integer := 5;
begin
    process (clk, reset) begin
        if reset = '1' then state <= S0;
        elsif rising_edge(clk) then
            if (state = S0) then
                if (acc < a - 1) then acc <= acc + 1;
                elsif (acc = a - 1) then 
                    acc <= 0;
                    state <= nextstate;
                end if;
            elsif (state = S1) then
                if (acc < b - 1) then acc <= acc + 1;
                elsif (acc = b - 1) then
                    acc <= 0;
                    state <= nextstate;
                end if;
            end if;
        end if;
    end process;
    nextstate <= S1 when state = S0 else S0;                 
    output <= '1' when state = S0 else '0';
end;