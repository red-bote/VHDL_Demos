-- This file was generated with hex2rom written by Daniel Wallner

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity prog_rom is
	port(
		Clk	: in std_logic;
		A	: in std_logic_vector(8 downto 0);
		D	: out std_logic_vector(7 downto 0)
	);
end prog_rom;

architecture rtl of prog_rom is
	signal A_r : std_logic_vector(8 downto 0);
begin
	process (Clk)
	begin
		if Clk'event and Clk = '1' then
			A_r <= A;
		end if;
	end process;
	process (A_r)
	begin
		case to_integer(unsigned(A_r)) is
		when 000000 => D <= "11110011";	-- 0x0000
		when 000001 => D <= "00110001";	-- 0x0001
		when 000002 => D <= "00000000";	-- 0x0002
		when 000003 => D <= "10000100";	-- 0x0003
		when 000004 => D <= "00111110";	-- 0x0004
		when 000005 => D <= "10101011";	-- 0x0005
		when 000006 => D <= "11010011";	-- 0x0006
		when 000007 => D <= "11000000";	-- 0x0007
		when 000008 => D <= "00111110";	-- 0x0008
		when 000009 => D <= "11001101";	-- 0x0009
		when 000010 => D <= "11010011";	-- 0x000A
		when 000011 => D <= "11000001";	-- 0x000B
		when 000012 => D <= "11000011";	-- 0x000C
		when 000013 => D <= "00000000";	-- 0x000D
		when 000014 => D <= "00000001";	-- 0x000E
		when 000015 => D <= "00000000";	-- 0x000F
		when 000016 => D <= "00000000";	-- 0x0010
		when 000017 => D <= "00000000";	-- 0x0011
		when 000018 => D <= "00000000";	-- 0x0012
		when 000019 => D <= "00000000";	-- 0x0013
		when 000020 => D <= "00000000";	-- 0x0014
		when 000021 => D <= "00000000";	-- 0x0015
		when 000022 => D <= "00000000";	-- 0x0016
		when 000023 => D <= "00000000";	-- 0x0017
		when 000024 => D <= "00000000";	-- 0x0018
		when 000025 => D <= "00000000";	-- 0x0019
		when 000026 => D <= "00000000";	-- 0x001A
		when 000027 => D <= "00000000";	-- 0x001B
		when 000028 => D <= "00000000";	-- 0x001C
		when 000029 => D <= "00000000";	-- 0x001D
		when 000030 => D <= "00000000";	-- 0x001E
		when 000031 => D <= "00000000";	-- 0x001F
		when 000032 => D <= "00000000";	-- 0x0020
		when 000033 => D <= "00000000";	-- 0x0021
		when 000034 => D <= "00000000";	-- 0x0022
		when 000035 => D <= "00000000";	-- 0x0023
		when 000036 => D <= "00000000";	-- 0x0024
		when 000037 => D <= "00000000";	-- 0x0025
		when 000038 => D <= "00000000";	-- 0x0026
		when 000039 => D <= "00000000";	-- 0x0027
		when 000040 => D <= "00000000";	-- 0x0028
		when 000041 => D <= "00000000";	-- 0x0029
		when 000042 => D <= "00000000";	-- 0x002A
		when 000043 => D <= "00000000";	-- 0x002B
		when 000044 => D <= "00000000";	-- 0x002C
		when 000045 => D <= "00000000";	-- 0x002D
		when 000046 => D <= "00000000";	-- 0x002E
		when 000047 => D <= "00000000";	-- 0x002F
		when 000048 => D <= "00000000";	-- 0x0030
		when 000049 => D <= "00000000";	-- 0x0031
		when 000050 => D <= "00000000";	-- 0x0032
		when 000051 => D <= "00000000";	-- 0x0033
		when 000052 => D <= "00000000";	-- 0x0034
		when 000053 => D <= "00000000";	-- 0x0035
		when 000054 => D <= "00000000";	-- 0x0036
		when 000055 => D <= "00000000";	-- 0x0037
		when 000056 => D <= "00000000";	-- 0x0038
		when 000057 => D <= "00000000";	-- 0x0039
		when 000058 => D <= "00000000";	-- 0x003A
		when 000059 => D <= "00000000";	-- 0x003B
		when 000060 => D <= "00000000";	-- 0x003C
		when 000061 => D <= "00000000";	-- 0x003D
		when 000062 => D <= "00000000";	-- 0x003E
		when 000063 => D <= "00000000";	-- 0x003F
		when 000064 => D <= "00000000";	-- 0x0040
		when 000065 => D <= "00000000";	-- 0x0041
		when 000066 => D <= "00000000";	-- 0x0042
		when 000067 => D <= "00000000";	-- 0x0043
		when 000068 => D <= "00000000";	-- 0x0044
		when 000069 => D <= "00000000";	-- 0x0045
		when 000070 => D <= "00000000";	-- 0x0046
		when 000071 => D <= "00000000";	-- 0x0047
		when 000072 => D <= "00000000";	-- 0x0048
		when 000073 => D <= "00000000";	-- 0x0049
		when 000074 => D <= "00000000";	-- 0x004A
		when 000075 => D <= "00000000";	-- 0x004B
		when 000076 => D <= "00000000";	-- 0x004C
		when 000077 => D <= "00000000";	-- 0x004D
		when 000078 => D <= "00000000";	-- 0x004E
		when 000079 => D <= "00000000";	-- 0x004F
		when 000080 => D <= "00000000";	-- 0x0050
		when 000081 => D <= "00000000";	-- 0x0051
		when 000082 => D <= "00000000";	-- 0x0052
		when 000083 => D <= "00000000";	-- 0x0053
		when 000084 => D <= "00000000";	-- 0x0054
		when 000085 => D <= "00000000";	-- 0x0055
		when 000086 => D <= "00000000";	-- 0x0056
		when 000087 => D <= "00000000";	-- 0x0057
		when 000088 => D <= "00000000";	-- 0x0058
		when 000089 => D <= "00000000";	-- 0x0059
		when 000090 => D <= "00000000";	-- 0x005A
		when 000091 => D <= "00000000";	-- 0x005B
		when 000092 => D <= "00000000";	-- 0x005C
		when 000093 => D <= "00000000";	-- 0x005D
		when 000094 => D <= "00000000";	-- 0x005E
		when 000095 => D <= "00000000";	-- 0x005F
		when 000096 => D <= "00000000";	-- 0x0060
		when 000097 => D <= "00000000";	-- 0x0061
		when 000098 => D <= "00000000";	-- 0x0062
		when 000099 => D <= "00000000";	-- 0x0063
		when 000100 => D <= "00000000";	-- 0x0064
		when 000101 => D <= "00000000";	-- 0x0065
		when 000102 => D <= "11101101";	-- 0x0066
		when 000103 => D <= "01000101";	-- 0x0067
		when 000104 => D <= "00000000";	-- 0x0068
		when 000105 => D <= "00000000";	-- 0x0069
		when 000106 => D <= "00000000";	-- 0x006A
		when 000107 => D <= "00000000";	-- 0x006B
		when 000108 => D <= "00000000";	-- 0x006C
		when 000109 => D <= "00000000";	-- 0x006D
		when 000110 => D <= "00000000";	-- 0x006E
		when 000111 => D <= "00000000";	-- 0x006F
		when 000112 => D <= "00000000";	-- 0x0070
		when 000113 => D <= "00000000";	-- 0x0071
		when 000114 => D <= "00000000";	-- 0x0072
		when 000115 => D <= "00000000";	-- 0x0073
		when 000116 => D <= "00000000";	-- 0x0074
		when 000117 => D <= "00000000";	-- 0x0075
		when 000118 => D <= "00000000";	-- 0x0076
		when 000119 => D <= "00000000";	-- 0x0077
		when 000120 => D <= "00000000";	-- 0x0078
		when 000121 => D <= "00000000";	-- 0x0079
		when 000122 => D <= "00000000";	-- 0x007A
		when 000123 => D <= "00000000";	-- 0x007B
		when 000124 => D <= "00000000";	-- 0x007C
		when 000125 => D <= "00000000";	-- 0x007D
		when 000126 => D <= "00000000";	-- 0x007E
		when 000127 => D <= "00000000";	-- 0x007F
		when 000128 => D <= "00000000";	-- 0x0080
		when 000129 => D <= "00000000";	-- 0x0081
		when 000130 => D <= "00000000";	-- 0x0082
		when 000131 => D <= "00000000";	-- 0x0083
		when 000132 => D <= "00000000";	-- 0x0084
		when 000133 => D <= "00000000";	-- 0x0085
		when 000134 => D <= "00000000";	-- 0x0086
		when 000135 => D <= "00000000";	-- 0x0087
		when 000136 => D <= "00000000";	-- 0x0088
		when 000137 => D <= "00000000";	-- 0x0089
		when 000138 => D <= "00000000";	-- 0x008A
		when 000139 => D <= "00000000";	-- 0x008B
		when 000140 => D <= "00000000";	-- 0x008C
		when 000141 => D <= "00000000";	-- 0x008D
		when 000142 => D <= "00000000";	-- 0x008E
		when 000143 => D <= "00000000";	-- 0x008F
		when 000144 => D <= "00000000";	-- 0x0090
		when 000145 => D <= "00000000";	-- 0x0091
		when 000146 => D <= "00000000";	-- 0x0092
		when 000147 => D <= "00000000";	-- 0x0093
		when 000148 => D <= "00000000";	-- 0x0094
		when 000149 => D <= "00000000";	-- 0x0095
		when 000150 => D <= "00000000";	-- 0x0096
		when 000151 => D <= "00000000";	-- 0x0097
		when 000152 => D <= "00000000";	-- 0x0098
		when 000153 => D <= "00000000";	-- 0x0099
		when 000154 => D <= "00000000";	-- 0x009A
		when 000155 => D <= "00000000";	-- 0x009B
		when 000156 => D <= "00000000";	-- 0x009C
		when 000157 => D <= "00000000";	-- 0x009D
		when 000158 => D <= "00000000";	-- 0x009E
		when 000159 => D <= "00000000";	-- 0x009F
		when 000160 => D <= "00000000";	-- 0x00A0
		when 000161 => D <= "00000000";	-- 0x00A1
		when 000162 => D <= "00000000";	-- 0x00A2
		when 000163 => D <= "00000000";	-- 0x00A3
		when 000164 => D <= "00000000";	-- 0x00A4
		when 000165 => D <= "00000000";	-- 0x00A5
		when 000166 => D <= "00000000";	-- 0x00A6
		when 000167 => D <= "00000000";	-- 0x00A7
		when 000168 => D <= "00000000";	-- 0x00A8
		when 000169 => D <= "00000000";	-- 0x00A9
		when 000170 => D <= "00000000";	-- 0x00AA
		when 000171 => D <= "00000000";	-- 0x00AB
		when 000172 => D <= "00000000";	-- 0x00AC
		when 000173 => D <= "00000000";	-- 0x00AD
		when 000174 => D <= "00000000";	-- 0x00AE
		when 000175 => D <= "00000000";	-- 0x00AF
		when 000176 => D <= "00000000";	-- 0x00B0
		when 000177 => D <= "00000000";	-- 0x00B1
		when 000178 => D <= "00000000";	-- 0x00B2
		when 000179 => D <= "00000000";	-- 0x00B3
		when 000180 => D <= "00000000";	-- 0x00B4
		when 000181 => D <= "00000000";	-- 0x00B5
		when 000182 => D <= "00000000";	-- 0x00B6
		when 000183 => D <= "00000000";	-- 0x00B7
		when 000184 => D <= "00000000";	-- 0x00B8
		when 000185 => D <= "00000000";	-- 0x00B9
		when 000186 => D <= "00000000";	-- 0x00BA
		when 000187 => D <= "00000000";	-- 0x00BB
		when 000188 => D <= "00000000";	-- 0x00BC
		when 000189 => D <= "00000000";	-- 0x00BD
		when 000190 => D <= "00000000";	-- 0x00BE
		when 000191 => D <= "00000000";	-- 0x00BF
		when 000192 => D <= "00000000";	-- 0x00C0
		when 000193 => D <= "00000000";	-- 0x00C1
		when 000194 => D <= "00000000";	-- 0x00C2
		when 000195 => D <= "00000000";	-- 0x00C3
		when 000196 => D <= "00000000";	-- 0x00C4
		when 000197 => D <= "00000000";	-- 0x00C5
		when 000198 => D <= "00000000";	-- 0x00C6
		when 000199 => D <= "00000000";	-- 0x00C7
		when 000200 => D <= "00000000";	-- 0x00C8
		when 000201 => D <= "00000000";	-- 0x00C9
		when 000202 => D <= "00000000";	-- 0x00CA
		when 000203 => D <= "00000000";	-- 0x00CB
		when 000204 => D <= "00000000";	-- 0x00CC
		when 000205 => D <= "00000000";	-- 0x00CD
		when 000206 => D <= "00000000";	-- 0x00CE
		when 000207 => D <= "00000000";	-- 0x00CF
		when 000208 => D <= "00000000";	-- 0x00D0
		when 000209 => D <= "00000000";	-- 0x00D1
		when 000210 => D <= "00000000";	-- 0x00D2
		when 000211 => D <= "00000000";	-- 0x00D3
		when 000212 => D <= "00000000";	-- 0x00D4
		when 000213 => D <= "00000000";	-- 0x00D5
		when 000214 => D <= "00000000";	-- 0x00D6
		when 000215 => D <= "00000000";	-- 0x00D7
		when 000216 => D <= "00000000";	-- 0x00D8
		when 000217 => D <= "00000000";	-- 0x00D9
		when 000218 => D <= "00000000";	-- 0x00DA
		when 000219 => D <= "00000000";	-- 0x00DB
		when 000220 => D <= "00000000";	-- 0x00DC
		when 000221 => D <= "00000000";	-- 0x00DD
		when 000222 => D <= "00000000";	-- 0x00DE
		when 000223 => D <= "00000000";	-- 0x00DF
		when 000224 => D <= "00000000";	-- 0x00E0
		when 000225 => D <= "00000000";	-- 0x00E1
		when 000226 => D <= "00000000";	-- 0x00E2
		when 000227 => D <= "00000000";	-- 0x00E3
		when 000228 => D <= "00000000";	-- 0x00E4
		when 000229 => D <= "00000000";	-- 0x00E5
		when 000230 => D <= "00000000";	-- 0x00E6
		when 000231 => D <= "00000000";	-- 0x00E7
		when 000232 => D <= "00000000";	-- 0x00E8
		when 000233 => D <= "00000000";	-- 0x00E9
		when 000234 => D <= "00000000";	-- 0x00EA
		when 000235 => D <= "00000000";	-- 0x00EB
		when 000236 => D <= "00000000";	-- 0x00EC
		when 000237 => D <= "00000000";	-- 0x00ED
		when 000238 => D <= "00000000";	-- 0x00EE
		when 000239 => D <= "00000000";	-- 0x00EF
		when 000240 => D <= "00000000";	-- 0x00F0
		when 000241 => D <= "00000000";	-- 0x00F1
		when 000242 => D <= "00000000";	-- 0x00F2
		when 000243 => D <= "00000000";	-- 0x00F3
		when 000244 => D <= "00000000";	-- 0x00F4
		when 000245 => D <= "00000000";	-- 0x00F5
		when 000246 => D <= "00000000";	-- 0x00F6
		when 000247 => D <= "00000000";	-- 0x00F7
		when 000248 => D <= "00000000";	-- 0x00F8
		when 000249 => D <= "00000000";	-- 0x00F9
		when 000250 => D <= "00000000";	-- 0x00FA
		when 000251 => D <= "00000000";	-- 0x00FB
		when 000252 => D <= "00000000";	-- 0x00FC
		when 000253 => D <= "00000000";	-- 0x00FD
		when 000254 => D <= "00000000";	-- 0x00FE
		when 000255 => D <= "00000000";	-- 0x00FF
		when 000256 => D <= "00100001";	-- 0x0100
		when 000257 => D <= "00000000";	-- 0x0101
		when 000258 => D <= "10000000";	-- 0x0102
		when 000259 => D <= "00111110";	-- 0x0103
		when 000260 => D <= "01011010";	-- 0x0104
		when 000261 => D <= "00110110";	-- 0x0105
		when 000262 => D <= "01011010";	-- 0x0106
		when 000263 => D <= "00101100";	-- 0x0107
		when 000264 => D <= "01110111";	-- 0x0108
		when 000265 => D <= "00011000";	-- 0x0109
		when 000266 => D <= "11111100";	-- 0x010A
		when 000267 => D <= "00000000";	-- 0x010B
		when others => D <= "--------";
		end case;
	end process;
end;
