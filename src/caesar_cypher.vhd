library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity caesar_cypher is

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
end entity;

architecture arch_caesar_cypher of caesar_cypher is
	signal lut_char_out : std_logic_vector(7 downto 0);
	signal lut_char_in : std_logic_vector(4 downto 0);
	signal reg_out : std_logic_vector(7 downto 0);
	
	signal error_on_three_MSB : std_logic;
	signal error_on_five_LSB : std_logic;
	signal range_character : std_logic_vector(5 downto 0);
	
	
	component char_lut is
		port (
		address  : in  std_logic_vector(4 downto 0);
		char_out : out std_logic_vector(7 downto 0)
	  );
	end component;
	
	begin
		LUT_CHAR : char_lut
		port map ( address => lut_char_in, 
				   char_out => lut_char_out );
			
		-- CYPHER PROCESS -----------------------------------------------------------------
			
		SELECT_ENC_DEC_MODE_PROCESS : process(enc_dec, chiave, msg_in)
		begin
			case (enc_dec) is
					when '0' =>
						lut_char_in <= std_logic_vector(
						resize(
						(
							(
								resize(unsigned(chiave), 6)
									+
								resize(unsigned(msg_in(4 downto 0)), 6)
							)REM 26
						),5)
						); 
					when '1' =>
						lut_char_in <= std_logic_vector(
						resize(
						(
							signed(
								(
									resize(unsigned(msg_in(4 downto 0)), 6)
										-
									resize(unsigned(chiave), 6)
								)
							)MOD 26
						),5)
						);
					when others => null;
				end case;
		end process;
		
		------------------------------------------------------------------------------------
		
		-- INPUT_ASCII_ERROR DETECTION -----------------------------------------------------
		
		range_character <= std_logic_vector(signed (
								resize(unsigned( msg_in(4 downto 0)), 6)
									-
								unsigned(to_signed(27, 6))
							  ));
		

		error_on_three_MSB <= msg_in(7) OR (msg_in(6) NAND msg_in(5)) ;
		error_on_five_LSB <= 
			( NOT(range_character(5)) )
				OR 
			( (msg_in(4) NOR msg_in(3)) AND (msg_in(2) NOR msg_in(1)) AND NOT(msg_in(0))); -- 
		input_ASCII_err <= error_on_five_LSB OR error_on_three_MSB;
		-- ----------------------------------------------------------------------------------
		
		CAESAR_CYPER_PROCESS : process(start, clock, async_reset)
		begin
			if(async_reset = '1') then
				reg_out  <= (others => '0');
			elsif( (start = '1') AND (rising_edge(clock))) then
				reg_out <= lut_char_out;
			end if;
		end process;
	msg_out <= reg_out;
end architecture;