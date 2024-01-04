----------------------------------------------------------------------------------
-- Company: Red~Bote
-- Engineer: Neidermeier
-- 
-- Create Date: 01/01/2024 05:55:50 PM
-- Design Name: 
-- Module Name: btn_debounce - Behavioral
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

entity btn_debounce is
    Port ( clk : in STD_LOGIC;
           btn_inp : in STD_LOGIC;
           btn_pressed : out STD_LOGIC;
           btn_make : out STD_LOGIC;
           btn_break : out STD_LOGIC);
end btn_debounce;

architecture Behavioral of btn_debounce is
    signal break_flag : std_logic;
    signal make_flag : std_logic;
    signal pressed_flag : std_logic := '0';
    -- parallel output of shift register
    signal btn_po_reg : std_logic_vector(7 downto 0);
begin

    u_shift_reg : entity work.shift_registers_5
    port map (
        C => clk,
        SI => btn_inp,
        PO => btn_po_reg -- out std_logic_vector(7 downto 0));
    );

    p_clk_pr : process(clk) is
    begin
        if rising_edge(clk) then

            make_flag <= '0';
            break_flag <= '0';

            if btn_po_reg = x"FF" and pressed_flag = '0'
            then
                make_flag <= '1';
                pressed_flag <= '1';
            elsif btn_po_reg = x"00" and pressed_flag = '1'
            then
                break_flag <= '1';
                pressed_flag <= '0';
            end if;
        end if;
    end process p_clk_pr;

    btn_make <= make_flag;
    btn_break <= break_flag;
    btn_pressed <= pressed_flag;

end Behavioral;
