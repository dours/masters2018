library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.Numeric_Std.all;

package p is
	type tArr is array ( 0 to 2 ) of unsigned ( 15 downto 0 );
end p;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.Numeric_Std.all;
use work.p.all;

entity sorter is
   Port ( clk						: in  STD_LOGIC;
		  rst						: in  STD_LOGIC;
		  data_in					: in  tArr;
          valid_in				    : in  STD_LOGIC;
          ready_in				    : in  STD_LOGIC;
		  data_out				    : out tArr;
		  data_out_untouched        : out tArr;
          valid_out				    : out STD_LOGIC;
          ready_out				    : out STD_LOGIC );
end entity sorter;

architecture arc of sorter is
	signal data_mid1 : tArr;
	signal data_mid2 : tArr;
begin
	process (clk) is
	begin
		if clk'event and clk = '1'
		then
			data_out_untouched <= data_in;
			ready_out <= ready_in;
			valid_out <= valid_in;
			if ready_in = '1'
			then
			    --data_mid1 <= data_in;
				if data_in(0) > data_in(1)
				then data_mid1(0) <= data_in(1);
				else data_mid1(0) <= data_in(0);
				end if;
				if data_in(1) < data_in(0)
			    then data_mid1(1) <= data_in(0);
				else data_mid1(1) <= data_in(1);
				end if;
				data_mid1(2) <= data_in(2);
				-------------------------
				data_mid2(0) <= data_mid1(0);
				if data_mid1(1) > data_mid1(2)
				then data_mid2(1) <= data_mid1(2);
				else data_mid2(1) <= data_mid1(1);
				end if;
				if data_mid1(2) < data_mid1(1)
				then data_mid2(2) <= data_mid1(1);
				else data_mid2(2) <= data_mid1(2);
				end if;
				--------------------------
				--data_out <= data_mid2;
				if data_mid2(0) > data_mid2(1)
				then data_out(0) <= data_mid2(1);
				else data_out(0) <= data_mid2(0);
				end if;
				if data_mid2(1) < data_mid2(0)
				then data_out(1) <= data_mid2(0);
				else data_out(1) <= data_mid2(1);
				end if;
				data_out(2) <= data_mid2(2);
			end if; --ready
		end if;
	end process;

	process (clk) is
	begin
	end process;

end architecture arc;
