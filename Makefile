#                                               _         __ _ _      
#                                              | |       / _(_) |     
#   ___  __ _  ___  _ __ ___    _ __ ___   __ _| | _____| |_ _| | ___ 
#  / __|/ _` |/ __|| '_ ` _ \  | '_ ` _ \ / _` | |/ / _ \  _| | |/ _ \
# | |__/ (_| |\__ \| | | | | | | | | | | | (_| |   <  __/ | | | |  __/
#  \___/\__,_|\___/|_| |_| |_| |_| |_| |_|\__,_|_|\_\___|_| |_|_|\___|
#
# Options:
# 	test		- Build and run unit test
# 	all			- Build all
# 	clean		- Remove intermediate files
#   submit		- Creates Zip file to submit
HACK_FILES:=./data/Add.hack ./data/Max.hack ./data/Rect.hack ./data/Pong.hack
#============================================================
# Build and run unit test:
#============================================================
.PHONY:	test
test:	$(HACK_FILES)
	./compare.awk ./data/Add.cmp ./data/Add.hack
	./compare.awk ./data/Max.cmp ./data/Max.hack
	./compare.awk ./data/Rect.cmp ./data/Rect.hack
	./compare.awk ./data/Pong.cmp ./data/Pong.hack
#============================================================
# Build all:
#============================================================
.PHONY:	all
all:	$(HACK_FILES)
	echo "Done"
./data/Add.hack:
	./casm.awk ./data/Add.asm > ./data/Add.hack
./data/Max.hack:
	./casm.awk ./data/Max.asm > ./data/Max.hack
./data/Rect.hack:
	./casm.awk ./data/Rect.asm > ./data/Rect.hack
./data/Pong.hack:
	./casm.awk ./data/Pong.asm > ./data/Pong.hack
#============================================================
# Remove intermediate files:
#============================================================
.PHONY:	clean
clean:	$(HACK_FILES)
	rm $(HACK_FILES)
	rm Project6.zip prog.txt
#============================================================
# Create Zip file to submit:
#============================================================
.PHONY:	submit
submit:	$(HACK_FILES)
	echo "Solved using casm cross assembler written in awk by G-Sebastiani." > prog.txt
	zip -j Project6.zip $(HACK_FILES) prog.txt

