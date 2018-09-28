library ieee;
use ieee.std_logic_1164.all;

entity multiplexer is port (
      in_vector: in std_logic_vector (9 downto 0);
      in_exit  : in integer;
      exit_0   : out std_logic_vector (9 downto 0);
		exit_1   : out std_logic_vector (9 downto 0);
		exit_2   : out std_logic_vector (9 downto 0);
	   exit_err : out std_logic_vector (0 downto 0)
);
end multiplexer;

architecture arch of multiplexer is
begin
	process (in_vector, in_exit) is
		variable e_0, e_1, e_2: std_logic_vector (9 downto 0);
		variable e_err        : std_logic_vector (0 downto 0);
		begin
			e_0 := B"0000000000";
			e_1 := B"0000000000";
			e_2 := B"0000000000";
			e_err := B"0";	
			case in_exit is
				when 0 => e_0 := in_vector;
				when 1 => e_1 := in_vector;
				when 2 => e_2 := in_vector;
				when others => e_err := B"1";
			end case;
			exit_0 <= e_0;
			exit_1 <= e_1;
			exit_2 <= e_2;
			exit_err <= e_err;
	end process;	
end architecture;	
	