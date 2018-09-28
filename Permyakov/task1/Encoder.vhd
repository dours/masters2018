library ieee;
use ieee.std_logic_1164.all;

entity
  Encoder is port (
    A: in STD_LOGIC_VECTOR( 53 downto 0 );      --<-- Input
    Result: out STD_LOGIC_VECTOR( 5 downto 0 )  -->-- Output
  );
end Encoder;

architecture rtl of Encoder is begin
  process ( A ) is begin
    Result(0) <= A(0) or A(2) or A(4) or A(6) or A(8) or A(10) or A(12) or A(14) or A(16) or A(18) or A(20) or A(22) or A(24) or A(26) or A(28) or A(30) or A(32) or A(34) or A(36) or A(38) or A(40) or A(42) or A(44) or A(46) or A(48) or A(50) or A(52);
    Result(1) <= A(1) or A(2) or A(5) or A(6) or A(9) or A(10) or A(13) or A(14) or A(17) or A(18) or A(21) or A(22) or A(25) or A(26) or A(29) or A(30) or A(33) or A(34) or A(37) or A(38) or A(41) or A(42) or A(45) or A(46) or A(49) or A(50) or A(53);
    Result(2) <= A(3) or A(4) or A(5) or A(6) or A(11) or A(12) or A(13) or A(14) or A(19) or A(20) or A(21) or A(22) or A(27) or A(28) or A(29) or A(30) or A(35) or A(36) or A(37) or A(38) or A(43) or A(44) or A(45) or A(46) or A(51) or A(52) or A(53);
    Result(3) <= A(7) or A(8) or A(9) or A(10) or A(11) or A(12) or A(13) or A(14) or A(23) or A(24) or A(25) or A(26) or A(27) or A(28) or A(29) or A(30) or A(39) or A(40) or A(41) or A(42) or A(43) or A(44) or A(45) or A(46);
    Result(4) <= A(15) or A(16) or A(17) or A(18) or A(19) or A(20) or A(21) or A(22) or A(23) or A(24) or A(25) or A(26) or A(27) or A(28) or A(29) or A(30) or A(47) or A(48) or A(49) or A(50) or A(51) or A(52) or A(53);
    Result(5) <= A(31) or A(32) or A(33) or A(34) or A(35) or A(36) or A(37) or A(38) or A(39) or A(40) or A(41) or A(42) or A(43) or A(44) or A(45) or A(46) or A(47) or A(48) or A(49) or A(50) or A(51) or A(52) or A(53);
  end process;
end rtl;