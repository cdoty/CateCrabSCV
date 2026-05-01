include "../../System/InputDefines.inc"
include "../../System/SystemDefines.inc"

dseg

joystick1Value:	public joystick1Value
    ds	1

joystick1LastValue:
    ds	1

joystick2Value:
    ds	1

joystick2LastValue:
    ds	1

joyRead:	public joyRead
    ds	2

cseg

clearJoysticks_:	public clearJoysticks_
	; Clear joystick values
	xra		a, a
	mov		joystick1Value, a
	mov		joystick1LastValue, a
	mov		joystick2Value, a
	mov		joystick2LastValue, a

	ret

updateJoysticks_:	public updateJoysticks_
	mov		a, Joystick1Value
	mov		Joystick1LastValue, a
	mov		a, Joystick2Value
	mov		Joystick2LastValue, a

	call	readJoysticks
	
	ret

readJoystick1_:	public readJoystick1_
	mov		a, joystick1Value

	ret

readJoystick2_:	public readJoystick2_
	mov		a, joystick2Value

	ret

;PA: FEh (~1)
;PB:
;11111110	P1 Left
;11111101	P1 Up
;11111011	P1 Fire 1
;11110111	P2 Left
;11101111	P2 Up
;11011111	P2 Fire 1

;PA: FDh (~2)
;PB:
;11111110	P1 Down
;11111101	P1 Right
;11111011	P1 Fire 2
;11110111	P2 Down
;11101111	P2 Right
;11011111	P2 Fire 2
readJoysticks:	public readJoysticks
	mvi		a, $FE
	mov		pa, a
	mov		a, pb
	
	staw	joyRead
	
	mvi		a, $FD
	mov		pa, a
	mov		a, pb
	
	staw	joyRead + 1

	xra		a, a
	
	bit		0, joyRead
	ori		a, JoypadLeft
	
	bit		1, joyRead
	ori		a, JoypadUp
	
	bit		2, joyRead
	ori		a, Button1
	
	bit		0, joyRead + 1
	ori		a, JoypadDown
	
	bit		1, joyRead + 1
	ori		a, JoypadRight
	
	bit		2, joyRead + 1
	ori		a, Button2
	
	staw	joystick1Value

	xra		a, a
	
	bit		3, joyRead
	ori		a, JoypadLeft
	
	bit		4, joyRead
	ori		a, JoypadUp
	
	bit		5, joyRead
	ori		a, Button1
	
	bit		3, joyRead + 1
	ori		a, JoypadDown
	
	bit		4, joyRead + 1
	ori		a, JoypadRight
	
	bit		5, joyRead + 1
	ori		a, Button2
	
	staw	joystick2Value
	
	ret
