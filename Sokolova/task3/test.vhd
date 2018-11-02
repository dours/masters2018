library ieee;
use ieee.std_logic_1164.all; 
use ieee.std_logic_arith.all;

use work.p.all; 

entity test is 
end entity; 

architecture beh of test is 
signal clk, aresetn : std_logic;
signal I_tvalid : std_logic; 
signal I_tready : std_logic;

signal O_tvalid : std_logic;
signal O_tready : std_logic; 


signal inp : r; 
signal x, y : unsigned (5 downto 0);
signal br   : unsigned (17 downto 0);

signal inp_out  : r; 
signal x_out, y_out : unsigned (5 downto 0);

begin

	DUT : entity work.inter port map (
		clk => clk, aresetn => aresetn, 
		I_tvalid => I_tvalid, I_tready => I_tready,
		O_tvalid => O_tvalid, O_tready => O_tready,
		inp => inp, x => x, y => y, br => br,
		inp_out => inp_out, x_out => x_out, y_out => y_out);


  aresetn <= '0', '1' after 40 ns;

  process is 
  begin
    while true loop 
      clk <= '0'; 
      wait for 5 ns;
      clk <= '1' ;
      wait for 5 ns; 
    end loop; 
  end process; 

  G : entity work.generator port map (
    aresetn => aresetn, clk => clk, 
    O_tvalid => I_tvalid, O_tready => I_tready,
	 O_inp => inp, O_x => x, O_y => y
  ); 

  R : entity work.reciever port map ( 
    aresetn => aresetn, clk => clk, 
    I_tvalid => O_tvalid, I_tready => O_tready,
	 I_inp => inp_out, I_x => x_out, I_y => y_out, I_br => br
  ); 

end beh;