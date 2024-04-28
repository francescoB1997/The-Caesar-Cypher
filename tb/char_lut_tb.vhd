library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.numeric_std.all;

entity char_lut_tb is
end entity;

architecture arch_char_lut_tb of char_lut_tb is

	component char_lut is
		port (
			address  : in  std_logic_vector(4 downto 0);
			char_out : out std_logic_vector(7 downto 0)
		 );
	end component;
	
	constant T_clk : time := 8 ns;
	  -- clk signal (initialized to '0')
	signal clk_tb : std_logic := '0';
	
	signal address_in : std_logic_vector(4 downto 0);
	signal char_out_tb : std_logic_vector(7 downto 0);
	  
	begin
	-- clk signal
		clk_tb <= (not(clk_tb)) after T_clk / 2;
		--address_in <= (others => '0');
		
	LUT : char_lut
	port map (
		address => address_in,
		char_out => char_out_tb
	);
		
	stimuli: process(clk_tb)
		variable clock_cycle : integer := 0; 
		--variable lettera_uscita : character := '.';
		begin	
			if (rising_edge(clk_tb)) then
			  case (clock_cycle) is
				when 1 =>
				  address_in    <= "00001"; -- frequency word = 1
				when 10 =>
					address_in    <= "00011"; -- frequency word = 1
				when 20 =>
					address_in    <= "11010"; -- frequency word = 1
				when others => null;
			  end case;
			  clock_cycle := clock_cycle + 1;
			  --lettera_uscita := character'val(abs(char_out_tb));
			 end if;
	end process;
 
end architecture;