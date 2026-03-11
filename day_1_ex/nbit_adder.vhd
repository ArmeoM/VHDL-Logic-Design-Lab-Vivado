library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity nbit_adder is
generic (
N	: integer := 4
); 
port (
in1		: in std_logic_vector (N-1 downto 0);
in2		: in std_logic_vector (N-1 downto 0);
carry_i	: in std_logic;
sum_o	: out std_logic_vector (N-1 downto 0);
carry_o	: out std_logic
);
end nbit_adder;

architecture Behavioral of nbit_adder is

-- COMPONENT DECLERATION
component full_adder is
port ( 
a_i 	: in std_logic;
b_i 	: in std_logic;
carry_i : in std_logic;
sum_o 	: out std_logic;
carry_o : out std_logic
);
end component;

signal temp	: std_logic_vector (N downto 0)	:= (others => '0');

begin

temp(0)	<= carry_i;
carry_o	<= temp(N);

FULL_ADDER_GEN: for k in 0 to N-1 generate
	full_adder_k : full_adder
	port map( 
	a_i 	=> in1(k),
	b_i 	=> in2(k),
	carry_i => temp(k),
	sum_o 	=> sum_o(k),
	carry_o => temp(k+1)
	);
end generate;


end Behavioral;
