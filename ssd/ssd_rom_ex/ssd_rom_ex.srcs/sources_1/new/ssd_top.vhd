----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/29/2023 08:31:47 AM
-- Design Name: 
-- Module Name: ssd_top - Behavioral
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

entity ssd_top is
    Generic (constant CNTR_BITS : integer := 30);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0));
end ssd_top;

architecture Behavioral of ssd_top is

    signal counter_out : integer range 0 to 2**CNTR_BITS-1;
    signal counter_reg : std_logic_vector(15 downto 0);
    signal digit_sel : std_logic_vector(2 downto 0); -- 3 bits, to be compatible with q_decoder
    signal digit_bits : std_logic_vector(3 downto 0);
    signal seg_data : std_logic_vector(7 downto 0);
    signal decoder_out : std_logic_vector(7 downto 0);

    signal ram_data_out : std_logic_vector (31 downto 0);
    signal ram_address : std_logic_vector (5 downto 0);
begin

    u_counter : entity work.counters_8
        generic map(MAX => 2 ** CNTR_BITS)
        port map(
            C => clk,
            CLR => reset, -- active high
            Q => counter_out); -- integer output

    dig_sel_p : process(clk)
        variable counter_var : unsigned (CNTR_BITS-1 downto 0);
    begin
        if rising_edge (clk)
        then
            counter_var := to_unsigned(counter_out, counter_var'length);
            counter_reg <= std_logic_vector(counter_var(CNTR_BITS-1 downto 14));

            digit_sel <= (others => '0');
            digit_sel(1 downto 0) <= std_logic_vector(counter_var(19 downto 18)); 
        end if;
    end process dig_sel_p;

    -- digit selection
    digits_p: process (digit_sel, counter_reg)
    begin
        if    (digit_sel = "000") then digit_bits <= counter_reg(3 downto 0);
        elsif (digit_sel = "001") then digit_bits <= counter_reg(7 downto 4);
        elsif (digit_sel = "010") then digit_bits <= counter_reg(11 downto 8);
        else                           digit_bits <= counter_reg(15 downto 12);
        end if;
    end process digits_p;

--    -- segment lookup table
--    u_rom : entity work.rams_21c
--        port map(
--            clk => clk,
--            en => '1',
--            addr => digit_bits,
--            data => seg_data
--        );
--    seg <= ram_data(6 downto 0);

--    seg_decode_p : process (digit_bits)
--    begin
--        case digit_bits is
--            when "0000" => seg_data <= "01000000"; -- "0" 
--            when "0001" => seg_data <= "01111001"; -- "1"
--            when "0010" => seg_data <= "00100100"; -- "2"
--            when "0011" => seg_data <= "00110000"; -- "3"
--            when "0100" => seg_data <= "00011001"; -- "4"
--            when "0101" => seg_data <= "00010010"; -- "5"
--            when "0110" => seg_data <= "00000010"; -- "6"
--            when "0111" => seg_data <= "01111000"; -- "7"
--            when "1000" => seg_data <= "00000000"; -- "8" 
--            when "1001" => seg_data <= "00010000"; -- "9"
--            when "1010" => seg_data <= "00001000"; -- "A"
--            when "1011" => seg_data <= "00000011"; -- "B"
--            when "1100" => seg_data <= "01000110"; -- "C"
--            when "1101" => seg_data <= "00100001"; -- "D"
--            when "1110" => seg_data <= "00000110"; -- "E"
--            when others => seg_data <= "00001110"; -- "F" (1111) 
--        end case;
--    end process seg_decode_p;
--    seg <= seg_data(6 downto 0);

    ram_address(5 downto 4) <= (others => '0');
    ram_address(3 downto 0) <= digit_bits;

    u_set_ram : entity work.rams_20c
        port map(
            clk => clk,
            we => '0',
            addr => ram_address,
            din => (others => '0'),
            dout => ram_data_out
            );
    seg <= ram_data_out(6 downto 0);

    -- anode selection is low 4-bits of the 1-8 decoder
    q_decoder : entity work.decoders_2
        port map(
            sel => digit_sel,
            res => decoder_out
        );
    an <= decoder_out(3 downto 0);

end Behavioral;
