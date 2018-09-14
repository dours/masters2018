{\rtf1\ansi\ansicpg1252\cocoartf1561\cocoasubrtf600
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 library ieee;\
    use ieee.std_logic_1164.all;\
    use ieee.std_logic_arith.all;\
    use ieee.std_logic_unsigned.all;\
\
entity test is end entity;\
\
architecture rtf of test is\
	signal A, B, Result : unsigned(3 downto 0);\
	signal O : unsigned(1 downto 0);\
	signal Error : unsigned(0 downto 0);\
begin\
	DUT : entity work.Operation4bit port map \
	(A => A, B => B, O => O, Result => Result, Error => Error);\
	process is\
	constant period: time := 30 ns;\
	begin\
\
		-- test plus operation\
		A <= B"0001";\
		B <= B"0001";\
		O <= B"00";\
		wait for period;\
		assert (Result = unsigned(std_logic_vector'(B"0010")) and Error = 0)\
		report "Test failed for input A = 0001 and B = 0001 and O = 00" severity failure;\
		\
		-- test minus operation\
		A <= B"0110";\
		B <= B"0101";\
		O <= B"01";\
		wait for period;\
		assert (Result = unsigned(std_logic_vector'(B"0001")) and Error = 0)\
		report "Test failed for input A = 0110 and B = 0101 and O = 01" severity failure;\
\
        		-- test OR operation\
		A <= B"1010";\
		B <= B"0110";\
		O <= B"10";\
		wait for period;\
		assert (Result = unsigned(std_logic_vector'(B"1110")) and Error = 0)\
		report "Test failed for input A = 1010 and B = 0110 and O = 10" severity failure;\
\
        		-- test ERROR input\
		A <= B"0001";\
		B <= B"0001";\
		O <= B"11";\
		wait for period;\
		assert (Error = 1)\
		report "Test failed for input A = 0001 and B = 0001 and O = 11" severity failure;\
		\
		wait;\
	end process;\
end rtf;}