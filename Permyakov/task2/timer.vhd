library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.STD_LOGIC_ARITH.all;

entity Timer is
	generic (
		InpWidth: INTEGER := 4
	);
	port (
		rst, clk: in STD_LOGIC;		                  --перезагрузка и синхроимпульс

		Period: in UNSIGNED( InpWidth - 1 downto 0 ); --Кол-во тактов меж прерываниями.
		Config: in STD_LOGIC;                         --Срабатывание ( 0 )однократное/( 1 )переодическое
		inp_valid: in STD_LOGIC;                      --1 если на один из входов поданы данные для обработки

		Result: out STD_LOGIC;                        --Прерывания.
		outp_valid: out STD_LOGIC                     --1 если на выходе появился ответ
	);
end Timer;

architecture rls of Timer is ----------------------------------------------------------
    signal confBuff: STD_LOGIC;
    signal first: STD_LOGIC;
    signal init: STD_LOGIC;
    signal perBuff: UNSIGNED( InpWidth - 1 downto 0 );
    signal counter: UNSIGNED( InpWidth - 1 downto 0 );

begin --тело архитектуры
    process( clk, rst ) is begin
	   if clk'event and clk = '1' then
	       if rst = '0' then
	           if inp_valid = '0' then
	               outp_valid <= '1';
	               if confBuff = '0' then --Одно повторение
	                   if counter = conv_unsigned( 0, InpWidth ) and first = '1' then
	                       Result <= '1';
	                       first <= '0';
	                   else
	                       if counter /= conv_unsigned( 0, InpWidth ) then
	                           counter <= counter - conv_unsigned( 1, InpWidth );
	                       end if;
	                       Result <= '0';
	                   end if;
	               else --config == Периодическое повторение
	                   if counter = conv_unsigned( 0, InpWidth ) then
                           Result <= '1';
	                       counter <= perBuff;
	                   else
	                       Result <= '0';
	                       counter <= counter - conv_unsigned( 1, InpWidth );
	                   end if;
	               end if;
	           else
	               outp_valid <= '0';
	               perBuff <= Period - conv_unsigned( 1, InpWidth );
	               confBuff <= Config;
	               first <= '1';
	           end if;
	       else
               perBuff <= conv_unsigned( 3, InpWidth );
               counter <= conv_unsigned( 3, InpWidth );
               confBuff <= '1';
               first <= '1';
	       end if;
	   end if;
	end process;
end architecture rls; ------------------------------------------------------------------------------