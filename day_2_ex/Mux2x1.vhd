library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity Mux2x1 is
port(
I1 : in std_logic;
b_i :in std_logic;
a_i : in std_logic; 
q1_o : out std_logic;
q2_o : out std_logic;
q3_o : out std_logic);

end Mux2x1;
-- 3 farklı gösterim ile yapıcam 
architecture Behavioral of Mux2x1 is
signal nand1 : std_logic;
signal nand2 : std_logic;


begin
nand1 <= a_i nand I1;
nand2 <= b_i nand (not I1);
q1_o <= nand1 nand nand2 ;

-- 2. çözüm yöntemi

q2_o <= a_i when I1 = '1' else b_i ;

-- 3. çözüm yönetmi
p_label : process (I1,a_i,b_i) begin
	if (I1='0') then
		q3_o <= b_i;
	else 
		q3_o <= a_i ;	
	end if ;
end process p_label;

end Behavioral;
