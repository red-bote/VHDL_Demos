----------------------------------------------------------------------------------
-- Company: Red-Bote
-- Engineer: Neidermeier
-- 
-- Create Date: 12/26/2023 03:53:54 PM
-- Design Name: 
-- Module Name: ssd - Behavioral
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

entity ssd is
    Port ( 
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        data : in STD_LOGIC_VECTOR (15 downto 0);
        seg : out STD_LOGIC_VECTOR (6 downto 0);
        an : out STD_LOGIC_VECTOR (3 downto 0));
end ssd;

architecture Behavioral of ssd is
    signal digit_bits : std_logic_vector(3 downto 0);
    signal seg_data : std_logic_vector(7 downto 0);
    signal rfsh_cnt : std_logic_vector(1 downto 0);
    signal anode_sel : std_logic_vector(2 downto 0); -- temp for 1-8 decoder
    signal decoder_out : std_logic_vector(7 downto 0); -- temp for 1-8 decoder
begin
    -- 2-bits counter selects 1 of 4 anodes, and also selects 1 of the 4 sets 
    -- of 4-bit digits from the 16-bit data value
    u_rfsh_cnt : entity work.refresh_counter
    Port map (
        reset => reset,
        sys_clk => clk,
        rfsh_cnt => rfsh_cnt
    );

    -- digit selection
    p_digits : process (rfsh_cnt, data)
    begin
        if    (rfsh_cnt = "00") then digit_bits <= data(3 downto 0);
        elsif (rfsh_cnt = "01") then digit_bits <= data(7 downto 4);
        elsif (rfsh_cnt = "10") then digit_bits <= data(11 downto 8);
        else                         digit_bits <= data(15 downto 12);
        end if;
    end process p_digits;

    -- segment lookup table
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

    seg <= seg_data(6 downto 0);

    -- anode selection is low 4-bits of the 1-8 decoder
    anode_sel <= '0' & rfsh_cnt;
    u_decoder : entity work.decoders_2
        port map(
            sel => anode_sel,
            res => decoder_out
        );
    an <= decoder_out(3 downto 0);

end Behavioral;
