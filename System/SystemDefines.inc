RAMStart			equ	$FF80	; Ram start address
RAMSize				equ	$52		; Ram size, excluding space reserved for stack.
StackStart			equ	$FFD2	; Stack start address. Must be $FFFF to create a bootable cartridge.
BGSpriteVRAM		equ	$2000
SpriteVRAM			equ	$2800
TextVRAM			equ	$3000
BGSpriteTable		equ	$3200
SpriteTable			equ	$3300	; Sprite table for moving sprites
MultiSpriteTable	equ	$3380	; Sprite table for multi-color moving sprites
VDCPort				equ	$3400
ClearTextArea		equ	$A1B
ClearSprites		equ	$A29
ClearTiles			equ	$A4A
VBlankCount			equ	1		; VBlank interrupt count
INT1Address			equ	$FFF7	; INT1 address (Sound)
INT2Address			equ	$FFFA	; INT2 address (VDC)
INTSAddress			equ	$FFFD	; INTS address
ClearTextArea		equ	$A1B	; BIOS routines	
ClearSprites		equ	$A29
ClearTiles			equ	$A4A
SystemSprites		equ	128		; Maximum system sprites
