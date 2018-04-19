[global __getRegEAX]
__getRegEAX:
	ret

[global __getRegEBX]
__getRegEBX:
	mov eax, ebx
	ret

[global __getRegECX]
__getRegECX:
	mov eax, ecx
	ret

[global __getRegEDX]
__getRegEDX:
	mov eax, edx
	ret

[global __getRegEDI]
__getRegEDI:
	mov eax, edi
	ret

[global __getRegESI]
__getRegESI:
	mov eax, esi
	ret

[global __getRegEBP]
__getRegEBP:
	mov eax, ebp
	ret

[global __getRegESP]
__getRegESP:
	mov eax, esp
	ret

[global __getRegEIP]
__getRegEIP:
	call .get_eip
	.get_eip: mov eax, [esp]
         ret
	ret

[global __getRegEFLAGS]
__getRegEFLAGS:
	pushf
	pop eax
	ret

[global __getRegFS]
__getRegFS:
	mov eax, fs
	ret

[global __getRegGS]
__getRegGS:
	mov eax, gs
	ret

[global __getRegCS]
__getRegCS:
	mov eax, cs
	ret

[global __getRegSS]
__getRegSS:
	mov eax, ss
	ret

[global __getRegDS]
__getRegDS:
	mov eax, ds
	ret

[global __getRegES]
__getRegES:
	mov eax, es
	ret