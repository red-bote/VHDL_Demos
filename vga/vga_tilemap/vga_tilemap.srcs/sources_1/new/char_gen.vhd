----------------------------------------------------------------------------------
-- Company:  Red~Bote
-- Engineer: Red~Bote
-- 
-- Create Date: 02/03/2024 07:20:14 AM
-- Design Name: 
-- Module Name: char_gen - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: character generator with simulated VRAM
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

entity char_gen is
    generic (
        BM_WIDTH : integer := (64*8); -- 64*8==512;
        BM_HEIGHT : integer := 480
        );
    Port ( clk : in STD_LOGIC;
           row : in STD_LOGIC_VECTOR (9 downto 0);
           col : in STD_LOGIC_VECTOR (9 downto 0);
           rgb_out : out STD_LOGIC_VECTOR (23 downto 0));
end char_gen;

architecture Behavioral of char_gen is
    signal charg_rom_addr : std_logic_vector(8 downto 0);
    signal charg_rom_data : std_logic_vector(7 downto 0);

    signal pix_shift0 : std_logic_vector(2 downto 0);
    signal pix_shift1 : std_logic_vector(2 downto 0);
    signal pixel_bit : std_logic;

    signal row_vector : STD_LOGIC_VECTOR (9 downto 0);
    signal col_vector : STD_LOGIC_VECTOR (9 downto 0);

    signal vram_addr : std_logic_vector(13 downto 0);
    signal vram_data : std_logic_vector(7 downto 0);

    signal rgb : std_logic_vector(23 downto 0);

begin
    row_vector <= row;
    col_vector <= col;

    u_vram_addr : entity work.vram_addr_gen
    Port map (
        clk => clk,
        scan_row => row_vector, -- in STD_LOGIC_VECTOR (9 downto 0);
        scan_col => col_vector, -- in STD_LOGIC_VECTOR (9 downto 0);
        address => vram_addr -- out STD_LOGIC_VECTOR (13 downto 0)
        );

    u_vram : entity work.char_vram
	port map (
        Clk => clk,
        A => vram_addr,-- in std_logic_vector(13 downto 0);
        D => vram_data -- out std_logic_vector(7 downto 0)
	);

    -- character ROM address generator
    p_charg_rom_addrgen : process(vram_data, row_vector)
    begin
        -- ROM address = character_code * 8 + scan_row(2 downto 0);
        --             = character_code << 8 | (scan_row & 0x08)
        charg_rom_addr(8 downto 3) <= vram_data(5 downto 0);
        charg_rom_addr(2 downto 0) <= row_vector(2 downto 0);
    end process p_charg_rom_addrgen;

--    -- character ROM address generator
--    p_charg_rom_addrgen : process(row_vector, col_vector)
--    begin
--        --All 64 characters fit on 1 row of 640x480 display
--        charg_rom_addr(8 downto 3) <= col_vector(8 downto 3);
--        charg_rom_addr(2 downto 0) <= row_vector(2 downto 0);
--    end process p_charg_rom_addrgen;

    u_charg_rom : entity work.charg_rom
	port map (
        Clk => clk,
        A => charg_rom_addr, -- in std_logic_vector(8 downto 0);
        D => charg_rom_data -- out std_logic_vector(7 downto 0)
	);

    -- sync the pixel shift
    p_pix_sync : process(clk)
    begin
        if rising_edge(clk) then
            pix_shift1 <= col_vector(2 downto 0);
            pix_shift0 <= pix_shift1;
        end if;
    end process p_pix_sync;

    -- "shift" the pixel of the current scan column out of the character row data
    u_char_pix_mux: entity work.multiplexers_1
    port map(
        di => charg_rom_data,
        sel => pix_shift0, -- col_vector(2 downto 0),
        do => pixel_bit
    );

    rgb <= (others => '1') when pixel_bit = '1' else (others => '0') ;

--    -- check scan coordinate to be within valid extents of bitmap
--    rgb_out <= rgb when 
--        unsigned(row_vector) < BM_HEIGHT AND
--        --unsigned(row_vector) >= '0' AND
--        unsigned(col_vector) < BM_WIDTH
--        --unsigned(col_vector) >= '0'
--        else (others => '0');

    rgb_out <= rgb;

end Behavioral;
