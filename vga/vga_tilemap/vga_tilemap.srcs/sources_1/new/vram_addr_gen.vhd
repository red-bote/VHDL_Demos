----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/03/2024 12:32:54 PM
-- Design Name: 
-- Module Name: vram_addr_gen - Behavioral
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

entity vram_addr_gen is
    generic (
        width : integer := 640;
        height : integer := 480
        );
    Port ( clk : in STD_LOGIC;
           scan_row : in STD_LOGIC_VECTOR (9 downto 0);
           scan_col : in STD_LOGIC_VECTOR (9 downto 0);
           address : out STD_LOGIC_VECTOR (13 downto 0));
end vram_addr_gen;

architecture Behavioral of vram_addr_gen is
    signal tile_row_addr : std_logic_vector (12 downto 0);
    signal tile_col_n : std_logic_vector (5 downto 0);
begin

    -- tile_col_n = scan_col >> 8

    tile_col_n <= scan_col(8 downto 3);

    -- tile_row_addr = (scan_row / 8) * 64 = (scan_row & (~0x08)) << 3
    --               = (scan_row >> 3) << 6
    --               = (scan_row & (~0x08)) << 3

    tile_row_addr(12 downto 6) <= scan_row(9 downto 3);
    tile_row_addr(5 downto 0) <= (others => '0');

    address(12 downto 0) <= tile_row_addr(12 downto 6) & tile_col_n;
    address(13) <= '0';

end Behavioral;
