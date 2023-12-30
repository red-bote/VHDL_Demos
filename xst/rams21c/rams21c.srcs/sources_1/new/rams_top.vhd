----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/28/2023 06:19:14 AM
-- Design Name: 
-- Module Name: rams_top - Behavioral
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

entity rams_top is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0));
end rams_top;

architecture Behavioral of rams_top is
    signal ram_addr : std_logic_vector(5 downto 0);
    signal ram_data : std_logic_vector(19 downto 0);
begin
    ram_addr <= sw(5 downto 0);

--    u_rom : entity work.rams_21c
--    port map (
--        clk => clk,
--        en => '1',
--        addr => ram_addr, -- in std_logic_vector(5 downto 0);
--        data => ram_data -- out std_logic_vector(19 downto 0));
--    );

--    u_ram : entity work.ram_comp(arch_rams_21a)
--    u_ram : entity work.ram_comp(arch_rams_21c)
    u_ram : entity work.ram_comp(arch_roms_1)
    Port map(
        clk => clk,
        addr => ram_addr,
        data => ram_data
        );

    out_proc : process(clk)
    begin
        if rising_edge(clk) then
            led <= ram_data(15 downto 0);
        end if;
    end process out_proc;

end Behavioral;
