----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/29/2023 06:20:56 AM
-- Design Name: 
-- Module Name: ram_comp - Behavioral
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

entity ram_comp is
    Port ( clk : in STD_LOGIC;
           addr : in STD_LOGIC_VECTOR(5 downto 0);
           data : out STD_LOGIC_VECTOR(19 downto 0));
end ram_comp;

architecture arch_rams_21c of ram_comp is
    signal ram_addr : std_logic_vector(5 downto 0);
    signal ram_data : std_logic_vector(19 downto 0);
begin
    ram_addr <= addr;

    u_rom : entity work.rams_21c
    port map (
        clk => clk,
        en => '1',
        addr => ram_addr, -- in std_logic_vector(5 downto 0);
        data => ram_data -- out std_logic_vector(19 downto 0));
    );
    data <= ram_data;
end arch_rams_21c;

architecture arch_roms_1 of ram_comp is
    signal ram_addr : std_logic_vector(5 downto 0);
    signal ram_data : std_logic_vector(19 downto 0);
begin
    ram_addr <= addr;

    u_rom : entity work.roms_1
    port map (
        clk => clk,
        en => '1',
        addr => ram_addr, -- in std_logic_vector(5 downto 0);
        data => ram_data -- out std_logic_vector(19 downto 0));
    );
    data <= ram_data;
end arch_roms_1;

architecture arch_rams_21a of ram_comp is
    signal ram_addr : std_logic_vector(5 downto 0);
    signal ram_data : std_logic_vector(19 downto 0);
begin
    ram_addr <= addr;

    u_rom : entity work.rams_21a
    port map (
        clk => clk,
        en => '1',
        addr => ram_addr, -- in std_logic_vector(5 downto 0);
        data => ram_data -- out std_logic_vector(19 downto 0));
    );
    data <= ram_data;

end arch_rams_21a;
