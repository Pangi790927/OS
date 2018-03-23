[global callLGDT]
callLGDT:
	push ebp
	mov ebp, esp
		mov eax, [ebp + 8]  ; Get the pointer to the GDT, passed as a parameter.
		lgdt [eax]			; Load the GDT pointers.
	pop ebp
	ret
