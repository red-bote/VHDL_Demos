----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/25/2024 08:06:06 PM
-- Design Name: 
-- Module Name: rom_image - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity rom_image is
    Port ( disp_ena : in STD_LOGIC;
           clk : in std_logic;
           row : in integer;
           column : in integer;
           red : out STD_LOGIC_VECTOR (7 downto 0);
           green : out STD_LOGIC_VECTOR (7 downto 0);
           blue : out STD_LOGIC_VECTOR (7 downto 0));
end rom_image;

architecture Behavioral of rom_image is
    signal address : std_logic_vector(9 downto 0);
    signal data : std_logic_vector(31 downto 0);
begin

-- tenp address from column
    address <= std_logic_vector(TO_UNSIGNED (column, address'length));

    u_bmp_rom : entity work.bmp_rom
	port map (
		Clk	=> clk,
		A => address, -- in std_logic_vector(18 downto 0);
		D => data --  out std_logic_vector(31 downto 0)
	);

    red <= data(23 downto 16);
    green <= data(15 downto 8);
    blue <= data(7 downto 0);

end Behavioral;
