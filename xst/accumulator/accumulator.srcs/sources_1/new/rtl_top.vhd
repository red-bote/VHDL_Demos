----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/01/2024 05:11:53 PM
-- Design Name: 
-- Module Name: rtl_top - Behavioral
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

entity rtl_top is
    generic (
           constant COUNT_BITS : integer := 4);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           btnU : in STD_LOGIC;
           btnD : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR (15 downto 0));
end rtl_top;

architecture Behavioral of rtl_top is

    signal acc_cnt : std_logic_vector (COUNT_BITS-1 downto 0);
    signal acc_add : std_logic_vector (COUNT_BITS-1 downto 0);

    signal btn_U_deb : std_logic := '0';
    signal btn_D_deb : std_logic := '0';
begin

    u_btn_U_deb : entity work.btn_debounce
    Port map (
        clk => clk,
        btn_inp => btnU,
        btn_pressed => open,
        btn_make => open,
        btn_break => btn_U_deb
    );

    u_btn_D_deb : entity work.btn_debounce
    Port map (
        clk => clk,
        btn_inp => btnD,
        btn_pressed => open,
        btn_make => btn_D_deb,
        btn_break => open
    );

    acc_add <= x"1" when btn_U_deb = '1' or btn_D_deb = '1' else (others => '0');

    u_accum : entity work.accumulators_2
    generic map (
        WIDTH => COUNT_BITS)
    port map (
        clk  => clk,
        rst => reset,
        D => acc_add, -- in  std_logic_vector(WIDTH-1 downto 0);
        Q => acc_cnt -- out std_logic_vector(WIDTH-1 downto 0)
    );

    led(COUNT_BITS-1 downto 0) <= acc_cnt;

end Behavioral;
