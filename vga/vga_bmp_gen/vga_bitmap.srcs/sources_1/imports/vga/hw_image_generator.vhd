--------------------------------------------------------------------------------
--
--   FileName:         hw_image_generator.vhd
--   Dependencies:     none
--   Design Software:  Quartus II 64-bit Version 12.1 Build 177 SJ Full Version
--
--   HDL CODE IS PROVIDED "AS IS."  DIGI-KEY EXPRESSLY DISCLAIMS ANY
--   WARRANTY OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING BUT NOT
--   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
--   PARTICULAR PURPOSE, OR NON-INFRINGEMENT. IN NO EVENT SHALL DIGI-KEY
--   BE LIABLE FOR ANY INCIDENTAL, SPECIAL, INDIRECT OR CONSEQUENTIAL
--   DAMAGES, LOST PROFITS OR LOST DATA, HARM TO YOUR EQUIPMENT, COST OF
--   PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR SERVICES, ANY CLAIMS
--   BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF),
--   ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER SIMILAR COSTS.
--
--   Version History
--   Version 1.0 05/10/2013 Scott Larson
--     Initial Public Release
--     Modified for ROM data 12/3/2023 Red~Bote
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

ENTITY hw_image_generator IS
  GENERIC(
    pixels_y :  INTEGER := 16;   --row that first color will persist until
    pixels_x :  INTEGER := 16);  --column that first color will persist until
  PORT(
    pixel_clk :  IN   STD_LOGIC;
    disp_ena :  IN   STD_LOGIC;  --display enable ('1' = display time, '0' = blanking time)
    row      :  IN   INTEGER;    --row pixel coordinate
    column   :  IN   INTEGER;    --column pixel coordinate
    red      :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');  --red magnitude output to DAC
    green    :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');  --green magnitude output to DAC
    blue     :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0')); --blue magnitude output to DAC
END hw_image_generator;

ARCHITECTURE behavior OF hw_image_generator IS

  signal pix_address : unsigned(5 downto 0) := (others => '0'); -- initialize for simulation
  signal pix_data : std_logic_vector(31 downto 0);

  signal column_r : unsigned(9 downto 0);
BEGIN

  p_pix_address : process(pixel_clk, row, column)
  begin
    if rising_edge(pixel_clk) then
      if(row < pixels_y AND column < pixels_x) THEN
        pix_address <= pix_address + 1;
      elsif (row >= pixels_y AND column >= pixels_x) OR (row = 0 AND column = 0) then  --  OR (row < pixels_y0 AND column >= pixels_x0)
        pix_address <= (others => '0');
      end if;
      
      column_r <= to_unsigned(column, column_r'length);

    end if;
  end process p_pix_address;

  u_vram : entity work.rams_20c
    port map(
         clk => pixel_clk,
         we => '0',
         addr => std_logic_vector(pix_address),
         din => (others => '0'),
         dout => pix_data);
         
  PROCESS(disp_ena, row, column_r, pix_data)
  BEGIN
    IF(disp_ena = '1') THEN        --display time
--      IF(row < pixels_y AND column < pixels_x) THEN
      IF(row < pixels_y AND column_r < pixels_x) THEN
        red <= pix_data(15 downto 8);
        green  <= pix_data(23 downto 16);
        blue <= pix_data(31 downto 24);
      ELSE
        red <= (OTHERS => '0');
        green  <= (OTHERS => '0');
        blue <= (OTHERS => '0');
      END IF;
    ELSE                           --blanking time
      red <= (OTHERS => '0');
      green <= (OTHERS => '0');
      blue <= (OTHERS => '0');
    END IF;
  
  END PROCESS;
END behavior;
