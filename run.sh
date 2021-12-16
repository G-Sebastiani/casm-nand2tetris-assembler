#!/bin/bash
# Usage:
# 	Run [Input file] [Output file]
# Description:
#	Sends input file twice to casm.awk and pipes
#	output to desired output file.
# Input file - is a Hack .asm file.
# Output file - is a .hack "binary" in text format.
/usr/bin/awk -f casm.awk $1 $1 > $2

