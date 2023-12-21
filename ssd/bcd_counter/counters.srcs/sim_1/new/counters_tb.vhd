----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2023 06:59:49 AM
-- Design Name: 
-- Module Name: counters_tb - Behavioral
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

entity counters_tb is
--  Port ( );
end counters_tb;

architecture testbench of counters_tb is
    SIGNAL clk : std_logic := '0'; -- must be initialized
    SIGNAL reset : std_logic;
begin
    clk <= NOT clk AFTER 5ns;
    reset <= '1', '0' AFTER 5ns;

    dut : entity work.counters_top
    port map(
        clk => clk,
        reset => reset,
        led => open
        );
end testbench;
