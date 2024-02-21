;  z80asm z80.asm
;  z80dasm -t a.bin
;  hex2rom -b a.bin prog_rom 6l8s > t80_sim.srcs/sources_1/new/prog_rom.vhd 

org 0
l_0:
  ld hl, l_ram_start  ;0100  21 00 80
l_loop:
  inc a               ;0103  3c
  ld (hl), a          ;0104  77
  inc l               ;0105  2c
  jr  l_loop          ;0106  18 fb  (jr $-3)

org 0x8000
l_ram_start:
  db  0x00

