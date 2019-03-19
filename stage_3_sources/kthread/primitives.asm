
[global compare_exchange32]
compare_exchange32:
	push ebp
	mov ebp, esp
		push ebx
		push esi
		push edi
			mov esi, [ebp + 8]	; dest
			mov edi, [ebp + 12] ; expected
			mov ebx, [ebp + 16] ; desired

			mov eax, [edi]
			lock cmpxchg dword[esi], ebx
			mov [edi], eax
			
			mov eax, 0
			setz al
		pop edi
		pop esi
		pop ebx
    pop ebp
    ret