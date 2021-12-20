#!/usr/bin/awk -f
#   _____                                                   _     _           
#  / ____|                     /\                          | |   | |          
# | |     _ __ ___  ___ ___   /  \   ___ ___  ___ _ __ ___ | |__ | | ___ _ __ 
# | |    | '__/ _ \/ __/ __| / /\ \ / __/ __|/ _ \ '_ ` _ \| '_ \| |/ _ \ '__|
# | |____| | | (_) \__ \__ \/ ____ \\__ \__ \  __/ | | | | | |_) | |  __/ |   
#  \_____|_|  \___/|___/___/_/    \_\___/___/\___|_| |_| |_|_.__/|_|\___|_|   
#
# Description:
#			Cross assembler for virtual computer built in Nand2Tetris. 
#
# Usage:	casm.awk [filename] [filename] > [filename]
#				Inputs	[filename].asm file with assembler code
#				Outputs	[filename].hack file to pipe "binary" putput to
BEGIN {
	cinstr["0"]   = "0101010" # 7 bit binary for each mnemonic (acccccc)
	cinstr["1"]   = "0111111"
	cinstr["-1"]  = "0111010"
	cinstr["D"]   = "0001100"
	cinstr["A"]   = "0110000"
	cinstr["!D"]  = "0001101"
	cinstr["!A"]  = "0110001"
	cinstr["-D"]  = "0001111"
	cinstr["-A"]  = "0110011"
	cinstr["D+1"] = "0011111"
	cinstr["A+1"] = "0110111"
	cinstr["D-1"] = "0001110"
	cinstr["A-1"] = "0110010"
	cinstr["D+A"] = "0000010"
	cinstr["D-A"] = "0010011"
	cinstr["A-D"] = "0000111"
	cinstr["D&A"] = "0000000"
	cinstr["D|A"] = "0010101"
	cinstr["M"]   = "1110000"
	cinstr["!M"]  = "1110001"
	cinstr["-M"]  = "1110011"
	cinstr["M+1"] = "1110111"
	cinstr["M-1"] = "1110010"
	cinstr["D+M"] = "1000010"
	cinstr["D-M"] = "1010011"
	cinstr["M-D"] = "1000111"
	cinstr["D&M"] = "1000000"
	cinstr["D|M"] = "1010101"
	dest["n"]    = "000" # 3 bit binary for each output destination from ALU (ddd)
	dest["M"]    = "001"
	dest["D"]    = "010"
	dest["MD"]   = "011"
	dest["A"]    = "100"
	dest["AM"]   = "101"
	dest["AD"]   = "110"
	dest["AMD"]  = "111"
	jump["JNN"] = "000" # 3 bit binary for conditional jump instrutions (jjj)
	jump["JGT"] = "001"
	jump["JEQ"] = "010"
	jump["JGE"] = "011"
	jump["JLT"] = "100"
	jump["JNE"] = "101"
	jump["JLE"] = "110"
	jump["JMP"] = "111"
	symbols["R0"] = 0 # Aliases for some memory addresses
	symbols["R1"] = 1
	symbols["R2"] = 2
	symbols["R3"] = 3
	symbols["R4"] = 4
	symbols["R5"] = 5
	symbols["R6"] = 6
	symbols["R7"] = 7
	symbols["R8"] = 8
	symbols["R9"] = 9
	symbols["R10"] = 10
	symbols["R11"] = 11
	symbols["R12"] = 12
	symbols["R13"] = 13
	symbols["R14"] = 14
	symbols["R15"] = 15
	symbols["KBD"]    = 24578
	symbols["SCREEN"] = 16384
	symbols["SP"]   = 0
	symbols["LCL"]  = 1
	symbols["ARG"]  = 2
	symbols["THIS"] = 3
	symbols["THAT"] = 4
	currentInstruction = 0 # Counter for instruction address
	nextFreeMem = 16 # Points to next unused memory address
}
#============================================================
# First iteration:
#============================================================
# Remove comments and spaces
{ sub("//.*$", ""); gsub("[[:space:]]", "") }
# Identifies and stores label addresses
/^( )*\(/      		{ address_label($1) }
# Keeps A- and C-instructions in an array for second iteration in section END
/^( )*@/			{ imem[currentInstruction] = $1; currentInstruction++ }
/^( )*[0ADM]*[=;]/	{ imem[currentInstruction] = $1 ";JNN"; currentInstruction++ }
#------------------------------------------------------------
# Identifies labels and stores addresses
#------------------------------------------------------------
function address_label(instr) {
	temp = substr(instr, 2, length(instr) - 2)
	symbols[temp] = currentInstruction
}
#============================================================
# Second iteration:
#============================================================
END {
	i = 0
	for (i in imem) {
		tmp = imem[i]
		if (substr(tmp, 1, 1) == "@")
			a_instruction(tmp)
		else
			c_instruction(tmp)
	}
}
#------------------------------------------------------------
# Translates a-instructions (numeric or symbolic)
#------------------------------------------------------------
function a_instruction(instr) {
	ret = substr(instr, 2, length(instr) - 1)
	# Numeric value:
	if (ret + 0 == ret)
		ret = bits2str(int(ret))
	else {
		# Variable name:
		if (ret in symbols)
			# Get from array
			ret = bits2str(int(symbols[ret]))
		else {
			# Store in array
			symbols[ret] = nextFreeMem
			ret = bits2str(nextFreeMem)
			nextFreeMem++
		}
	}
	print ret
}
#------------------------------------------------------------
# Combines C-instruction (operation, destination and jump)
#------------------------------------------------------------
function c_instruction(instr) {
	# Destination part is before "=" in string
	if (index(instr, "=") > 1)
		d = substr(instr, 1, index(instr, "=") - 1)
	else
		d = "n";
	# Operation part is after "=" and before ";"
	# Jump part is after ";"
	c = substr(instr, index(instr, "=")+1, length(instr) - index(instr, "="))
	if (index(c, ";")  > 1) {
		# Does contain a jump part:
		c =  substr(c, 1, index(c, ";") - 1)
		j = substr(instr, index(instr, ";") + 1, index(instr, ";") + 3)
	}
	else
		# Does not contain a jump part:
		j = "JNN"
	# Format: 111accccccdddjjj
	print "111" cinstr[c] dest[d] jump[substr(j, 1, 3)]
}
#------------------------------------------------------------
# Support function to output values as binary
#------------------------------------------------------------
function bits2str(bits) {
    if (bits == 0) return "0000000000000000"
    mask = 1
    data = ""
    for (; bits != 0; bits = rshift(bits, 1))
        data = (and(bits, mask) ? "1" : "0") data
    while (length(data) < 16)
        data = "0" data
    return data
}

