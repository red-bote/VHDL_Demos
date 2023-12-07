----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/30/2023 01:21:41 PM
-- Design Name: 
-- Module Name: vga_tb - Behavioral
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

entity vga_tb is
--  Port ( );
end vga_tb;

architecture Behavioral of vga_tb is

    SIGNAL clk : std_logic := '0';
    SIGNAL reset : std_logic;

begin
    clk <= NOT clk AFTER 5ns;
    reset <= '1', '0' AFTER 10ns;

    dut : entity work.vga_top
    port map(
        clk => clk,
        reset => reset,
        sw => (others => '0'),
        led => open,
        Hsync => open,
        Vsync => open,
        vgaRed => open,
        vgaGreen => open,
        vgaBlue => open
        );

end Behavioral;
