#!/bin/bash
#
# Runs casm with 4 input files and compares the output files to reference files
#
echo "Add"
/usr/bin/awk -f casm.awk Add.asm Add.asm > Add.hack
/usr/bin/awk -f compare.awk Add.cmp Add.hack
echo "Max"
/usr/bin/awk -f casm.awk Max.asm Max.asm > Max.hack
/usr/bin/awk -f compare.awk Max.cmp Max.hack
echo "Rect"
/usr/bin/awk -f casm.awk Rect.asm Rect.asm > Rect.hack
/usr/bin/awk -f compare.awk Rect.cmp Rect.hack
echo "Pong"
/usr/bin/awk -f casm.awk Pong.asm Pong.asm > Pong.hack
/usr/bin/awk -f compare.awk Pong.cmp Pong.hack

