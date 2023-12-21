----------------------------------------------------------------------------------
-- Company: Red~Bote
-- Engineer: Neidermeier
-- 
-- Create Date: 12/20/2023 01:22:43 PM
-- Design Name: 
-- Module Name: bcd_digit - Behavioral
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

entity bcd_digit is
    Port ( clk : in STD_LOGIC;
           clk_en : in STD_LOGIC;
           reset : in STD_LOGIC;
           o_data : out STD_LOGIC_VECTOR (3 downto 0);
           o_carry : out STD_LOGIC
    );

end bcd_digit;

architecture Behavioral of bcd_digit is
    signal clear : std_logic;
    signal counter : std_logic_vector(3 downto 0);
    signal carry : std_logic;

    signal cnt_q0 : std_logic_vector(3 downto 0);
begin

    -- clear is not reliable unless counter output is registered
--    clear <= '1' when (reset = '1' or (counter = "1010")) else '0'; -- 7999
    clear <= '1' when (reset = '1' or (cnt_q0 = "1010")) else '0';

    u_cntr_0 : entity work. counters_5
    port map(
        C => clk,
        CLR => clear,
        CE => clk_en,
        Q  => counter
    );

    p_clk : process(clk) is
    begin
        if rising_edge (clk) then
            cnt_q0 <= counter;
        end if;
    end process p_clk;

    carry <= '1' when (counter = "1001" and clk_en = '1') else '0';

    o_data <= counter;
    o_carry <= carry;

end Behavioral;
