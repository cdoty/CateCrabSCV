include "../../../System/SystemDefines.inc"

cseg

setupVDP:	public setupVDP
	; Set VDC settings
	lxi		h, VDCTable
	lxi		d, VDCPort
	mvi		c, 4 - 1
	
	block

	ret

VDCTable:
	db	$B1		; Set text range to bottom left, BG sprite 16x16 two color mode, enable sprites, enable low resolution block mode
	db	$26		; Set foreground and background semigraphic colors
	db	$FF		; Set text/semigraphics window size
	db	$11		; Set foreground and background text colors

; HL: _source
; DE: _dest
; BC: _size
transferToVRAM_:	public transferToVRAM_
	block

	dcr		b
	jr		transferToVRAM_

	ret
