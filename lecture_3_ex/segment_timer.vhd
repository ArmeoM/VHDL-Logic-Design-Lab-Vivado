library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.all;
use IEEE.STD_LOGIC_arith.all;


entity segment_timer is
generic (
	c_clkfreq : integer :=100_000_000;
	c_debtime : integer := 100_000 );
port (
	clk :  in STD_LOGIC;
	start_in : in STD_LOGIC;
	reset_in : in STD_LOGIC;
	 milisaniye_b1_out : out STD_LOGIC_vector (6 downto 0) := (others => '0'); 
	 milisaniye_b2_out : out STD_LOGIC_vector (6 downto 0) := (others => '0');
	 saniye_b1_out :out STD_LOGIC_vector (6 downto 0) := (others => '0');
	 saniye_b2_out :out STD_LOGIC_vector (6 downto 0) := (others => '0');
	 dakika_b1_out :out STD_LOGIC_vector (6 downto 0) := (others => '0');
	 dakika_b2_out :out STD_LOGIC_vector (6 downto 0) := (others => '0')
);
end segment_timer;

architecture Behavioral of segment_timer is
function vector_to_segment ( input_vector : STD_LOGIC_vector) return STD_LOGIC_vector is
   	variable segmentform : STD_LOGIC_vector (6 downto 0) := (others => '0');
begin
    if (input_vector = "0000") then
     	segmentform := "0111111"; -- 6 to 0  g f e d c b a şeklinde ilerler 
    elsif (input_vector = "0001") then
     	segmentform := "0000110" ;
    elsif (input_vector = "0010") then
     	segmentform := "1011011" ;
    elsif (input_vector = "0011") then
     	segmentform := "1001111" ;
    elsif (input_vector = "0100") then
     	segmentform := "1100110" ;
    elsif (input_vector = "0101") then
     	segmentform := "1101101" ;
    elsif (input_vector = "0110") then
     	segmentform := "1111101" ;
    elsif (input_vector = "0111") then
     	segmentform := "0000111" ;
    elsif (input_vector = "1000") then
     	segmentform := "1111111";
    elsif (input_vector = "1001") then
     	segmentform := "1101111" ;
     	
    end if;
    return segmentform; 
end function;

constant c_timerlim	: integer := c_clkfreq/c_debtime;

signal timer		: integer range 0 to c_timerlim := 0;
signal milisaniye_b1 : STD_LOGIC_vector (3 downto 0) := (others => '0'); --b1 1. basamak b2 2. basamağı gösteriyor 0 9 arası 
signal milisaniye_b2 : STD_LOGIC_vector (3 downto 0) := (others => '0');
signal saniye_b1 : STD_LOGIC_vector (3 downto 0) := (others => '0');
signal saniye_b2 : STD_LOGIC_vector (3 downto 0) := (others => '0');
signal dakika_b1 : STD_LOGIC_vector (3 downto 0) := (others => '0');
signal dakika_b2 : STD_LOGIC_vector (3 downto 0) := (others => '0');

begin

process (clk) begin
if (rising_edge(clk)) then
    if (reset_in = '1') then
        timer <= 0;
        milisaniye_b1 <= (others => '0');
        milisaniye_b2 <= (others => '0');	
        saniye_b1 <= (others => '0');
        saniye_b2 <= (others => '0');
        dakika_b1 <= (others => '0');
        dakika_b2 <= (others => '0');
    
    elsif (start_in = '1') then
        if (timer = c_timerlim-1) then
            timer <= 0;
            
            -- CASCADING (ZİNCİRLEME) MANTIK:
            if (milisaniye_b1 = "1001") then
                milisaniye_b1 <= (others => '0');
                if (milisaniye_b2 = "1001") then -- 99 milisaniye doldu
                    milisaniye_b2 <= (others => '0');
                    
                    if (saniye_b1 = "1001") then
                        saniye_b1 <= (others => '0');
                        if (saniye_b2 = "0101") then -- 59 saniye doldu
                            saniye_b2 <= (others => '0');
                            
                            if (dakika_b1 = "1001") then
                                dakika_b1 <= (others => '0');
                                if (dakika_b2 = "0101") then -- 59 dakika doldu
                                    dakika_b2 <= (others => '0');
                                else
                                    dakika_b2 <= dakika_b2 + 1;
                                end if;
                            else
                                dakika_b1 <= dakika_b1 + 1;
                            end if;
                            
                        else
                            saniye_b2 <= saniye_b2 + 1;
                        end if;
                    else
                        saniye_b1 <= saniye_b1 + 1;
                    end if;
                    
                else
                    milisaniye_b2 <= milisaniye_b2 + 1;
                end if;
            else
                milisaniye_b1 <= milisaniye_b1 + 1;
            end if;
            
        else
            timer <= timer + 1;
    	end if;
    end if;



end if;
end process;
	

	

process (clk) begin
if (rising_edge(clk)) then
	milisaniye_b1_out <= vector_to_segment(milisaniye_b1);
	milisaniye_b2_out <= vector_to_segment(milisaniye_b2);
	saniye_b1_out  <= vector_to_segment(saniye_b1);
	saniye_b2_out  <= vector_to_segment(saniye_b2);
	dakika_b1_out  <= vector_to_segment(dakika_b1);
	dakika_b2_out  <= vector_to_segment(dakika_b2);
	
end if;
end process;

end Behavioral;
