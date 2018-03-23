[global callLIDT]
callLIDT:
	push ebp
	mov ebp, esp
		mov eax, [ebp + 8]  ; Get the pointer to the IDT, passed as a parameter.
		lidt [eax]        	; Load the IDT pointers.
	pop ebp
	ret