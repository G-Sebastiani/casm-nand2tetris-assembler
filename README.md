# casm - Nand2tetris assembler in awk
Cross assembler for Nand2Tetris Hack Computer written in awk.

casm.awk - Cross assembler for Nand2Tetris Hack Computer written in awk.
See comment in file for usage.

run.sh - Wraps casm.awk above for easier usage

test.sh - Runs casm.awk above with 4 input files. Compares the created .hack files to .cmp files to verify functionality-

clean.sh - Removes .hack output files.

compare.awk - Compares two files and outputs lines that differ. Used by test.sh.
