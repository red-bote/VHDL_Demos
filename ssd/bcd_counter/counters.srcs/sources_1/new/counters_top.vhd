----------------------------------------------------------------------------------
-- Company: Red~Bote
-- Engineer: Neidermeier
-- 
-- Create Date: 12/02/2023 06:58:11 AM
-- Design Name: 
-- Module Name: counters_top - Behavioral
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

entity counters_top is
--    generic(constant PRESCALE_MOD : integer := 100000000/100);
    generic(constant PRESCALE_MOD : integer := 100000000/10); -- tenths of a second
--    generic(constant PRESCALE_MOD : integer := 100000000/8);
--    generic(constant PRESCALE_MOD : integer := 100000000/4);
--    generic(constant PRESCALE_MOD : integer := 100000000/2);
--    generic(constant PRESCALE_MOD : integer := 10);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           an  :  out STD_LOGIC_VECTOR (3 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0));
end counters_top;

architecture Behavioral of counters_top is

    signal counter_ps : integer range 0 to PRESCALE_MOD-1;
    signal c_enable : std_logic;
    signal count_net : std_logic_vector (15 downto 0);
    signal seg_outp : std_logic_vector (7 downto 0);
    signal an_outp : std_logic_vector (3 downto 0);
begin

    u_cntr_prescaler : entity work.counters_8
    generic map(MAX => PRESCALE_MOD) -- integer := 12
    port map(
        C => clk,
        CLR => reset,
        Q  => counter_ps -- integer range 0 to MAX-1
    );

    c_enable <= '0' when counter_ps < PRESCALE_MOD-1 else '1';

    u_bcd_counter : entity work.bcd_counter
    Port map( 
        clk => clk,
        clk_en => c_enable, 
        reset => reset,
        o_count => count_net
        );

    u_ssd : entity work.ssd
    Port map(
        reset => reset,
        clk => clk,
        i_data => count_net,
        o_anodes => an_outp,
        o_segments => seg_outp
    );

    led <= count_net;
    an <= an_outp;
    seg <= seg_outp(6 downto 0);

end Behavioral;
