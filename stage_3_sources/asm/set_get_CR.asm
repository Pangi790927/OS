[global __setCR4]
__setCR4:
	push ebp
	mov ebp, esp
		mov eax, [ebp + 8]
		mov cr4, eax 
	pop ebp
	ret

[global __getCR4]
__getCR4:
	mov eax, cr4
	ret

[global __setCR3]
__setCR3:
	push ebp
	mov ebp, esp
		mov eax, [ebp + 8]
		mov cr3, eax 
	pop ebp
	ret

[global __getCR3]
__getCR3:
	mov eax, cr3
	ret

[global __setCR0]
__setCR0:
	push ebp
	mov ebp, esp
		mov eax, [ebp + 8]
		mov cr0, eax 
	pop ebp
	ret

[global __getCR0]
__getCR0:
	mov eax, cr0
	ret