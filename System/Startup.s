include "SystemDefines.inc"

ext	clearRam
ext	setupVDP
ext	setupInterrupt

ext main_

cseg

startup: public startup
;	call	clearRam		; Clear ram
	call	ClearTextArea	; Calls routine located at address 8Ch (0A1Bh)
	call	ClearSprites	; Calls routine located at address 8Eh (0A28h)
	call	ClearTiles		; Calls routine located at address 90h (0A4Ah)

	call	setupVDP		; Setup VDP	
	call	setupInterrupt	; Setup interrupt

	jmp		main_
