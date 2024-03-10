----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/25/2024 03:41:30 PM
-- Design Name: 
-- Module Name: rtl_tb - Behavioral
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

entity rtl_tb is
--  Port ( );
end rtl_tb;

architecture Behavioral of rtl_tb is
    signal reset : std_logic;
    signal clk : std_logic := '1';
begin

    u_dut : entity work.rtl_top
    Port map (
        clk => clk,
        reset => reset,
        led => open);

    clk <= not clk after 5ns;
    reset <= '1', '0' after 10ns;

end Behavioral;
