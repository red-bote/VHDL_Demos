----------------------------------------------------------------------------------
-- Company: Red~Bote
-- Engineer: Red-Bote 
-- 
-- Create Date: 02/03/2024 07:20:14 AM
-- Design Name: 
-- Module Name: char_gen - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
--   Testing out a character generator ROM
-- Dependencies: 
--   HDL_Coding_Techniques/multiplexers/multiplexers_1.vhd
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
    signal pixel_shift : std_logic_vector(2 downto 0);

    signal row_vector : std_logic_vector (9 downto 0);
    signal col_vector : std_logic_vector (9 downto 0);
begin
    row_vector <= row;
    col_vector <= col;

    -- character ROM address generator
    p_charg_rom_addrgen : process(row_vector, col_vector)
    begin
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

    -- register the pixel shift to sync with 1-clock latency of ROM access
    p_pix_sync : process(clk)
    begin
        if rising_edge(clk) then
            pixel_shift <= col_vector(2 downto 0);
        end if;
    end process p_pix_sync;

    -- "shift" the pixel of the current scan column out of the character row data
    u_char_pix_mux: entity work.multiplexers_1
    port map(
        di => charg_rom_data,
        sel => pixel_shift, -- col_vector(2 downto 0),
        do => pixel_bit
    );
    rgb <= (others => '1') when pixel_bit = '1' else (others => '0') ;

end Behavioral;
