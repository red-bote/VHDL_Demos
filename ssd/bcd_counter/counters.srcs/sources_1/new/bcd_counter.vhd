----------------------------------------------------------------------------------
-- Company: Red~Bote
-- Engineer: Neidermeier
-- 
-- Create Date: 12/20/2023 01:06:29 PM
-- Design Name: 
-- Module Name: bcd_counter - Behavioral
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

entity bcd_counter is
    Port ( clk : in STD_LOGIC;
           clk_en : in STD_LOGIC;
           reset : in STD_LOGIC;
           o_count : out STD_LOGIC_VECTOR (15 downto 0));
end bcd_counter;

architecture Behavioral of bcd_counter is
    signal count_n0 : std_logic_vector (3 downto 0);
    signal count_n1 : std_logic_vector (3 downto 0);
    signal count_n2 : std_logic_vector (3 downto 0);
    signal count_n3 : std_logic_vector (3 downto 0);

    signal ce_d0 : std_logic;
    signal ce_d1 : std_logic;
    signal ce_d2 : std_logic;
    signal ce_d3 : std_logic;

    signal cy_d0 : std_logic;
    signal cy_d1 : std_logic;
    signal cy_d2 : std_logic;
    signal cy_d3 : std_logic;
begin

    ce_d0 <= clk_en;

    u_dig_0 : entity work.bcd_digit
    Port map(
        clk => clk,
        clk_en => ce_d0,
        reset => reset,
        o_data => count_n0,
        o_carry => cy_d0
    );

    ce_d1 <= cy_d0;

    u_dig_1 : entity work.bcd_digit
    Port map(
        clk => clk,
        clk_en => ce_d1,
        reset => reset,
        o_data => count_n1,
        o_carry => cy_d1
    );

    ce_d2 <= cy_d1;

    u_dig_2 : entity work.bcd_digit
    Port map(
        clk => clk,
        clk_en => ce_d2,
        reset => reset,
        o_data => count_n2,
        o_carry => cy_d2
    );

    ce_d3 <= cy_d2;

    u_dig_3 : entity work.bcd_digit
    Port map(
        clk => clk,
        clk_en => ce_d3,
        reset => reset,
        o_data => count_n3,
        o_carry => cy_d3
    );

    o_count <= count_n3 & count_n2 & count_n1 & count_n0;

end Behavioral;
