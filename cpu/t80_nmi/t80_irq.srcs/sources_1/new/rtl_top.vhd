----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/25/2024 02:52:33 PM
-- Design Name: 
-- Module Name: rtl_top - Behavioral
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

entity rtl_top is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR (15 downto 0));
end rtl_top;

architecture Behavioral of rtl_top is
    signal clk_vga : std_logic;
    signal clk_cpu : std_logic;
    signal clk_cnt : std_logic_vector (3 downto 0);

    signal hsync_l : std_logic;
    signal vsync_l : std_logic;
begin

    u_clk : entity work.clk_gen
    port map (
        C => clk,
        CLR => reset,
        Q => clk_cnt -- out std_logic_vector(3 downto 0)
        );
    clk_vga <= clk_cnt(1);
    clk_cpu <= clk_cnt(3);

    u_cpu : entity work.cpu
    Port map ( 
        reset => reset,
        vsync_l => vsync_l,
        clk_sys => clk,
        clk_cpu => clk_cpu
    );

    u_crtc : entity work.crtc
    port map (
        clk => clk_vga,
        reset => reset,
        hsync => hsync_l,
        vsync => vsync_l,
        rgb => open -- out STD_LOGIC_VECTOR (23 downto 0)
        );

end Behavioral;
