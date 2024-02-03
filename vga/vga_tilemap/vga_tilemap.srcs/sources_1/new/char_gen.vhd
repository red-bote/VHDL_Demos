----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/03/2024 07:20:14 AM
-- Design Name: 
-- Module Name: char_gen - Behavioral
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

entity char_gen is
    Port ( clk : in STD_LOGIC;
           row : in STD_LOGIC_VECTOR (9 downto 0);
           col : in STD_LOGIC_VECTOR (9 downto 0);
           rgb : out STD_LOGIC_VECTOR (23 downto 0));
end char_gen;

architecture Behavioral of char_gen is
    signal charg_rom_addr : std_logic_vector(8 downto 0);
    signal charg_rom_data : std_logic_vector(7 downto 0);
    signal pixel_bit : std_logic;

    signal row_vector : STD_LOGIC_VECTOR (9 downto 0) := row; --tmp?
    signal col_vector : STD_LOGIC_VECTOR (9 downto 0) := col; --tmp?
--    signal vga_row : integer;
--    signal vga_col : integer;
begin

    -- character ROM address generator
    p_charg_rom_addrgen : process(row_vector, col_vector)
    begin
--        row_vector <= std_logic_vector(to_unsigned(vga_row, row_vector'length));
--        col_vector <= std_logic_vector(to_unsigned(vga_col, col_vector'length));

        --All 64 characters fit on 1 row of 640x480 display
        charg_rom_addr(8 downto 3) <= col_vector(8 downto 3);
        charg_rom_addr(2 downto 0) <= row_vector(2 downto 0);
    end process p_charg_rom_addrgen;

    u_charg_rom : entity work.charg_rom
	port map (
        Clk => clk,
        A => charg_rom_addr, -- in std_logic_vector(8 downto 0);
        D => charg_rom_data -- out std_logic_vector(7 downto 0)
	);

    -- "shift" the pixel of the current scan column out of the character row data
    u_char_pix_mux: entity work.multiplexers_1
    port map(
        di => charg_rom_data,
        sel => col_vector(2 downto 0),
        do => pixel_bit
    );
    rgb <= (others => '1') when pixel_bit = '1' else (others => '0') ;

end Behavioral;
