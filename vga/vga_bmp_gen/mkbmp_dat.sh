#!/bin/bash

# examples/ideas of dumping binary data from file for import into VHDL:
#  cat rgb.tmp.bmp  | xxd -b -c 4
#  cat $RGB_FILE | hexdump -v -e '/1 "%02X\n"'
#  printf '%x\n' $(echo "apple" | head -c 5 | od -An -vtu1)
#  dd if=rgb.bmp bs=1 skip=70 | xxd -b -c 4  | cut -c11-45 | sed 's/\ //g' 


## TODO
#RGB_BIN="./rgb.bmp"
#RGB_OUT="./vga_sync.srcs/sources_1/new/rgb.bmp.dat"
#
#if [[ -z  "$1" ]]
#then
#   echo "Defaulting output to $RGB_OUT"
#elif [[ ! -f  "$1" ]]
#then
#  echo "$1 notta file, bye!"
#else
#  RGB_BIN="$1"
#fi
#
#echo  "$RGB_BIN -> $RGB_OUT"
#
#RGB_CONV=rgb.tmp.bmp
#convert $RGB_BIN -flip $RGB_CONV
#
#RGB_CONV=$RGB_BIN  # tmp ... IM is changing bitmap layout PC bitmap, Windows 98/2000 and newer format
#
#od -v  -t x1 $RGB_CONV | cut -c 9- | tr '\ ' '\n' > $RGB_OUT
#
#ls -l $RGB_OUT


# The following conversion command is based on using e.g. GIMP to export .bmp file as 32-bit RGBx data 
# where the data begins after the .bmp header which is 70-bytes long.

dd if=rgb.bmp bs=1 skip=70 | xxd -b -c 4  | cut -c11-45 | sed 's/\ //g' > vga_bitmap.srcs/sources_1/imports/rams/rams_20c.data


