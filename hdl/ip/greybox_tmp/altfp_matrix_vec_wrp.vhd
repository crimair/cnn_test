LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity altfp_matrix_vec_wrp is
generic  (
	vector_size	:	natural := 256;
	width_exp	:	natural := 8;
	width_man	:	natural := 23);
port ( 
	enable	:	in std_logic := '1';
	reset	:	in std_logic := '0';
	result	:	out std_logic_vector(31 downto 0);
	resultr	:	out std_logic_vector(31 downto 0);
	resulti	:	out std_logic_vector(31 downto 0);
	startin	:	in std_logic := '0';
	startout	:	out std_logic;
	sysclk	:	in std_logic; 
	vector_l_data	:	in std_logic_vector(255 downto 0) := (others => '0');
	vector_m_data	:	in std_logic_vector(255 downto 0) := (others => '0');
	vector_l_datar	:	in std_logic_vector(255 downto 0) := (others => '0');
	vector_m_datar	:	in std_logic_vector(255 downto 0) := (others => '0');
	vector_l_datai	:	in std_logic_vector(255 downto 0) := (others => '0');
	vector_m_datai	:	in std_logic_vector(255 downto 0) := (others => '0'));
end altfp_matrix_vec_wrp;

architecture rtl of altfp_matrix_vec_wrp is
component altfp_matrix_vec_fpc2a
port (
	sysclk : in std_logic;
	reset : in std_logic;
	enable : in std_logic;
	startin : in std_logic;
	L000 : in std_logic_vector (32 downto 1);
	L001 : in std_logic_vector (32 downto 1);
	L002 : in std_logic_vector (32 downto 1);
	L003 : in std_logic_vector (32 downto 1);
	L004 : in std_logic_vector (32 downto 1);
	L005 : in std_logic_vector (32 downto 1);
	L006 : in std_logic_vector (32 downto 1);
	L007 : in std_logic_vector (32 downto 1);
	M000 : in std_logic_vector (32 downto 1);
	M001 : in std_logic_vector (32 downto 1);
	M002 : in std_logic_vector (32 downto 1);
	M003 : in std_logic_vector (32 downto 1);
	M004 : in std_logic_vector (32 downto 1);
	M005 : in std_logic_vector (32 downto 1);
	M006 : in std_logic_vector (32 downto 1);
	M007 : in std_logic_vector (32 downto 1);
	
	startout : out std_logic;
	result : out std_logic_vector (32 downto 1));
end component;

begin

	vecwrp: altfp_matrix_vec_fpc2a
	port map (
		L000 => vector_l_data(31 downto 0),
		L001 => vector_l_data(63 downto 32),
		L002 => vector_l_data(95 downto 64),
		L003 => vector_l_data(127 downto 96),
		L004 => vector_l_data(159 downto 128),
		L005 => vector_l_data(191 downto 160),
		L006 => vector_l_data(223 downto 192),
		L007 => vector_l_data(255 downto 224),
		M000 => vector_m_data(31 downto 0),
		M001 => vector_m_data(63 downto 32),
		M002 => vector_m_data(95 downto 64),
		M003 => vector_m_data(127 downto 96),
		M004 => vector_m_data(159 downto 128),
		M005 => vector_m_data(191 downto 160),
		M006 => vector_m_data(223 downto 192),
		M007 => vector_m_data(255 downto 224),
		result => result,
		enable => enable,
		reset => reset,
		startin => startin,
		startout => startout,
		sysclk => sysclk);
	resultr <= "00000000000000000000000000000000";
	resulti <= "00000000000000000000000000000000";

end rtl;

