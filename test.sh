#!/bin/bash
#
# Runs casm with 4 input files and compares the output files to reference files
#
echo "Add"
./casm.awk ./data/Add.asm > ./data/Add.hack
/usr/bin/awk -f compare.awk ./data/Add.cmp ./data/Add.hack
echo "Max"
./casm.awk ./data/Max.asm > ./data/Max.hack
/usr/bin/awk -f compare.awk ./data/Max.cmp ./data/Max.hack
echo "Rect"
./casm.awk ./data/Rect.asm > ./data/Rect.hack
/usr/bin/awk -f compare.awk ./data/Rect.cmp ./data/Rect.hack
echo "Pong"
./casm.awk ./data/Pong.asm > ./data/Pong.hack
/usr/bin/awk -f compare.awk ./data/Pong.cmp ./data/Pong.hack
