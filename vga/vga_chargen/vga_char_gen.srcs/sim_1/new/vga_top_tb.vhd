----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/08/2024 06:31:43 PM
-- Design Name: 
-- Module Name: vga_top_tb - Behavioral
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

entity vga_top_tb is
--  Port ( );
end vga_top_tb;

architecture Behavioral of vga_top_tb is
    signal clk : std_logic := '1';
    signal reset : std_logic;
begin

    u_dut : entity work.vga_top
    Port map (
        clk => clk,
        reset => reset,
        Hsync => open,
        Vsync => open,
        vgaRed => open,
        vgaGreen => open,
        vgaBlue => open);

    clk <= not clk after 5ns;
    reset <= '1', '0' after 10ns;

end Behavioral;
