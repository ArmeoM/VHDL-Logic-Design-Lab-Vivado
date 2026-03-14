library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsıgned.all;
use IEEE.STD_LOGIC_arıth.all;

entity clk_ex is
	generic(
		c_clkfreq : integer := 100_000_000
	)
	port
	( clk : in STD_LOGIC;
		sw      : in  STD_Logic_vector (1 downto 0);
		counter : out STD_Logic_vector (7 downto 0)
	);

	end clk_ex;

	architecture Behavioral of clk_ex is

		constant C_timer1constant : integer                             := c_clkfreq * 2 ;
		constant C_timer2constant : integer                             := c_clkfreq ;
		constant C_timer3constant : integer                             := c_clkfreq /2;
		constant C_timer4constant : integer                             := c_clkfreq /4 ;
		signal timer              : integer range 0 to C_timer1constant := 0;
		signal timerlim           : integer range 0 to C_timer1constant := 0;
		signal counter_int        : STD_Logic_vector(7 downto 0)        := (others => '0');

	begin
		timerlim <= C_timer1constant when sw = "00" else
			C_timer2constant when sw = "01" else
			C_timer3constant when sw = "10" else
			C_timer4constant when sw = "11" ;
		process (clk) begin
			if (rising_edge(clk)) then
				if (timer = timerlim - 1) then

					counter_int <= counter_int + 1;
					timer       <= 0 ;
				else
					timer <= timer + 1


						end if;

				end if;
				end process;
				counter <= counter_int



					end Behavioral;
