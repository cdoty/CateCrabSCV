include "SystemDefines.inc"

dseg

nmiCount:	public nmiCount
	ds	1

cseg

int2Handler: public int2Handler
    offi	mk, $20
	jr		exitIntHandler

	inrw	nmiCount
	nop

exitIntHandler:
	ei

	reti
