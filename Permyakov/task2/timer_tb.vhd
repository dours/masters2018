library IEEE;
use ieee.STD_LOGIC_1164.all;
use ieee.STD_LOGIC_ARITH.all;
entity Timer_tb is
  	generic (
  		InpWidth: INTEGER := 4
  	);
end;

architecture bench of Timer_tb is

  component Timer
  	generic (
  		InpWidth: INTEGER := 4
  	);
  	port (
  		rst, clk: in STD_LOGIC;
  		Period: in UNSIGNED( InpWidth - 1 downto 0 );
  		Config: in STD_LOGIC;
  		inp_valid: in STD_LOGIC;
  		outp_valid: out STD_LOGIC;
  		Result: out STD_LOGIC
  	);
  end component;

  signal rst, clk: STD_LOGIC;
  signal Period: UNSIGNED( InpWidth - 1 downto 0 );
  signal Config: STD_LOGIC;
  signal inp_valid: STD_LOGIC;
  signal outp_valid: STD_LOGIC;
  signal Result: STD_LOGIC ;
  signal a: UNSIGNED( 7 downto 0 );

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: Timer generic map ( InpWidth   =>  4)
                port map ( rst        => rst,
                           clk        => clk,
                           Period     => Period,
                           Config     => Config,
                           inp_valid  => inp_valid,
                           outp_valid => outp_valid,
                           Result     => Result );

  stimulus: process
  begin
  
   -- Инициализация
    rst <= '1';
    wait until ( clk'event and clk = '1' );
   -- Настройка
    rst <= '0';
	inp_valid <= '1';
    Period <= conv_unsigned( 3, InpWidth );
	Config <= '0';
    wait until ( clk'event and clk = '1' );
	inp_valid <= '0';

   -- Тест
	a <= conv_unsigned( 0, 8 );
	while true loop
		wait until ( clk'event and clk = '1' );
        inp_valid <= '0';
		a <= a+conv_unsigned(1,8);
		if a = conv_unsigned(20,8) then
            rst <= '0';
            inp_valid <= '1';
            Period <= conv_unsigned( 3, InpWidth );
            Config <= '0';
		end if;
	end loop;

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
