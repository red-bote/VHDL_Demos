----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/29/2023 08:08:21 PM
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
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           Hsync : out STD_LOGIC;
           Vsync : out STD_LOGIC;
           vgaRed : out STD_LOGIC_VECTOR (3 downto 0);
           vgaGreen : out STD_LOGIC_VECTOR (3 downto 0);
           vgaBlue : out STD_LOGIC_VECTOR (3 downto 0));
end vga_top;

architecture Behavioral of vga_top is
    signal clk_count : std_logic_vector(3 downto 0);

    signal clk_vga : std_logic;
    signal reset_l : std_logic;
    signal video_on : std_logic;
begin
    q_clkdiv : entity work.counters_1
    port map(
        C => clk,
        CLR => reset,
        Q => clk_count
        );

    clk_vga <= clk_count(1); -- pixel clock set to 25Mhz
    reset_l <= not reset;
    --------------------------------------------------
    u_vga_control : entity work.vga_controller
        GENERIC map (
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
            pixel_clk => clk_vga, -- 25 Mhz
            reset_n => reset_l,
            h_sync => Hsync,
            v_sync => Vsync,
            disp_ena => video_on,
            column => open, -- pixel_x,
            row => open, -- pixel_y,
            n_blank => open,
            n_sync => open
        );

    vgaRed    <= sw(11 downto 8) when video_on = '1' else (others => '0');
    vgaGreen  <= sw(7 downto 4) when video_on = '1' else (others => '0');
    vgaBlue   <= sw(3 downto 0) when video_on = '1' else (others => '0');

end Behavioral;
