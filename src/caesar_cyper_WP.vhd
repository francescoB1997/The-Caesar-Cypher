library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity caesar_cypher_wrapper is
    Port (
        clock_W : in STD_LOGIC;
        async_reset_W : in STD_LOGIC;
		start_W : in std_logic;
        
        -- Data ports
        msg_in_W : in STD_LOGIC_VECTOR(7 downto 0);
        chiave_W : in STD_LOGIC_VECTOR(4 downto 0);
        enc_dec_W : in STD_LOGIC;
        msg_out_W : out STD_LOGIC_VECTOR(7 downto 0);
		input_ASCII_err_W : out STD_LOGIC
    );
end caesar_cypher_wrapper;

architecture Behavioral of caesar_cypher_wrapper is
    signal clock_REG : STD_LOGIC;
    signal async_reset_REG : STD_LOGIC;
	signal start_REG : STD_LOGIC;
    signal msg_out_REG : STD_LOGIC_VECTOR(7 downto 0);
    signal msg_in_REG : STD_LOGIC_VECTOR(7 downto 0);
    signal chiave_REG : STD_LOGIC_VECTOR(4 downto 0);
    signal enc_dec_REG : STD_LOGIC;
    signal out_caesar_cyper : STD_LOGIC_VECTOR(7 downto 0);
	signal input_ASCII_err_REG : STD_LOGIC;
    
    component caesar_cypher is
        Port (
            clock : in STD_LOGIC;
            async_reset : in STD_LOGIC;
            msg_in : in STD_LOGIC_VECTOR(7 downto 0);
            chiave : in STD_LOGIC_VECTOR(4 downto 0);
			start : in std_logic;
            enc_dec : in STD_LOGIC;
            msg_out : out STD_LOGIC_VECTOR(7 downto 0);
			input_ASCII_err : out std_logic
        );
    end component;

begin
    CAESAR_CYPHER_INST : caesar_cypher
    port map (
        clock => clock_REG,
        async_reset => async_reset_REG,
        msg_in => msg_in_REG,
        chiave => chiave_REG,
		start => start_REG,
        enc_dec => enc_dec_REG,
        msg_out => out_caesar_cyper,
		input_ASCII_err => input_ASCII_err_REG
    );
    
    register_PROCESS : process(clock_W)
    begin
        if(rising_edge(clock_W)) then
            async_reset_REG <= async_reset_W;
            msg_out_REG <= out_caesar_cyper;
            msg_in_REG <= msg_in_W;
            chiave_REG <= chiave_W;
			start_REG <= start_W;
            enc_dec_REG <= enc_dec_W;
			input_ASCII_err_W <= input_ASCII_err_REG;
        end if;
    end process;
    clock_REG <= clock_W;
    msg_out_W <= msg_out_REG;
end Behavioral;
