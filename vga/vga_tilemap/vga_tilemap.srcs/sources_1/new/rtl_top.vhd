----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/01/2024 05:12:07 PM
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
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           Hsync : out STD_LOGIC;
           Vsync : out STD_LOGIC;
           vgaRed : out STD_LOGIC_VECTOR (3 downto 0);
           vgaGreen : out STD_LOGIC_VECTOR (3 downto 0);
           vgaBlue : out STD_LOGIC_VECTOR (3 downto 0));
end rtl_top;

architecture Behavioral of rtl_top is
    signal vga_clk : std_logic;
    signal video_on : std_logic;
    signal clk_cnt : std_logic_vector (3 downto 0);
    signal rgb : std_logic_vector (23 downto 0);
begin

    u_clk : entity work.clock_div
    port map (
        C => clk,
        CLR => reset,
        Q => clk_cnt -- out std_logic_vector(3 downto 0)
        );
    vga_clk <= clk_cnt(1);

    u_crtc : entity work.crtc
    Port map (
        clk => vga_clk,
        reset => reset,
        o_vsync => Vsync,
        o_hsync => Hsync,
        o_rgb => rgb,
        o_video_on => video_on
        );

    --led(15) <= vga_clk; -- temp

--    vgaRed <= sw(11 downto 8) when video_on = '1' else (others => '0');
--    vgaGreen <= sw(7 downto 4) when video_on = '1' else (others => '0');
--    vgaBlue <= sw(3 downto 0) when video_on = '1' else (others => '0');
    vgaRed <= rgb(23 downto 20);
    vgaGreen <= rgb(15 downto 12);
    vgaBlue <= rgb(7 downto 4);

end Behavioral;
