----------------------------------------------------------------------------------
-- Company: Red~Bote
-- Engineer: Red~Bote
-- 
-- Create Date: 11/26/2023 04:25:17 PM
-- Design Name: 
-- Module Name: counters_8_top - Behavioral
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
use IEEE.STD_LOGIC_1164.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counters_8_top is
    generic (
        CNTR_BITS : integer := 30;
        CNTR_MAX : integer := 2 ** 30); -- note CNTR_BITS cannot be used within its own interface list
    port (
        clk : in std_logic;
        reset : in std_logic;
        sw : in std_logic_vector (15 downto 0);
        led : out std_logic_vector (15 downto 0));
end counters_8_top;

architecture Behavioral of counters_8_top is

    signal counter_out : integer range 0 to CNTR_MAX - 1; --  integer range 0 to MAX-1
    signal counter_reg : unsigned(CNTR_BITS - 1 downto 0); -- 30 bits wide, to match width of integer output Q from counter
    signal led_out_reg : std_logic_vector(CNTR_BITS - 1 downto 0);
begin

    u_counter : entity work.counters_8
        generic map(MAX => CNTR_MAX)
        port map(
            C => clk,
            CLR => reset, -- active high
            Q => counter_out); -- integer output

    clk_proc: process(clk)
        variable counter_var : unsigned(CNTR_BITS - 1 downto 0);
    begin
        if rising_edge(clk)
        then
            -- using this combined statement actually optimized away the additional counter_reg
            --led_out_reg <= std_logic_vector(to_unsigned(counter_out, counter_reg'length));

            -- the counter variable is actually optimized away avoiding the additional register
            counter_var := to_unsigned(counter_out, counter_var'length);
            led_out_reg <= std_logic_vector(counter_var);
        end if;
    end process;

--    counter_reg <= to_unsigned(counter_out, counter_reg'length);
--    led_out_reg <= std_logic_vector(counter_reg);

    led <= led_out_reg(29 downto 14);

end Behavioral;
