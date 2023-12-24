----------------------------------------------------------------------------------
-- Company: Red~Bote
-- Engineer: Red~Bote
-- 
-- Create Date: 11/27/2023 02:56:21 PM
-- Design Name: 
-- Module Name: rams_top - Behavioral
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

entity rams_top is
    generic (constant CNTR_BITS : integer := 31);
    port (
        clk : in std_logic;
        reset : in std_logic;
        sw : in std_logic_vector (15 downto 0);
        led : out std_logic_vector (15 downto 0));
end rams_top;

architecture Behavioral of rams_top is
    signal counter_out : integer range 0 to (2**CNTR_BITS)-1;
    signal ram_address : std_logic_vector(5 downto 0);
    signal ram_data : std_logic_vector(19 downto 0);
begin

    u_counter : entity work.counters_8
        generic map(MAX => (2 ** CNTR_BITS)-1)
        port map(
            C => clk,
            CLR => reset, -- active high
            Q => counter_out); -- integer output

    clk_proc : process(clk)
        variable counter_reg : unsigned (CNTR_BITS-1 downto 0);
    begin
        if rising_edge (clk)
        then
            counter_reg := to_unsigned(counter_out, counter_reg'length);
            ram_address <= std_logic_vector(counter_reg(CNTR_BITS-1 downto 25));
        end if;
    end process clk_proc;

    u_rom : entity work.rams_21c
        port map(
            clk => clk,
            en => '1',
            addr => ram_address,
            data => ram_data
        );

    led(15 downto 0) <= ram_data(15 downto 0);

end Behavioral;
