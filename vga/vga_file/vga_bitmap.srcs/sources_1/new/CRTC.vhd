----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/03/2023 08:40:56 AM
-- Design Name: 
-- Module Name: CRTC - Behavioral
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

entity CRTC is
    Port ( i_clk_vga : in STD_LOGIC;
           i_reset_l : in STD_LOGIC;
           o_hsync : out STD_LOGIC;
           o_vsync : out STD_LOGIC;
           o_Red : out STD_LOGIC_VECTOR (3 downto 0);
           o_Green : out STD_LOGIC_VECTOR (3 downto 0);
           o_Blue : out STD_LOGIC_VECTOR (3 downto 0));
end CRTC;

architecture Behavioral of CRTC is
    signal vga_col : integer;
    signal vga_row : integer;
    signal hsync : std_logic;
    signal vsync : std_logic;
    signal disp_ena : std_logic;
    signal RGB : std_logic_vector(23 downto 0);
begin

    u_vga_control : entity work.vga_controller
        generic map (
            h_pulse  => 96,
            h_bp     => 46,
            h_pixels => 640,
            h_fp     => 16,
            h_pol    => '0',
            v_pulse  => 2,
            v_bp     => 33,
            v_pixels => 480,
            v_fp     => 10,
            v_pol    => '0')
        port map(
            pixel_clk => i_clk_vga, -- 25 Mhz
            reset_n => i_reset_l,
            h_sync => hsync,
            v_sync => vsync,
            disp_ena => disp_ena,
            column => vga_col,
            row => vga_row,
            n_blank => open,
            n_sync => open
        );

    u_image_gen : entity work.hw_image_generator
    generic map(
        pixels_y => 240,
        pixels_x => 320)
    port map(
        pixel_clk => i_clk_vga, -- 25 Mhz
        disp_ena => disp_ena,
        row => vga_row,
        column => vga_col,
        red => RGB(23 downto 16),
        green => RGB(15 downto 8),
        blue => RGB(7 downto 0)
    );

    o_hsync <= hsync;
    o_vsync <= vsync;
    o_red <= RGB(23 downto 20);
    o_green <= RGB(15 downto 12);
    o_blue <= RGB(7 downto 4);

end Behavioral;
