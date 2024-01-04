----------------------------------------------------------------------------------
-- Company: Red~Bote
-- Engineer: Neidermeier
-- 
-- Create Date: 01/02/2024 05:22:23 PM
-- Design Name: 
-- Module Name: rtl_top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
--   BRAM Demonstration
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
           constant DATA_BITS : integer := 16;
           constant ADDR_BITS : integer := 4); -- RAM address is 6-bits but only use lower 4
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           btnU : in STD_LOGIC;
           btnD : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR (15 downto 0));
end rtl_top;

architecture Behavioral of rtl_top is

    signal btn_U_deb : std_logic;
    signal btn_D_deb : std_logic;

    signal adder_sum : std_logic_vector (DATA_BITS-1 downto 0);
    signal cnt_add : std_logic_vector (DATA_BITS-1 downto 0);

    signal accum_inc : std_logic_vector ((ADDR_BITS-1) downto 0);
    signal accum_out : std_logic_vector ((ADDR_BITS-1) downto 0);

    -- RAM address is 6-bits 
    signal ram_addr : std_logic_vector (5 downto 0) := (others => '0');
    signal ram_dout : std_logic_vector (DATA_BITS-1 downto 0);
    signal ram_we : std_logic;

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

    p_address_inc : process(btn_U_deb)
    begin
        if btn_U_deb = '1' then
            accum_inc <= (others => '0');
            accum_inc(0) <= '1'; -- x"0001";
        else
            accum_inc <= (others => '0');
        end if;
    end process p_address_inc;

    u_accum : entity work.accumulators_2
    generic map (
        WIDTH => ADDR_BITS)
    port map (
        clk => clk,
        rst => reset,
        D => accum_inc,-- in  std_logic_vector(WIDTH-1 downto 0);
        Q => accum_out -- out std_logic_vector(WIDTH-1 downto 0));	 
    );

    ram_addr <= "00" & accum_out; -- RAM address width is 6-bits 

    p_cntr_step : process(btn_D_deb)
    begin
        if btn_D_deb = '1' then
            cnt_add <= (others => '0');
            cnt_add(0) <= '1'; -- x"0001";
            ram_we <= '1';
        else
            cnt_add <= (others => '0');
            ram_we <= '0';
        end if;
    end process p_cntr_step;

    u_adder_unsigned : entity work.adders_1
    generic map (
        WIDTH => DATA_BITS)
    port map (
        A => ram_dout,
        B => cnt_add,
        SUM => adder_sum
    );

    u_ram : entity work.rams_07
    port map (
        clk => clk,
        we => ram_we,
        a => ram_addr, -- in std_logic_vector(5 downto 0);
        di => adder_sum, -- in std_logic_vector(15 downto 0);
        do => ram_dout -- std_logic_vector(15 downto 0));
    );

--    led(3 downto 0) <= ram_dout(3 downto 0); -- only display lower bits of data word
--    led(15 downto 10) <= ram_addr;

    p_led_outp : process(clk)
    begin
        if rising_edge(clk) then
            led <= ram_addr &            -- 6
                   "000000" &            -- 6
                   ram_dout(3 downto 0); -- 4
        end if;
    end process p_led_outp;

end Behavioral;
