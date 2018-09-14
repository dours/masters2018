library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_arith.all;

entity Operation4bit is port (
    A : in unsigned(3 downto 0);
    B : in unsigned(3 downto 0);
    O : in unsigned(1 downto 0);
    Result : out unsigned(3 downto 0);
    Error : out unsigned(0 downto 0)
);
end entity;

architecture rtl of Operation4bit is
begin
    process (A, B, O) is begin
        Error <= B"0";
        case O is
            when B"00" => 
                Result <= A + B;
            when B"01" =>
                Result <= A - B;
            when B"10" =>
                Result <= unsigned(std_logic_vector(A) or std_logic_vector(B));
            when others => 
                Error <= B"1";
        end case;
    end process;
end architecture;