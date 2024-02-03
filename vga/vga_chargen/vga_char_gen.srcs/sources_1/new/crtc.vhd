----------------------------------------------------------------------------------
-- Company:  Red~Bote
-- Engineer: Red~Bote
-- 
-- Create Date: 01/16/2024 08:13:52 PM
-- Design Name: 
-- Module Name: crtc - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: VGA image and signal sync test
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity crtc is
    Port ( clk_vga : in STD_LOGIC;
           reset_l : in STD_LOGIC;
           o_video_on : out STD_LOGIC;
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
    signal video_on : std_logic;
    signal r_hsync : std_logic;
    signal r_vsync : std_logic;
    signal r_video_on : std_logic;
    signal rgb : std_logic_vector(23 downto 0);

    signal charg_rom_addr : std_logic_vector(8 downto 0);
    signal charg_rom_data : std_logic_vector(7 downto 0);
    signal row_vector :  std_logic_vector(9 downto 0);
    signal col_vector :  std_logic_vector(9 downto 0);
    signal pixel_bit : std_logic;
begin

    u_vga_control : entity work.vga_controller
        GENERIC map (
            h_pulse  => 96,
            h_bp     => 48,
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
            h_sync => hsync,
            v_sync => vsync,
            disp_ena => video_on,
            column => vga_col,
            row => vga_row,
            n_blank => open,
            n_sync => open
        );

    row_vector <= std_logic_vector(to_unsigned(vga_row, row_vector'length));
    col_vector <= std_logic_vector(to_unsigned(vga_col, col_vector'length));

    u_char_gen : entity work.char_gen
    Port map ( 
        clk => clk_vga,
        row => row_vector,
        col => col_vector,
        rgb => rgb
        );

    -- register the control signals to sync them with the RAM data
    p_video_sync : process(clk_vga)
    begin
        if rising_edge(clk_vga) then
            r_video_on <= video_on;
            r_hsync <= hsync;
            r_vsync <= vsync;
        end if;
    end process p_video_sync;

    -- gate the video data from the ROM only if within the visible portion of the VGA signal
    p_video_enable : process(r_video_on, rgb)
    begin
        if r_video_on = '1' then
            o_red <= rgb(23 downto 20);
            o_green <= rgb(15 downto 12);
            o_blue <= rgb(7 downto 4);
        else
            o_red <= (others => '0');
            o_green <= (others => '0');
            o_blue <= (others => '0');
        end if;
    end process p_video_enable;

    o_video_on <= r_video_on;
    o_hsync <= r_hsync;
    o_vsync <= r_vsync;

end Behavioral;
