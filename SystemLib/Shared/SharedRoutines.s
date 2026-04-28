include "../../System/SystemDefines.inc"

cseg

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
