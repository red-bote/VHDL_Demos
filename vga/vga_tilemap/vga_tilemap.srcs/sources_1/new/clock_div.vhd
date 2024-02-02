----------------------------------------------------------------------------------
-- Company: Red~Bote
-- Engineer: Red-Bote 
-- 
-- Create Date: 02/01/2024 05:14:58 PM
-- Design Name: 
-- Module Name: clock_div - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description:  4-bit unsigned up-counter with a synchronous reset.
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--  HDL_Coding_Techniques/counters/counters_4.vhd would work but needs the signal 
--  initialized for simulation to work.
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

entity clock_div is
    Port ( C : in STD_LOGIC;
           CLR : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR(3 downto 0));
end clock_div;

architecture Behavioral of clock_div is
    -- must initialize register for simulation
    signal count_reg : std_logic_vector(3 downto 0) := (others => '0');
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

    p_clock_reg : process(C)
    begin
        if rising_edge(C) then
            if CLR = '1' then
                count_reg <= "0000";
            else
                count_reg <= adder_out;
            end if;
        end if;
    end process p_clock_reg;

    Q <= count_reg;

end Behavioral;
