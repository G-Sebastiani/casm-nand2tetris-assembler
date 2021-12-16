#! /usr/bin/awk -f
# Description:
#			Compares two files and displays mismatching lines 
#
# Usage:	compare.awk [filename].cmp [filename].hack
#				Inputs	[filename].cmp
#						[filename].hack
{
	if (NR == FNR) {
		firstfile[FNR] = $0;
	}
}
{
	if ((NR > FNR) && (firstfile[FNR] != $0)) {
		print FNR, "cmp", firstfile[FNR];
		print FNR, "hak", $0;
	}
}
