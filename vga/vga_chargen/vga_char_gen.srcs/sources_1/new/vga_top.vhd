----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/03/2023 08:23:16 AM
-- Design Name: 
-- Module Name: vga_top - Behavioral
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

entity vga_top is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           Hsync : out STD_LOGIC;
           Vsync : out STD_LOGIC;
           vgaRed : out STD_LOGIC_VECTOR (3 downto 0);
           vgaGreen : out STD_LOGIC_VECTOR (3 downto 0);
           vgaBlue : out STD_LOGIC_VECTOR (3 downto 0));
end vga_top;

architecture Behavioral of vga_top is
    signal clk_count : std_logic_vector (3 downto 0);
    signal reset_l : std_logic;
begin

    reset_l <= not reset;

    u_clkdiv : entity work.counters_1
    port map(
        C => clk,
        CLR => reset,
        Q => clk_count
        );

    u_crtc : entity work.crtc
    port map(
        clk_vga => clk_count(1),
        reset_l => reset_l,
        o_video_on => open,
        o_hsync => Hsync,
        o_vsync => Vsync,
        o_red => vgaRed,
        o_green => vgaGreen,
        o_blue => vgaBlue
        );

end Behavioral;
