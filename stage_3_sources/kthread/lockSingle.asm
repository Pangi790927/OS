[extern changeContext]
[extern setWaiting]
[extern setWaitingLock]
[global singleGetLock]

; disableInt();
; if (*lockVar == 0) {
; 	*lockVar = 1;
; }
; else {
;	setWaitingLock(&lockVar);
; 	setWaiting();		// will move the current running process in waiting 
; 	changeContext();	// will get the next process and save this one
; }
; enableInt();

singleGetLock:
	push ebp
		mov ebp, esp
		mov esi, [esp + 8] 
		
		cli
			mov eax, [esi]
			
			test eax, eax
			je .acquired
			
			.acquired:
			mov dword [esi], 1
		sti

	    pop ebp
    ret

[global singleTryLock]
singleTryLock:
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

[global singleUnlock]
singleUnlock:
	push ebp
		mov ebp, esp
		mov esi, [esp + 8] ; take the pointer of the lock
		
		sfence ; some multiprocess trickery that can lead to disasters if not put
		mov dword [esi], 0
	pop ebp
	ret
