# casm-nand2tetris-assembler
Cross assembler for Nand2Tetris Hack Computer written in awk.

File:         	casm.awk
Description:  	Cross assembler for Nand2Tetris Hack Computer written in awk
Usage:			casm.awk [filename] [filename] > [filename]
				Inputs	[filename].asm file, same file twice, first to identify labels
						[filename].asm file, same file twice, second to transform instructions
				Outputs	[filename].hack, file to pipe putput to

File:			run.sh
Description:	Wraps casm.awk above for easier usage

File:			test.sh
Description:	Runs casm.awk above with 4 input files. Compares the created .hack files to .cmp files to verify functionality-

File:			clean.sh
Description:	Removes .hack output files.

File:			compare.awk
Description:	Compares two files and outputs lines that differ.
