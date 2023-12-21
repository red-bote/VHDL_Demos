----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/16/2023 07:00:44 AM
-- Design Name: 
-- Module Name: rtl_project_top - Behavioral
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

entity rtl_project_top is
    generic(constant CNT_MAX : integer := 10000000/10); -- tenths second
--    generic(constant CNT_MAX : integer := 10); -- to simulate
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0));
end rtl_project_top;


architecture Behavioral of rtl_project_top is

    signal clk_mod_cnt : integer range 0 to CNT_MAX-1;
    signal count_n0 : std_logic_vector (3 downto 0);
    signal count_n1 : std_logic_vector (3 downto 0);
    signal count_n2 : std_logic_vector (3 downto 0);
    signal count_n3 : std_logic_vector (3 downto 0);
    signal ce_n0 : std_logic;
    signal ce_n1 : std_logic;
    signal ce_n2 : std_logic;
    signal ce_n3 : std_logic;
    signal count_outp : std_logic_vector (15 downto 0);
begin

    u_clk_div : entity work.counters_8
    generic map(MAX => CNT_MAX) -- integer := 12
    port map(
        C => clk,
        CLR => reset,
        Q  => clk_mod_cnt -- integer range 0 to MAX-1
    );

    ce_n0 <= '0' when clk_mod_cnt < CNT_MAX-1 else '1'; -- set Cy out when counter % MAX == 0

    u_cntr_0 : entity work. counters_5
    port map(
        C => clk,
        CLR => reset,
        CE => ce_n0,
        Q  => count_n0
    );

    ce_n1 <= count_n0(3) and count_n0(2) and count_n0(1) and count_n0(0) and ce_n0;
    u_cntr_1 : entity work. counters_5
    port map(
        C => clk,
        CLR => reset,
        CE => ce_n1,
        Q  => count_n1
    );

    ce_n2 <= count_n1(3) and count_n1(2) and count_n1(1) and count_n1(0) and ce_n1;
    u_cntr_2 : entity work. counters_5
    port map(
        C => clk,
        CLR => reset,
        CE => ce_n2,
        Q  => count_n2
    );

    ce_n3 <= count_n2(3) and count_n2(2) and count_n2(1) and count_n2(0) and ce_n2;
    u_cntr_3 : entity work. counters_5
    port map(
        C => clk,
        CLR => reset,
        CE => ce_n3,
        Q  => count_n3
    );

    count_outp <= count_n3 & count_n2 & count_n1 & count_n0;
    led <= count_outp;

end Behavioral;
