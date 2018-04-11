[global __getStack]
__getStack:
	push ebp
	push eax
	push ebx
	push ecx
	push edx
	mov ebp, esp
		mov eax, [ebp + 24]	; get ptr to buffer
		mov ebx, [ebp + 28]	; get count
		shl ebx, 2			; we get words
		mov ecx, 0

		.while: 
		cmp ebx, ecx
		je .done
			mov edx, [ebp + ecx]
			mov [eax + ecx], edx
			add ecx, 4
			jmp .while
		.done:
	pop edx
	pop ecx
	pop ebx
	pop eax
	pop ebp
	ret