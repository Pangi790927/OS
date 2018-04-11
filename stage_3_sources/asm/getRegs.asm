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
