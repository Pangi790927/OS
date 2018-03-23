[global callLTR]
callLTR:
	push ebp
	mov ebp, esp
		mov ax, [ebp + 8]	; Get the selector
		ltr ax				; Load the selector.
	pop ebp
	ret