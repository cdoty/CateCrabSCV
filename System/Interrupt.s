include "SystemDefines.inc"

zseg

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
