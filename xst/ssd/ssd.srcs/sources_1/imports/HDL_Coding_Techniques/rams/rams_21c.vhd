--
-- ROMs Using Block RAM Resources.
-- VHDL code for a ROM with registered address
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/rams/rams_21c.vhd
--
library ieee;
use ieee.std_logic_1164.all;

-- RB: Numeric_std is preferred over std_logic_unsigned
-- use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

entity rams_21c is
port (clk : in std_logic;
      en : in std_logic;
      addr : in std_logic_vector(3 downto 0);
      data : out std_logic_vector(7 downto 0));
end rams_21c;

architecture syn of rams_21c is
--    type rom_type is array (63 downto 0) of std_logic_vector (19 downto 0);                 
--    signal ROM : rom_type:= (X"0200A", X"00300", X"08101", X"04000", X"08601", X"0233A",
--                             X"00300", X"08602", X"02310", X"0203B", X"08300", X"04002",
--                             X"08201", X"00500", X"04001", X"02500", X"00340", X"00241",
--                             X"04002", X"08300", X"08201", X"00500", X"08101", X"00602",
--                             X"04003", X"0241E", X"00301", X"00102", X"02122", X"02021",
--                             X"00301", X"00102", X"02222", X"04001", X"00342", X"0232B",
--                             X"00900", X"00302", X"00102", X"04002", X"00900", X"08201",
--                             X"02023", X"00303", X"02433", X"00301", X"04004", X"00301",
--                             X"00102", X"02137", X"02036", X"00301", X"00102", X"02237",
--                             X"04004", X"00304", X"04040", X"02500", X"02500", X"02500",
--                             X"0030D", X"02341", X"08201", X"0400D");                        

    signal raddr : std_logic_vector(3 downto 0);
begin

    process (clk)
    begin
        if (clk'event and clk = '1') then
            if (en = '1') then
                raddr <= addr;
            end if;
        end if;
    end process;

--    data <= ROM(conv_integer(raddr));
	process (raddr)
	begin
        case raddr is
                when "0000" => data <= "01000000"; -- "0" 
                when "0001" => data <= "01111001"; -- "1"
                when "0010" => data <= "00100100"; -- "2"
                when "0011" => data <= "00110000"; -- "3"
                when "0100" => data <= "00011001"; -- "4"
                when "0101" => data <= "00010010"; -- "5"
                when "0110" => data <= "00000010"; -- "6"
                when "0111" => data <= "01111000"; -- "7"
                when "1000" => data <= "00000000"; -- "8" 
                when "1001" => data <= "00010000"; -- "9"
                when "1010" => data <= "00001000"; -- "A"
                when "1011" => data <= "00000011"; -- "B"
                when "1100" => data <= "01000110"; -- "C"
                when "1101" => data <= "00100001"; -- "D"
                when "1110" => data <= "00000110"; -- "E"
                when others => data <= "00001110"; -- "F" (1111) 
        end case;
	end process;

end syn;
