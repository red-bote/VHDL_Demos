----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/25/2024 02:57:10 PM
-- Design Name: 
-- Module Name: clk_gen - Behavioral
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

entity clk_gen is
    Port ( C : in STD_LOGIC;
           CLR : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR(3 downto 0));
end clk_gen;

architecture Behavioral of clk_gen is
    --signal count_reg : std_logic_vector(3 downto 0) := (others => '0');
    signal count_reg : std_logic_vector(3 downto 0);
    signal adder_out : std_logic_vector(3 downto 0);
begin

    u_adder : entity work.adders_1
    generic map (
        WIDTH => 4)
    port map (
        A => "0001",
        B => count_reg, -- in  std_logic_vector(WIDTH-1 downto 0);
        SUM => adder_out -- out std_logic_vector(WIDTH-1 downto 0)
        );

    u_clock_reg : entity work.registers_5
    port map (
        C => C, 
        CE => '1',
        PRE => CLR, -- in std_logic;
        D => adder_out, -- in std_logic_vector (3 downto 0);
        Q => count_reg -- out std_logic_vector (3 downto 0)
        );

    Q <= count_reg;

end Behavioral;
