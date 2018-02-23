[global callLIDT]
callLIDT:
	mov eax, [esp + 4]  ; Get the pointer to the IDT, passed as a parameter.
	lidt [eax]        	; Load the IDT pointers.
	ret