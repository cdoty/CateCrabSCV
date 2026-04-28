# Set the name of the output ROM.
name		= Test

# Set the output file extension. Some emulators look for specific extension.
extension	= bin

# Set the console type, based on the directories in scvlib.
console		= SCV

# Set the ROM and RAM start addresses
cseg		= 8000-FFFF
dseg	 	= FFA0
zseg		= FF80

# Set comment settings
mameSystem	= scv
cpuTag		= :maincpu

# Set the tools path.
TOOLS_PATH	= ../Tools

# CATE/ASM8/Lib compile ID. (ie CATEXX.exe)
compileType	= 87

# Set the CATE compiler path. Bin and lib are expected to exist inside the directory.
CATE_PATH	= $(TOOLS_PATH)/Cate
BIN_PATH	= $(CATE_PATH)/bin
LIB_PATH	= $(CATE_PATH)/lib

# Customize the processor type.
Shared_S	= $(wildcard SystemLib/Decompression/Decompress.s)
Shared_S	+= $(wildcard SystemLib/Graphics/SCV/*.s)
Shared_S	+= $(wildcard SystemLib/Graphics/Sprites/*.s)
Shared_S	+= $(wildcard SystemLib/Shared/*.s)
Shared_S	+= $(wildcard SystemLib/Sound/SCV/*.s)

System_S	= $(wildcard SystemLib/$(console)/crt0/Cart.s)
System_S	+= $(wildcard SystemLib/$(console)/*.s)
System_S	+= $(wildcard System/*.s)
Game_C		= $(wildcard Game/*.c)
Graphics_S	= $(wildcard Graphics/*.s)

system 		= $(System_S:.s=.obj)

objects 	= $(Shared_S:.s=.obj)
objects 	+= $(Game_C:.c=.obj)

graphics 	= $(Graphics_S:.s=.obj)

libs 		= $(LIB_PATH)/cate$(compileType).lib

lists 		= $(System_S:.s=.lst)
lists 		+= $(Shared_S:.s=.lst)
lists 		+= $(Game_C:.c=.lst)
lists 		+= $(Graphics_S:.s=.lst)

all: $(name).$(extension)

$(name).$(extension): $(system) $(objects) $(graphics)
#	$(BIN_PATH)/LinkLE $(name).$(extension) $(cseg) $(dseg) $(zseg) $(system) $(objects) $(graphics) $(libs)
#	$(TOOLS_PATH)/CreateComments $(mameSystem) $(cpuTag) $(name).symbols.txt $(name).$(extension) ../../mame/comments

clean:
	rm -f $(system)
	rm -f $(objects)
	rm -f $(graphics)
	rm -f $(lists)
	rm -f $(name).$(extension)
	rm -f $(name).symbols.txt

depend:
#	makedepend -fmakefile $(Game_C)
#	rm makefile.bak

%.asm: %.c
	$(BIN_PATH)/Cate$(compileType) $<

%.obj: %.asm
	$(BIN_PATH)/Asm$(compileType) $<
	
%.obj: %.s
	$(BIN_PATH)/Asm$(compileType) $<
