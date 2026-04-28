include "../../Game/GameDefines.inc"
include "../../System/SystemDefines.inc"
include "../../System/VRAMDefines.inc"

ext	nmiCount
ext	int2Handler

zseg
color:
	ds	1

cseg

enableIRQ_:	public enableIRQ_
	xra		a, a
	staw	nmiCount
	
	ei

	ret

disableIRQ_:	public disableIRQ_
	di

	ret

; void waitForVBlank();
waitForVBlank_:	public waitForVBlank_
	push	v

waitForVBlankLoop:
	ldaw	nmiCount

	gti		a, VBlankCount - 1
	jr		waitForVBlankLoop

	di

	sbi		a, VBlankCount
	staw	nmiCount
	
	ei

	pop		v
	
	ret

setupInterrupt:	public setupInterrupt
	lxi		h, int2Handler
	shld	INT2Address + 1

	ret
