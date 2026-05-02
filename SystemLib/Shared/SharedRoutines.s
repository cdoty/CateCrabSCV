include "../../System/SystemDefines.inc"

cseg

; Random routines adapted from https://codeberg.org/Jonn-reenthused/SCeVe
initRandSeed_: public initRandSeed_
	mov		a, frameCount
	adi		a, $80
	mov		randSeed, a

	ret

rand_:	public rand_
	mov		a, randSeed
	eqi		a, 0
	skz
	jmp		randSeeded

	mvi		a, $A5

randSeeded:	
	mov		b, a
	add		a, a
	add		a, a
	add		a, b
	adi		a, 1
	mov		randSeed, a

	ret

; A - limit
randLimit_:	public randLimit_
	eqi		a, 0
	skc					; Return 0 if limit is 0
	jmp		getRand

	ret

getRand:
	adi		a, 1
	mov		c, a

	eqi		a, 0
	skc		
	jmp		getRandRange

	call	rand_		; Get full range
	
	ret

getRandRange:
	call	rand_

reduceToLimitLoop:
	sub		a, c
	skc
	jmp		reduceToLimitLoop

	add		a, c

	ret

setStartNumericChar_:	public setStartNumericChar_
	ret

convertValueToAscii_:	public convertValueToAscii_
	ret

startupDelay:	public startupDelay
	lxi		b, $5B90
	
delayLoop:
	dcr		b
	jr		delayLoop
	
	ret
	
clearRam:	public clearRam
	xra		a, a
	
	lxi		h, RAMStart
	
	lxi		d, RAMStart + 1
	lxi		b, RAMSize - 2		; Adjust the size for the loop and the destination
	
clearRamLoop:
	block

	dcr		b
	jr		clearRamLoop

	ret

setupLibrary:	public setupLibrary
	xra		a, a
	mov		frameCount, a

	mvi		a, $A5
	mov		randSeed, a

	ret

dseg

frameCount:	public	frameCount
	ds	1

randSeed:
	ds	1
