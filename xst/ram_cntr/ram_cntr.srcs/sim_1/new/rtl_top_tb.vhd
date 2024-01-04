----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/04/2024 06:28:00 AM
-- Design Name: 
-- Module Name: rtl_top_tb - Behavioral
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

entity rtl_top_tb is
--  Port ( );
end rtl_top_tb;

architecture Behavioral of rtl_top_tb is
    signal clk : std_logic := '0';
    signal reset : std_logic;
    signal btnU : std_logic := '0';
    signal btnD : std_logic := '0';
    signal led : std_logic_vector(15 downto 0);
begin

    dut: entity work.rtl_top
    Port map (
        clk => clk,
        reset => reset,
        btnU => btnU,
        btnD => btnD,
        led => led
        );

    clk <= not clk after 5ns;
    reset <= '1',
             '0' after 10ns;

    btnU <= '0',
            '1' after 20ns;
             
end Behavioral;
