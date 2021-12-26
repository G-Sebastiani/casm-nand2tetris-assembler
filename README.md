# Cross assembler for the Nand2tetris Hack Computer written in awk

## casm.awk
This is the cross assembler written in awk.

### Usage:
```
casm.awk file_in.asm > file_out.hack
```
#### Example:
```
./casm.awk ./data/Add.asm > ./data/Add.hack
```
## compare.awk
Compares two files and outputs lines that differ.

### Usage:
```
compare.awk correct_content.cmp content_to_verify.hack
```
#### Example:
```
./compare.awk ./data/Add.cmp ./data/Add.hack
```
## Makefile
A Makefile to use casm.awk. Supports the following options:
* test (Build and run unit test using compare.awk)
* all (Build all - Add.hack Max.hack Rect.hack Pong.hack)
* clean (Remove intermediate files)
* submit (Generates a Zip file to submit)
