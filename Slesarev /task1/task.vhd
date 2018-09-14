{\rtf1\ansi\ansicpg1252\cocoartf1561\cocoasubrtf600
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 library ieee;\
    use ieee.std_logic_1164.all;\
    use ieee.std_logic_arith.all;\
\
entity Operation4bit is port (\
    A : in unsigned(3 downto 0);\
    B : in unsigned(3 downto 0);\
    O : in unsigned(1 downto 0);\
    Result : out unsigned(3 downto 0);\
    Error : out unsigned(0 downto 0)\
);\
end entity;\
\
architecture rtl of Operation4bit is\
    signal carry: unsigned (0 downto 0);\
begin\
    process (A, B, O) is begin\
        Error <= B"0";\
        case O is\
            when B"00" => \
                Result <= A + B;\
            when B"01" =>\
                Result <= A - B;\
            when B"10" =>\
                Result <= unsigned(std_logic_vector(A) or std_logic_vector(B));\
            when others => \
                Error <= B"1";\
        end case;\
    end process;\
end architecture;}