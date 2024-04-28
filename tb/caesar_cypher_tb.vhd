library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity caesar_cypher_tb is
end entity;

architecture caesar_cypher_testbench of caesar_cypher_tb is
--	signal lut_char_out : std_logic_vector(CHAR_SIZE - 1 downto 0);
--  signal lut_char_in : std_logic_vector(KEY_SIZE - 1 downto 0);
	
	component caesar_cypher is
	--generic ( CHAR_SIZE : positive := 8; KEY_SIZE : positive := 5 );
		port (
		msg_in : in std_logic_vector(7 downto 0);
		chiave : in std_logic_vector(4 downto 0);
		async_reset : in std_logic;
		clock : in std_logic;
		start : in std_logic;
		msg_out : out std_logic_vector(7 downto 0);
		enc_dec : in std_logic;
		input_ASCII_err : out std_logic
	  );
	end component;
	

	-- CLK period (f_CLK = 125 MHz)
	constant T_clk : time := 8 ns;
	--constant CHAR_SIZE : integer := 8;
	--constant KEY_SIZE_tb : integer := 5;
	signal clock_tb : std_logic := '0';
	signal testing : boolean := true;
	signal start_tb : std_logic := '0';
	signal reset_tb : std_logic := '1';
	signal chiave_tb : std_logic_vector(4 downto 0);
	signal msg_in_tb : std_logic_vector(7 downto 0);
	signal msg_out_tb : std_logic_vector(7 downto 0);
	signal enc_dec_tb : std_logic := '0';
	signal input_ASCII_err_tb : std_logic;
	
	begin
		clock_tb <= (not(clock_tb)) after T_clk / 2 when testing else '0';
		
		CAESAR_CYPER: caesar_cypher
		port map (
			msg_in => msg_in_tb,
			chiave => chiave_tb,
			async_reset => reset_tb,
			clock => clock_tb,
			start => start_tb,
			enc_dec => enc_dec_tb,
			msg_out => msg_out_tb,
			input_ASCII_err => input_ASCII_err_tb
			);
			
		stimuli: process(clock_tb, reset_tb)
		variable clock_cycle : integer := 0;  -- variable used to count the clock cycle after the reset
		
		begin
			if (rising_edge(clock_tb)) then
				case (clock_cycle) is
					when 1 =>
						reset_tb <= '0';
						chiave_tb <= "01101";
						msg_in_tb <= (others => '0');
						start_tb <= '1';
					when 10 =>
						msg_in_tb <= "01100001";
					when 15 =>
						msg_in_tb <= "01100010";
					when 20 =>
						msg_in_tb <= "01100011";
					when 25 =>
						msg_in_tb <= "01100100";
					when 30 =>
						msg_in_tb <= "01100101";
					when 35 =>
						msg_in_tb <= "01100110";
					when 40 =>
						msg_in_tb <= "01100111";
					when 45 =>
						msg_in_tb <= "01101000";
					when 50 =>
						msg_in_tb <= "01101001";
					when 55 =>
						msg_in_tb <= "01101010";
					when 60 =>
						msg_in_tb <= "01101011";
					when 65 =>
						msg_in_tb <= "01101100";
					when 70 =>
						msg_in_tb <= "01101101";
					when 75 =>
						msg_in_tb <= "01101110";
					when 80 =>
						msg_in_tb <= "01101111";
					when 85 =>
						msg_in_tb <= "01110000";
					when 90 =>
						msg_in_tb <= "01110001";
					when 95 =>
						msg_in_tb <= "01110010";
					when 100 =>
						msg_in_tb <= "01110011";
					when 105 =>
						msg_in_tb <= "01110100";
					when 110 =>
						msg_in_tb <= "01110101";
					when 115 =>
						msg_in_tb <= "01110110";
					when 120 =>
						msg_in_tb <= "01110111";
					when 125 =>
						msg_in_tb <= "01100000"; -- ErrorTestOn5LSB | 5LSB bit a 0   -- Valore che c'era -> "01111000";
					when 130 =>
						msg_in_tb <= "01111001";
					when 135 =>
						msg_in_tb <= "01111010"; -- z
					when 140 => 
						msg_in_tb <= "01100010"; --'b'
						enc_dec_tb <= '1';		
					when 145 =>
						msg_in_tb <= "01111010";
					when 150 =>
						msg_in_tb <= "01111001";
					when 155 =>
						msg_in_tb <= "01111011"; -- ErrorTestOn5LSB | 5 bit >= 27 "01111000";
					when 160 =>
						msg_in_tb <= "01110111";
					when 165 =>
						msg_in_tb <= "01110110";
					when 170 =>
						msg_in_tb <= "01110101";
					when 175 =>
						msg_in_tb <= "01110100";
					when 180 =>
						msg_in_tb <= "01110011";
					when 185 =>
						msg_in_tb <= "01110010";
					when 190 =>
						msg_in_tb <= "01110001";
					when 195 =>
						msg_in_tb <= "11110000"; -- ErrorTestOnFirt3MSB "01110000";
					when 200 =>
						msg_in_tb <= "01101111";
						
					when 205 =>
						msg_in_tb <= "01101101";
					when 210 =>
						msg_in_tb <= "01101110";
					when 215 =>
						msg_in_tb <= "01101111";
					when 220 =>
						msg_in_tb <= "01110000";
					when 225 =>
						msg_in_tb <= "01110001";
					when 230 =>
						msg_in_tb <= "01110010";
					when 235 =>
						msg_in_tb <= "01110011";
					when 240 =>
						msg_in_tb <= "01110100";
					when 245 =>
						msg_in_tb <= "01110101";
					when 250 =>
						msg_in_tb <= "01110110";
					when 255 =>
						msg_in_tb <= "01110111";
						
						
					when 265 =>
						enc_dec_tb <= '0';
						testing <= false;
						start_tb <= '0';
						
					when others => null;
				end case;
				clock_cycle := clock_cycle + 1;
				--chiave_tb <= "00001";
			end if;
		end process;
end architecture;