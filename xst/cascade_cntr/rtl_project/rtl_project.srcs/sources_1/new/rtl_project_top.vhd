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
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0));
end rtl_project_top;


architecture Behavioral of rtl_project_top is

    signal cntr5_out_n0 : std_logic_vector(3 downto 0);
    signal cntr5_out_n1 : std_logic_vector(3 downto 0);
    signal cntr5_ce0 : std_logic;
    signal cntr5_ce1 : std_logic;
begin

    cntr5_ce0 <= '1';

    u_cntr5_0 : entity work.counters_5
    port map(
        C => clk,
        CLR => reset,
        CE => cntr5_ce0,
        Q => cntr5_out_n0
        );

    cntr5_ce1 <= cntr5_out_n0(3) and cntr5_out_n0(2) and cntr5_out_n0(1) and cntr5_out_n0(0) and cntr5_ce0;

    u_cntr5_1 : entity work.counters_5
    port map(
        C => clk,
        CLR => reset,
        CE => cntr5_ce1,
        Q => cntr5_out_n1
        );
        
end Behavioral;
