----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/26/2023 04:39:27 PM
-- Design Name: 
-- Module Name: ssd_tb - Behavioral
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

entity ssd_tb is
--  Port ( );
end ssd_tb;

architecture Behavioral of ssd_tb is
    signal reset : std_logic;
    signal clk : std_logic := '0';
    signal seg : std_logic_vector(6 downto 0);
    signal an : std_logic_vector(3 downto 0);
    signal sw : std_logic_vector(15 downto 0) := "0000000000001111";
begin

    u_dut : entity work.ssd_top
    Port map (
        clk => clk,
        reset => reset,
        seg => seg,
        an => an,
        sw => sw
    );
    reset <= '1' , '0' after 5ns;
    clk <= not clk after 5ns;

end Behavioral;
