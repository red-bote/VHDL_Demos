----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/16/2024 08:13:52 PM
-- Design Name: 
-- Module Name: crtc - Behavioral
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

entity crtc is
    Port ( clk_vga : in STD_LOGIC;
           reset_l : in STD_LOGIC;
           video_on : out STD_LOGIC;
           o_hsync : out STD_LOGIC;
           o_vsync : out STD_LOGIC;
           o_red : out STD_LOGIC_VECTOR (3 downto 0);
           o_green : out STD_LOGIC_VECTOR (3 downto 0);
           o_blue : out STD_LOGIC_VECTOR (3 downto 0));
end crtc;

architecture Behavioral of crtc is
    signal vga_col : integer;
    signal vga_row : integer;
    signal hsync : std_logic;
    signal vsync : std_logic;
    signal disp_ena : std_logic;
    signal RGB : std_logic_vector(23 downto 0);
begin

    u_vga_control : entity work.vga_controller
        GENERIC map (
            h_pulse  => 96,
            h_bp     => 48, --46, -- verify
            h_pixels => 640,
            h_fp     => 16,
            h_pol    => '0',
            v_pulse  => 2,
            v_bp     => 33,
            v_pixels => 480,
            v_fp     => 10,
            v_pol    => '0')
        port map(
            pixel_clk => clk_vga, -- 25 Mhz
            reset_n => reset_l,
            h_sync => Hsync,
            v_sync => Vsync,
            disp_ena => disp_ena,
            column => vga_col, -- pixel_x,
            row => vga_row, -- pixel_y,
            n_blank => open,
            n_sync => open
        );

--    u_image_gen_hw : entity work.hw_image_generator
--    generic map(
--        pixels_y => 240,
--        pixels_x => 320)
--    port map(
--        disp_ena => disp_ena,
--        row => vga_row,
--        column => vga_col,
--        red => RGB(23 downto 16),
--        green => RGB(15 downto 8),
--        blue => RGB(7 downto 0)
--    );

    u_image_gen_rom : entity work.rom_image
    port map(
        disp_ena => disp_ena,
        clk => clk_vga, 
        row => vga_row,
        column => vga_col,
        red => RGB(23 downto 16),
        green => RGB(15 downto 8),
        blue => RGB(7 downto 0)
    );

    video_on <= disp_ena;
    o_hsync <= hsync;
    o_vsync <= vsync;
    o_red <= RGB(23 downto 20);
    o_green <= RGB(15 downto 12);
    o_blue <= RGB(7 downto 4);

end Behavioral;
