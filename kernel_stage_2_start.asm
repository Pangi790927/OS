[bits 32]
[extern kernel_2]

mov ebp, 0x800000
mov esp, ebp

call kernel_2
jmp $			; again, not going back
