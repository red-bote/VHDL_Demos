----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/16/2024 08:09:02 PM
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
           Hsync : out STD_LOGIC;
           Vsync : out STD_LOGIC;
           vgaRed : out STD_LOGIC_VECTOR (3 downto 0);
           vgaGreen : out STD_LOGIC_VECTOR (3 downto 0);
           vgaBlue : out STD_LOGIC_VECTOR (3 downto 0));
end rtl_top;

architecture Behavioral of rtl_top is
    signal reset_l : std_logic;
    signal video_on : std_logic;
    signal clk_25 : std_logic;
    signal vga_hs : std_logic;
    signal vga_vs : std_logic;
    signal d_counters_1 : std_logic_vector(3 downto 0);
begin
    reset_l <= not reset;

--    u_vga_clk : entity work.clk_wiz_0_clk_wiz_0_clk_wiz
--    port map (
--        clk_out1 => clk_25,
--        reset => reset,
--        locked => open,
--        clk_in1 => clk
--    );

    u_vga_clk : entity work.counters_1
    port map(
        C => clk,
        CLR => reset,
        Q => d_counters_1 ---  out std_logic_vector(3 downto 0)
    );
    clk_25 <= d_counters_1(1);

    u_crtc : entity work.crtc
    Port map (
        clk_vga => clk_25,
        reset_l => reset_l,
        video_on => video_on,
        o_hsync => vga_hs,
        o_vsync => vga_vs,
        o_red => vgaRed,
        o_green => vgaGreen,
        o_blue => vgaBlue        
        );

    Hsync <= vga_hs;
    Vsync <= vga_vs;
--    vgaRed    <= sw(11 downto 8) when video_on = '1' else (others => '0');
--    vgaGreen  <= sw(7 downto 4) when video_on = '1' else (others => '0');
--    vgaBlue   <= sw(3 downto 0) when video_on = '1' else (others => '0');

end Behavioral;
