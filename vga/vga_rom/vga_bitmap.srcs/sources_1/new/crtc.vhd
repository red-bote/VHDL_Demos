----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/21/2024 12:43:18 PM
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
    Port ( i_clk_vga : in STD_LOGIC;
           i_reset_l : in STD_LOGIC;
           o_hsync : out STD_LOGIC;
           o_vsync : out STD_LOGIC;
           o_red : out STD_LOGIC_VECTOR (3 downto 0);
           o_green : out STD_LOGIC_VECTOR (3 downto 0);
           o_blue : out STD_LOGIC_VECTOR (3 downto 0));
end crtc;

architecture Behavioral of crtc is
    signal vga_col : integer;
    signal vga_row : integer;
    signal disp_ena : std_logic;

    signal ram_addr : std_logic_vector(5 downto 0);   
    signal ram_dout : std_logic_vector(31 downto 0);
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
            h_sync => o_hsync,
            v_sync => o_vsync,
            disp_ena => disp_ena,
            column => vga_col,
            row => vga_row,
            n_blank => open,
            n_sync => open
        );

    p_addr_gen : process(vga_row, vga_col)
        variable row_bits : std_logic_vector(9 downto 0) := std_logic_vector(to_unsigned(vga_row, 10));
        variable col_bits : std_logic_vector(9 downto 0) := std_logic_vector(to_unsigned(vga_col, 10));
    begin
        -- decode row and column into a 6-bit RAM address
        ram_addr <= row_bits(7 downto 6) & col_bits(8 downto 5);
    end process p_addr_gen;

    u_vram : entity work.rams_20c
    port map(
         clk => i_clk_vga,
         we => '0',
         addr => ram_addr,
         din => (others => '0'),
         dout => ram_dout
         );

    o_red    <= ram_dout(11 downto 8) when disp_ena = '1' else (others => '0');
    o_green  <= ram_dout(7 downto 4) when disp_ena = '1' else (others => '0');
    o_blue   <= ram_dout(3 downto 0) when disp_ena = '1' else (others => '0');

end Behavioral;
