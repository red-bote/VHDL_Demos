----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/25/2024 02:57:10 PM
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
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           hsync : out STD_LOGIC;
           vsync : out STD_LOGIC;
           rgb : out STD_LOGIC_VECTOR (23 downto 0));
end crtc;

architecture Behavioral of crtc is
    signal reset_l : std_logic;
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
            disp_ena => open, -- video_on,
            column => open, -- vga_col,
            row => open, -- vga_row,
            n_blank => open,
            n_sync => open
        );

end Behavioral;
