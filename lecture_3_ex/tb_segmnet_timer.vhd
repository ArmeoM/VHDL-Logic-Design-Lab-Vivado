library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_segment_timer is

end tb_segment_timer;

architecture Behavioral of tb_segment_timer is

    
    component segment_timer
        generic (
            c_clkfreq : integer := 100_000_000;
            c_debtime : integer := 100_000
        );
        port (
            clk               : in  STD_LOGIC;
            start_in          : in  STD_LOGIC;
            reset_in          : in  STD_LOGIC;
            milisaniye_b1_out : out STD_LOGIC_VECTOR (6 downto 0);
            milisaniye_b2_out : out STD_LOGIC_VECTOR (6 downto 0);
            saniye_b1_out     : out STD_LOGIC_VECTOR (6 downto 0);
            saniye_b2_out     : out STD_LOGIC_VECTOR (6 downto 0);
            dakika_b1_out     : out STD_LOGIC_VECTOR (6 downto 0);
            dakika_b2_out     : out STD_LOGIC_VECTOR (6 downto 0)
        );
    end component;

    
    signal clk      : STD_LOGIC := '0';
    signal start_in : STD_LOGIC := '0';
    signal reset_in : STD_LOGIC := '0';
    
    -- Çıkışları izlemek için sinyaller
    signal ms1_out, ms2_out : STD_LOGIC_VECTOR(6 downto 0);
    signal sn1_out, sn2_out : STD_LOGIC_VECTOR(6 downto 0);
    signal dk1_out, dk2_out : STD_LOGIC_VECTOR(6 downto 0);

    
    constant clk_period : time := 10 ns;

begin

  
    uut: segment_timer
        generic map (
            c_clkfreq => 100,
            c_debtime => 10   
        )
        port map (
            clk               => clk,
            start_in          => start_in,
            reset_in          => reset_in,
            milisaniye_b1_out => ms1_out,
            milisaniye_b2_out => ms2_out,
            saniye_b1_out     => sn1_out,
            saniye_b2_out     => sn2_out,
            dakika_b1_out     => dk1_out,
            dakika_b2_out     => dk2_out
        );

   
    clk_process : process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    
    stim_proc: process
    begin		
    
        reset_in <= '1';
        wait for 100 ns;	
        reset_in <= '0';
        wait for 50 ns;


        start_in <= '1';

        wait for 10 us; 


        start_in <= '0';
   
        wait for 200 ns;
        
        -- Tekrar başlat
        start_in <= '1';
        wait for 5 us;

        -- Son Reset testi
        reset_in <= '1';
        wait for 100 ns;
        reset_in <= '0';

        start_in <= '1';
        wait for 61 ms ;



        report "Simulasyon bitti.";
        wait;
    end process;
process(ms1_out) -- ms1_out değiştikçe tetiklenir
begin

end process;

end Behavioral;