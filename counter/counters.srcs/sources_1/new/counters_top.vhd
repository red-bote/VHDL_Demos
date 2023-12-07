----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
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
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR (15 downto 0));
end counters_top;

architecture Behavioral of counters_top is
    signal count_n0 : std_logic_vector (3 downto 0);
    signal count_n1 : std_logic_vector (3 downto 0);
    signal count_n2 : std_logic_vector (3 downto 0);
    signal count_n3 : std_logic_vector (3 downto 0);
    signal count_n4 : std_logic_vector (3 downto 0);
    signal count_n5 : std_logic_vector (3 downto 0);
    signal count_n6 : std_logic_vector (3 downto 0);
    signal count_n7 : std_logic_vector (3 downto 0);
    signal count32 : std_logic_vector (31 downto 0);
begin
    u_counter0 : entity work.counters_1
    port map (
        C => clk,
        CLR => reset,
        Q => count_n0
        );

    u_counter1 : entity work.counters_1
    port map (
        C => count_n0(3), -- clk,
        CLR => reset,
        Q => count_n1
        );

    u_counter2 : entity work.counters_1
    port map (
        C => count_n1(3), -- clk,
        CLR => reset,
        Q => count_n2
        );

    u_counter3 : entity work.counters_1
    port map (
        C => count_n2(3), -- clk,
        CLR => reset,
        Q => count_n3
        );

    u_counter4 : entity work.counters_1
    port map (
        C => count_n3(3), -- clk,
        CLR => reset,
        Q => count_n4
        );

    u_counter5 : entity work.counters_1
    port map (
        C => count_n4(3), -- clk,
        CLR => reset,
        Q => count_n5
        );

    u_counter6 : entity work.counters_1
    port map (
        C => count_n5(3), -- clk,
        CLR => reset,
        Q => count_n6
        );

    u_counter7 : entity work.counters_1
    port map (
        C => count_n6(3), -- clk,
        CLR => reset,
        Q => count_n7
        );

    count32(31 downto 28) <= count_n7;
    count32(27 downto 24) <= count_n6;
    count32(23 downto 20) <= count_n5;
    count32(19 downto 16) <= count_n4;
    count32(15 downto 12) <= count_n3;
    count32(11 downto 8) <= count_n2;
    count32(7 downto 4) <= count_n1;
    count32(3 downto 0) <= count_n0;
--    led(15 downto 12) <= count_n7;
--    led(11 downto 8) <= count_n6;
--    led(7 downto 4) <= count_n5;
--    led(3 downto 0) <= count_n4;
    led <= count32(31 downto 16);

end Behavioral;
