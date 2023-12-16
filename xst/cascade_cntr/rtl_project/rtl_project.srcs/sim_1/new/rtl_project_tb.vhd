----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/16/2023 07:04:04 AM
-- Design Name: 
-- Module Name: rtl_project_tb - Behavioral
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

entity rtl_project_tb is
--  Port ( );
end rtl_project_tb;

architecture Behavioral of rtl_project_tb is
    signal clk : STD_LOGIC := '0';
    signal reset :  STD_LOGIC;
    signal sw : STD_LOGIC_VECTOR (15 downto 0);
    signal led : STD_LOGIC_VECTOR (15 downto 0);
begin

    DUT : entity work.rtl_project_top
        Port map (
           clk => clk,
           reset => reset,
           sw => (others => '0'),
           led => open
           );

    reset <= '1', '0' after 18ns;
    clk <= not clk after 5ns;

end Behavioral;
