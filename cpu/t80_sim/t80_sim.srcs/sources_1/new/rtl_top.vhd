----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/20/2024 08:16:10 PM
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
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR (15 downto 0));
end rtl_top;

architecture Behavioral of rtl_top is
    signal reset_l : std_logic;
    signal clk_vga : std_logic;
    signal clk_cpu : std_logic;
    signal video_on : std_logic;
    signal clk_cnt : std_logic_vector (3 downto 0);
    signal rgb : std_logic_vector (23 downto 0);

    signal rom_data_out : std_logic_vector (7 downto 0);
    signal ram_wr_en : std_logic;
    signal ram_data_out : std_logic_vector(15 downto 0);
    signal ram_data_in : std_logic_vector(15 downto 0);
    signal ram_cs : std_logic;

    signal cpu_mreq_l : std_logic;
--    signal cpu_iorq_l       : std_logic;
    signal cpu_rd_l : std_logic;
    signal cpu_wr_l : std_logic;
    signal cpu_addr : std_logic_vector (15 downto 0);
    signal cpu_data_out : std_logic_vector (7 downto 0);
    signal cpu_data_in : std_logic_vector (7 downto 0);

    signal mem_rd : std_logic;
    signal mem_wr : std_logic;
begin

    reset_l <= not reset;

    u_clk : entity work.clock_gen
    port map (
        C => clk,
        CLR => reset,
        Q => clk_cnt -- out std_logic_vector(3 downto 0)
        );
    clk_vga <= clk_cnt(1);
    clk_cpu <= clk_cnt(3);

--    u_crtc : entity work.crtc
--    Port map (
--        clk => clk_vga,
--        reset => reset,
--        o_vsync => Vsync,
--        o_hsync => Hsync,
--        o_rgb => rgb,
--        o_video_on => video_on
--        );

    ram_cs <= cpu_addr(15);
    mem_rd <= not(cpu_rd_l or cpu_mreq_l);
--    cpu_data_in <= 
--                   ram_data_out(7 downto 0) when (ram_cs = '1' and mem_rd = '1') else
--                   rom_data_out             when (ram_cs = '0' and mem_rd = '1') else
--                   (others => '1');
    process(ram_cs, mem_rd)
    begin
        cpu_data_in <= (others => '1');
        if mem_rd = '1' then
            if ram_cs = '1' then
                cpu_data_in <= ram_data_out(7 downto 0);
            else
                cpu_data_in <= rom_data_out;
            end if;
        end if;
    end process;

    ram_wr_en <= not cpu_wr_l;
    ram_data_in <= x"00" & cpu_data_out;

    u_work_ram : entity work.rams_08
    port map (
        clk => clk, -- in std_logic;
        en => ram_cs, -- in std_logic;
        we => ram_wr_en, -- in std_logic;
        a => cpu_addr(5 downto 0), -- in std_logic_vector(5 downto 0);
        di => ram_data_in, -- in std_logic_vector(15 downto 0);
        do => ram_data_out -- out std_logic_vector(15 downto 0)
        );

    -- hex2rom -b  a.bin  prog_rom 6l8s > t80_sim.srcs/sources_1/new/prog_rom.vhd
    u_prog_rom : entity work.prog_rom
	port map (
        Clk => clk_cpu,
        A => cpu_addr(5 downto 0), -- in std_logic_vector(5 downto 0);
        D => rom_data_out -- out std_logic_vector(7 downto 0)
    );

    u_cpu : entity work.T80se
        port map(
            RESET_n => reset_l,
            CLK_n   => clk_cpu,
            CLKEN   => '1', -- cpu_ena,
            WAIT_n  => '1', -- cpu_wait_l,
            INT_n   => '1', -- cpu_int_l,
            NMI_n   => '1', -- cpu_nmi_l,
            BUSRQ_n => '1', -- cpu_busrq_l,
            M1_n    => open, -- cpu_m1_l,
            MREQ_n  => cpu_mreq_l,
            IORQ_n  => open, -- cpu_iorq_l,
            RD_n    => cpu_rd_l,
            WR_n    => cpu_wr_l,
            -- RFSH_n  => cpu_rfsh_l,
            -- HALT_n  => cpu_halt_l,
            -- BUSAK_n => cpu_busak_l,
            A       => cpu_addr,
            DI      => cpu_data_in,
            DO      => cpu_data_out
        );

    led <= cpu_addr; -- temp
end Behavioral;
