library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity avg is 
generic (
	ArrLen: integer := 4
);
port (
	rst, clk, b: in std_logic;
	inp: in unsigned(7 downto 0);
	outp_avg: out unsigned(7 downto 0)
);
end entity;
      
architecture arch of avg is

type arr is array (0 to ArrLen - 1) of unsigned(7 downto 0);
signal a : arr;
signal avg : unsigned(7 downto 0);

begin
	process (clk) is 
	begin
		if clk'event and clk = '1' then 
			if rst = '1' then 
				a <= (others => (others => '0')); 
			elsif b = '1' then
				for i in (ArrLen - 1) downto 1 loop
					a(i) <= a(i - 1);
				end loop;
				a(0) <= inp;
				outp_avg <= avg;
			end if;
		end if;
	end process;

	process (a) is
	variable sum: unsigned(8 downto 0) := conv_unsigned(0, 9);
	begin
		sum := conv_unsigned(0, 9);
		for i in 0 to (ArrLen - 1) loop
			sum := sum + a(i);
		end loop;
		avg <= conv_unsigned(SHR(sum, conv_unsigned(2, 8)), 8);
	end process; 	
end architecture;	