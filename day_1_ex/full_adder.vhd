----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.03.2026 16:18:27
-- Design Name: 
-- Module Name: full_adder - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity full_adder is
    Port ( in1 : in STD_LOGIC;
           in2 : in STD_LOGIC;
           carry_in : in std_logic;
           sum_o : out std_logic;
           carry_out : out STD_LOGIC);
end full_adder;

architecture Behavioral of full_adder is
-- componentlar 
component half_adder is 
    Port ( in1 : in STD_LOGIC;
           in2 : in STD_LOGIC;
           sum : out std_logic;
           carry : out STD_LOGIC);
end component;
-- signals
signal first_sum : std_logic := '0';
signal first_carry : std_logic :='0';
signal second_carry : std_logic :='0';

begin
-- component instantiation
first_half_adder : half_adder
port map(
in1 => in1,
in2 => in2,
sum => first_sum,
carry => first_carry);

second_half_adder : half_adder
port map(
in1 => first_sum,
in2 => carry_in,
sum => sum_o,
carry => second_carry);

carry_out <= first_carry or second_carry;


end Behavioral;
