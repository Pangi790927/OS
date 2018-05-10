[global __invlpg]
__invlpg:
	push ebp
	mov ebp, esp
		mov eax, [ebp + 8]
		invlpg [eax] 
	pop ebp
	ret
