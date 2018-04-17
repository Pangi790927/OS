[global __isCpuidSuported]
__isCpuidSuported:
	pushfd
	pushfd
	xor dword [esp], 0x00200000		; 0x00200000 is the id bit in EFLAGS
	popfd
	pushfd
	pop eax
	xor eax, [esp]
	popfd
	and eax, 0x00200000
	ret

[global __getCpuidVendor]
__getCpuidVendor:
	push ebp
	mov ebp, esp
	push ebx
	push ecx
	push edx
		mov eax, 0x0
		cpuid
		
		mov eax, [ebp + 8]
		mov dword [eax], ebx
		mov dword [eax + 4], edx
		mov dword [eax + 8], ecx
	pop edx
	pop ecx
	pop ebx
	pop ebp
	ret

[global __getCpuidFeatures]
__getCpuidFeatures:
	push ebp
	mov ebp, esp
	push ecx
	push edx
		mov eax, 0x1
		cpuid
		
		mov eax, [ebp + 8]
		mov dword [eax], edx
		mov dword [eax + 4], ecx
	pop edx
	pop ecx
	pop ebp
	ret