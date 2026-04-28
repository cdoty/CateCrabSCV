include "../../../System/SystemDefines.inc"

ext	startup

cseg

_SCVHEADER:	public _SCVHEADER
	db	'H'		; Cartridge header

	di
	
	lxi		sp, StackStart

	jmp		startup
