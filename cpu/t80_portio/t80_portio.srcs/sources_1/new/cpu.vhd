----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/25/2024 02:57:10 PM
-- Design Name: 
-- Module Name: cpu - Behavioral
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

entity cpu is
    Port ( reset : in STD_LOGIC;
           vsync_l : in STD_LOGIC;
           clk_sys : in STD_LOGIC;
           clk_cpu : in STD_LOGIC;
           ext_outp : out STD_LOGIC_VECTOR(7 downto 0));
end cpu;

architecture Behavioral of cpu is

    signal reset_l : std_logic;

    signal rom_data_out : std_logic_vector (7 downto 0);
    signal ram_wr_en : std_logic;
    signal ram_data_out : std_logic_vector(15 downto 0);
    signal ram_data_in : std_logic_vector(15 downto 0);
    signal ram_cs : std_logic;

--    signal cpu_m1_l : std_logic;
    signal cpu_mreq_l : std_logic;
    signal cpu_iorq_l : std_logic;
    signal cpu_rd_l : std_logic;
    signal cpu_wr_l : std_logic;
    signal cpu_nmi_l : std_logic;
    signal cpu_addr : std_logic_vector (15 downto 0);
    signal cpu_data_out : std_logic_vector (7 downto 0);
    signal cpu_data_in : std_logic_vector (7 downto 0);

    signal mem_rd : std_logic;
--    signal mem_wr : std_logic;

    signal outp_dout_0 : std_logic_vector (3 downto 0);
    signal outp_dout_1 : std_logic_vector (3 downto 0);
    signal outp_enable : std_logic;

    signal outp_gate_0_l : std_logic;
    signal outp_gate_1_l : std_logic;

    signal outp_gate_0 : std_logic;
    signal outp_gate_1 : std_logic;
begin

    reset_l <= not reset;
    cpu_nmi_l <= vsync_l;

    ram_cs <= '1' when cpu_addr(15 downto 14) = "10" else '0'; -- work RAM at $80xx
    -- mem_rd <= not(cpu_rd_l or cpu_mreq_l);
    mem_rd <= (not cpu_rd_l and not cpu_mreq_l);

    process(ram_cs, mem_rd, ram_data_out, rom_data_out)
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

    -- ram_wr_en <= not (cpu_wr_l or cpu_mreq_l);
    ram_wr_en <= (not cpu_wr_l and not cpu_mreq_l);
    ram_data_in <= x"00" & cpu_data_out;

    u_work_ram : entity work.rams_sp_rf -- entity work.rams_08
    port map (
        clk => clk_sys, -- in std_logic;
        en => ram_cs, -- in std_logic;
        we => ram_wr_en, -- in std_logic;
        addr => cpu_addr(9 downto 0), -- in std_logic_vector(5 downto 0);
        di => ram_data_in, -- in std_logic_vector(15 downto 0);
        do => ram_data_out -- out std_logic_vector(15 downto 0)
        );

    -- hex2rom -b  a.bin  prog_rom 6l8s > t80_portio.srcs/sources_1/new/prog_rom.vhd
    u_prog_rom : entity work.prog_rom
	port map (
        Clk => clk_sys,
        A => cpu_addr(8 downto 0),
        D => rom_data_out
    );

    u_t80 : entity work.T80se
        port map(
            RESET_n => reset_l,
            CLK_n   => clk_cpu,
            CLKEN   => '1', -- cpu_ena,
            WAIT_n  => '1', -- cpu_wait_l,
            INT_n   => '1', -- cpu_int_l,
            NMI_n   => cpu_nmi_l,
            BUSRQ_n => '1', -- cpu_busrq_l,
            M1_n    => open, -- cpu_m1_l,
            MREQ_n  => cpu_mreq_l,
            IORQ_n  => cpu_iorq_l,
            RD_n    => cpu_rd_l,
            WR_n    => cpu_wr_l,
            -- RFSH_n  => cpu_rfsh_l,
            -- HALT_n  => cpu_halt_l,
            -- BUSAK_n => cpu_busak_l,
            A       => cpu_addr,
            DI      => cpu_data_in,
            DO      => cpu_data_out
        );

    outp_enable <= '1' when cpu_addr(7 downto 6) = "11" and cpu_iorq_l = '0' else '0';
    outp_gate_0 <= (outp_enable and not cpu_addr(0));
    outp_gate_1 <= (outp_enable and cpu_addr(0));

    u_outp0 : entity work.registers_5
    port map (
        C => clk_sys,
        CE => outp_gate_0, -- use as gate input
        PRE => reset,
        D => cpu_data_out(3 downto 0),
        Q => outp_dout_0
    );

    u_outp1 : entity work.registers_5
    port map (
        C => clk_sys,
        CE => outp_gate_1, -- use as gate input
        PRE => reset,
        D => cpu_data_out(3 downto 0),
        Q => outp_dout_1
    );

    ext_outp <= outp_dout_1 & outp_dout_0;

end Behavioral;
