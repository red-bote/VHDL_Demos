----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/01/2024 07:36:24 PM
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity crtc is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           o_vsync : out STD_LOGIC;
           o_hsync : out STD_LOGIC;
           o_rgb : out STD_LOGIC_VECTOR (23 downto 0);
           o_video_on : out STD_LOGIC);
end crtc;

architecture Behavioral of crtc is
    signal rgb : std_logic_vector(23 downto 0);
    signal reset_l : std_logic;
    signal video_on : std_logic;
    signal hsync : std_logic;
    signal vsync : std_logic;
    signal vga_row : integer;
    signal vga_col : integer; 
    signal r_hsync : std_logic;
    signal r_vsync : std_logic;
    signal r_video_on : std_logic;

    signal row_vector : STD_LOGIC_VECTOR (9 downto 0); --tmp?
    signal col_vector : STD_LOGIC_VECTOR (9 downto 0); --tmp?
begin
    reset_l <= not reset;

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
            pixel_clk => clk, -- 25 Mhz
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
        clk => clk,
        row => row_vector,
        col => col_vector,
        rgb => rgb
        );

    -- register the control signals to sync them with the RAM data
    p_video_sync : process(clk)
    begin
        if rising_edge(clk) then
            r_video_on <= video_on;
            r_hsync <= hsync;
            r_vsync <= vsync;
        end if;
    end process p_video_sync;

    -- if video_on = '1'
    o_rgb <= rgb when video_on = '1' else (others => '0');

    o_video_on <= r_video_on;
    o_hsync <= r_hsync;
    o_vsync <= r_vsync;

end Behavioral;
