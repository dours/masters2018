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

entity sorter_tb is
end;

architecture bench of sorter_tb is

  component sorter
     Port ( clk						: in  STD_LOGIC;
				rst						: in  STD_LOGIC;
				data_in					: in  tArr;
            valid_in					: in  STD_LOGIC;
            ready_in					: in  STD_LOGIC;
				data_out					: out tArr;
				data_out_untouched	: out tArr;
            valid_out				: out STD_LOGIC;
            ready_out				: out STD_LOGIC );
  end component;

  signal clk: STD_LOGIC;
  signal rst: STD_LOGIC;
  signal data_in: tArr;
  signal valid_in: STD_LOGIC;
  signal ready_in: STD_LOGIC;
  signal data_out: tArr;
  signal data_out_untouched: tArr;
  signal valid_out: STD_LOGIC;
  signal ready_out: STD_LOGIC;
  signal canon: tArr;

  constant clock_period: time := 1 ns;
  signal stop_the_clock: boolean;

begin

  uut: sorter port map ( clk                => clk,
                         rst                => rst,
                         data_in            => data_in,
                         valid_in           => valid_in,
                         ready_in           => ready_in,
                         data_out           => data_out,
                         data_out_untouched => data_out_untouched,
                         valid_out          => valid_out,
                         ready_out          => ready_out );

  stimulus: process
  procedure sort_test (
                unsorted: in tArr;
                signal sorted: out tArr  ) is
  variable buf: unsigned( 15 downto 0 );
  variable tmp: tArr;
  begin
    tmp := unsorted;
    if tmp(0) > tmp(1)
    then -- swap
        buf := tmp(0);
        tmp(0) := tmp(1);
        tmp(1) := buf;
    end if;
    if tmp(1) > tmp(2)
    then -- swap
        buf := tmp(1);
        tmp(1) := data_in(2);
        tmp(2) := buf;
    end if;
    if tmp(0) > tmp(1)
    then -- swap
        buf := tmp(1);
        tmp(1) := tmp(0);
        tmp(0) := buf;
    end if;
    sorted <= tmp;
  end procedure;
  
  
  begin
  
		-----------------------------------------------
		data_in( 0 to 2 ) <= ( 0 => to_unsigned(2, 16),
							   1 => to_unsigned(1, 16),
							   2 => to_unsigned(0, 16) );
		valid_in <= '1';
		ready_in <= '1';
        wait for 1 ns;
        sort_test(data_in, canon);
        wait for 2 ns;
		-----------------------------------------------
		data_in( 0 to 2 ) <= ( 0 => to_unsigned(1, 16),
									  1 => to_unsigned(3, 16),
									  2 => to_unsigned(2, 16) );
		valid_in <= '1';
		ready_in <= '1';
		wait for 1 ns;
        sort_test(data_in, canon);
        wait for 2 ns;
		-----------------------------------------------
		data_in( 0 to 2 ) <= ( 0 => to_unsigned(2, 16),
									  1 => to_unsigned(3, 16),
									  2 => to_unsigned(1, 16) );
		valid_in <= '1';
		ready_in <= '1';
		wait for 1 ns;
        sort_test(data_in, canon);
        wait for 2 ns;
		-----------------------------------------------
		data_in( 0 to 2 ) <= ( 0 => to_unsigned(1, 16),
									  1 => to_unsigned(2, 16),
									  2 => to_unsigned(3, 16) );
		valid_in <= '1';
		ready_in <= '1';
		wait for 1 ns;
        sort_test(data_in, canon);
        wait for 2 ns;
        -----------------------------------------------

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;
