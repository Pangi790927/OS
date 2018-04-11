[global switchToRing3]
switchToRing3:
	push ebp
	mov ebp, esp
		cli 

		mov eax, [ebp + 8]	; user data segment
		mov ebx, [ebp + 12]	; user code segment
		mov ecx, [ebp + 16]	; user esp
		mov edx, [ebp + 20]	; user eip

		mov ds, ax
		mov es, ax
		mov fs, ax
		mov gs, ax ; we don't need to worry about SS. it's handled by iret

		push dword eax
		push dword ecx
		pushf
		or dword [esp], 0x200 	; Set IF in EFLAGS so that 
								; interrupts will be reenabled in user mode
		push dword ebx
		push dword edx

		iret	; maybe we could save the eip and stack of the kernel?
				; no idea how we will get them back
	pop ebp
	ret