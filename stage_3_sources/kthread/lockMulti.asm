
[global multiGetLock]
multiGetLock:
	push ebp
		mov ebp, esp
		mov esi, [esp + 8] 
		
		lock bts dword [esi], 0
		jnc .acquired

		.locked:
		    pause
		    bt dword [esi], 0
		    jc .locked

		    lock bts dword [esi], 0
		    jc .locked

		.acquired:
    pop ebp
    ret

[global multiTryLock]
multiTryLock:
	push ebp
		mov ebp, esp
		mov esi, [esp + 8] 
		
		mov eax, 1
		lock bts dword [esi], 0
		jnc .acquired
		mov eax, 0

		.acquired:
    pop ebp
    ret

[global multiUnlock]
multiUnlock:
	push ebp
		mov ebp, esp
		mov esi, [esp + 8] ; take the pointer of the lock
		
		sfence ; some multiprocess trickery that can lead to disasters if not put
		mov dword [esi], 0
	pop ebp
	ret
