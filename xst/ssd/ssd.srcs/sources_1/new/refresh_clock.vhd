----------------------------------------------------------------------------------
-- Company: Red-Bote
-- Engineer: Neidermeier
-- 
-- Create Date: 12/26/2023 06:32:29 PM
-- Design Name: 
-- Module Name: refresh_counter - Behavioral
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

entity refresh_counter is
    generic (PRESCALER : integer := 150000000/1000);
    Port (
        reset : in STD_LOGIC;
        sys_clk : in STD_LOGIC;
        rfsh_cnt : out STD_LOGIC_VECTOR (1 downto 0));
end refresh_counter;

architecture Behavioral of refresh_counter is
    signal presc_cnt : integer range 0 to PRESCALER-1;
    signal bin_count : std_logic_vector(3 downto 0);
    signal bin_cntr_ce : std_logic;
begin
    u_presc : entity work.counters_8
    generic map(MAX => PRESCALER)
    port map(
        C => sys_clk,
        CLR => reset,
        Q => presc_cnt -- integer range 0 to MAX-1);
    );

    bin_cntr_ce <= '0' when presc_cnt < (PRESCALER-1) else '1';

    u_bcntr : entity work.counters_5
    port map(
        C => sys_clk,
        CLR => reset,
        CE => bin_cntr_ce,
        Q => bin_count -- out std_logic_vector(3 downto 0)
        );

    rfsh_cnt <= bin_count(1 downto 0);

end Behavioral;
