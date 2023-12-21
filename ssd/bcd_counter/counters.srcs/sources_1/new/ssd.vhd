----------------------------------------------------------------------------------
-- Company: Red~Bote
-- Engineer: Neidermeier
-- 
-- Create Date: 12/18/2023 05:14:23 PM
-- Design Name: 
-- Module Name: ssd - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
--   4-digit seven-segment display driver, displays 16-bit value
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

entity ssd is
    generic(constant PS100HZ: integer := (100000000/1000));
    Port ( reset: in STD_LOGIC;
           clk : in STD_LOGIC;
           i_data : in STD_LOGIC_VECTOR (15 downto 0);
           o_anodes : out STD_LOGIC_VECTOR (3 downto 0);
           o_segments : out STD_LOGIC_VECTOR (7 downto 0));
end ssd;

architecture Behavioral of ssd is
    signal digit_bits : std_logic_vector(3 downto 0);
    signal seg_data : std_logic_vector(7 downto 0);
    signal prescaler : integer range 0 to PS100HZ-1;
    signal ce_n0 : std_logic;
    signal rfsh_cntr : std_logic_vector(3 downto 0);
    signal decoder_out : std_logic_vector(7 downto 0);
begin

    --(2) refresh counter (binary counter, with prescaler)
    u_clk_div : entity work.counters_8
    generic map(MAX => PS100HZ)
    port map(
        C => clk,
        CLR => reset,
        Q  => prescaler -- integer range 0 to MAX-1
    );
    ce_n0 <= '0' when prescaler < PS100HZ-1 else '1';

    u_cntr_0 : entity work. counters_5
    port map(
        C => clk,
        CLR => reset,
        CE => ce_n0,
        Q  => rfsh_cntr
    );

    -- (3) refresh counter drives the selection of the digit bits as well as the anode of the active digit
    --      (see decoders in XSTUG examples)
    digit_bits <= i_data(3 downto 0)  when rfsh_cntr(1 downto 0) = "00"
             else i_data(7 downto 4)  when rfsh_cntr(1 downto 0) = "01"
             else i_data(11 downto 8) when rfsh_cntr(1 downto 0) = "10"
             else i_data(15 downto 12);

    --(4) anode selection is low 4-bits of the 1-8 decoder
    u_decoder : entity work.decoders_2
        port map(
            sel => rfsh_cntr(2 downto 0), -- 3-bits in but only bits {0,1} significant
            res => decoder_out
        );
    o_anodes <= decoder_out(3 downto 0);

    -- (1) heart of the SSD is 4-bits lookup to 7-bits matrix of a single SSD digit
    seg_decode_p : process (digit_bits)
    begin
        case digit_bits is
            when "0000" => seg_data <= "01000000"; -- "0" 
            when "0001" => seg_data <= "01111001"; -- "1"
            when "0010" => seg_data <= "00100100"; -- "2"
            when "0011" => seg_data <= "00110000"; -- "3"
            when "0100" => seg_data <= "00011001"; -- "4"
            when "0101" => seg_data <= "00010010"; -- "5"
            when "0110" => seg_data <= "00000010"; -- "6"
            when "0111" => seg_data <= "01111000"; -- "7"
            when "1000" => seg_data <= "00000000"; -- "8" 
            when "1001" => seg_data <= "00010000"; -- "9"
            when "1010" => seg_data <= "00001000"; -- "A"
            when "1011" => seg_data <= "00000011"; -- "B"
            when "1100" => seg_data <= "01000110"; -- "C"
            when "1101" => seg_data <= "00100001"; -- "D"
            when "1110" => seg_data <= "00000110"; -- "E"
            when others => seg_data <= "00001110"; -- "F" (1111) 
        end case;
    end process seg_decode_p;

    o_segments <= seg_data;

end Behavioral;
