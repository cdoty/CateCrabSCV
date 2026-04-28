include "../../../Game/GameDefines.inc"
include "../../../System/SystemDefines.inc"
include "../../../System/VRAMDefines.inc"

ext	transferToVRAM_
ext	clearVRAMWithParameters

zseg

selectedSprite:	public selectedSprite
	ds	2

cseg

clearSprites_:	public clearSprites_
	; Clear hardware sprites
	call	ClearSprites

	ret

selectSprite_:	public selectSprite_
	push	h

	; Multiply sprite number by 4
	lxi		h, SpriteAttributes

	; Multiply by 4
	shal
	shal
	aci		h, 0
	
	; Add it to the sprite table address
	add		l, a			

	shld	selectedSprite

	pop		h

	ret

; A: Sprite X
; E: Sprite Y
setSpritePosition_:	public setSpritePosition_
	push	b
	push	h
	
	mov		b, a

	; Load selected sprite start address.
	lhld	selectedSprite

	mov		a, e
	ani		a, $FE

	; Store Y
	stax	h+

	; Skip to X position
	inx		h

	mov		a, b
	ani		a, $FE

	; Store X
	stax	h

	pop		h
	pop		b

	ret

; A: Sprite X
setSpriteXPosition_:	public setSpriteXPosition_
	push	h

	; Load selected sprite start address.
	lhld	selectedSprite

	; Skip to X position
	inx		h
	inx		h

	ani		a, $FE

	; Store X
	stax	h

	pop		h

	ret

; A: Sprite Y
setSpriteYPosition_:	public setSpriteYPosition_
	push	h

	; Load selected sprite start address.
	lhld	selectedSprite

	ani		a, $FE

	; Store Y
	stax	h

	pop		h

	ret

; A: Sprite tile
setSpriteTile_:	public setSpriteTile_
	push	h

	; Load selected sprite start address.
	lhld	selectedSprite

	; Skip to tile position
	inx		h
	inx		h
	inx		h

	; Store tile
	stax	h

	pop		h

	ret

; A: Sprite color
setSpriteColor_:	public setSpriteColor_
	push	h

	; Load selected sprite start address.
	lhld	selectedSprite

	; Skip to color position
	inx		h

	; Store color
	stax	h

	pop		h

	ret

; A: Sprite tile
; E: Sprite color
setSpriteTileAndColor_:	public setSpriteTileAndColor_
	push	b
	push	h

	mov		b, a

	; Load selected sprite start address.
	lhld	selectedSprite

	; Skip to color position
	inx		h

	mov		a, e

	; Store color
	stax	h+

	; Skip to tile position
	inx		h

	mov		a, b
	
	; Store tile
	stax	h

	pop		h
	pop		b

	ret
