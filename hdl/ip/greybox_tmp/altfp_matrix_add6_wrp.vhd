LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity altfp_matrix_add6_wrp is
generic  (
	width_exp	:	natural := 8;
	width_man	:	natural := 23);
port ( 
	one	:	in std_logic_vector(31 downto 0) := (others => '0');
	two	:	in std_logic_vector(31 downto 0) := (others => '0');
	three	:	in std_logic_vector(31 downto 0) := (others => '0');
	four	:	in std_logic_vector(31 downto 0) := (others => '0');
	five	:	in std_logic_vector(31 downto 0) := (others => '0');
	six	:	in std_logic_vector(31 downto 0) := (others => '0');
	oner	:	in std_logic_vector(31 downto 0) := (others => '0');
	twor	:	in std_logic_vector(31 downto 0) := (others => '0');
	threer	:	in std_logic_vector(31 downto 0) := (others => '0');
	fourr	:	in std_logic_vector(31 downto 0) := (others => '0');
	fiver	:	in std_logic_vector(31 downto 0) := (others => '0');
	sixr	:	in std_logic_vector(31 downto 0) := (others => '0');
	onei	:	in std_logic_vector(31 downto 0) := (others => '0');
	twoi	:	in std_logic_vector(31 downto 0) := (others => '0');
	threei	:	in std_logic_vector(31 downto 0) := (others => '0');
	fouri	:	in std_logic_vector(31 downto 0) := (others => '0');
	fivei	:	in std_logic_vector(31 downto 0) := (others => '0');
	sixi	:	in std_logic_vector(31 downto 0) := (others => '0');
	result	:	out std_logic_vector(31 downto 0);
	resultr	:	out std_logic_vector(31 downto 0);
	resulti	:	out std_logic_vector(31 downto 0);
	enable	:	in std_logic := '1';
	reset	:	in std_logic := '0';
	startin	:	in std_logic := '0';
	startout	:	out std_logic;
	sysclk	:	in std_logic); 
end altfp_matrix_add6_wrp;

architecture rtl of altfp_matrix_add6_wrp is
component altfp_matrix_add6_fpc1a
port (
	sysclk : in std_logic;
	reset : in std_logic;
	enable : in std_logic;
	startin : in std_logic;
	one : in std_logic_vector (32 downto 1);
	two : in std_logic_vector (32 downto 1);
	three : in std_logic_vector (32 downto 1);
	four : in std_logic_vector (32 downto 1);
	five : in std_logic_vector (32 downto 1);
	six : in std_logic_vector (32 downto 1);
	
	startout : out std_logic;
	result : out std_logic_vector (32 downto 1));
end component;

begin

	add6wrp: altfp_matrix_add6_fpc1a
	port map (
		one => one,
		two => two,
		three => three,
		four => four,
		five => five,
		six => six,
		result => result,
		enable => enable,
		reset => reset,
		startin => startin,
		startout => startout,
		sysclk => sysclk);
	resultr <= "00000000000000000000000000000000";
	resulti <= "00000000000000000000000000000000";

end rtl;

