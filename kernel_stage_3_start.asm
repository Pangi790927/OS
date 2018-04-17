section .text
[bits 32]
[extern kernel_3]

mov ebp, 0xc0e00000	;	V_K_STACK_START
mov esp, ebp

pusha
popa

call kernel_3
jmp $			; guess what, never going back
