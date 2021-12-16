# casm-nand2tetris-assembler
Cross assembler for Nand2Tetris Hack Computer written in awk.

File:         casm.awk
Description:  Cross assembler for Nand2Tetris Hack Computer written in awk
Usage:	casm.awk [filename] [filename] > [filename]
				Inputs	[filename].asm file, same file twice, first to identify labels
						    [filename].asm file, same file twice, second to transform instructions
				Outputs	[filename].hack, file to pipe putput to


