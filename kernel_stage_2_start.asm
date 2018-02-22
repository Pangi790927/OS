[bits 32]
[extern kernel_2]

call kernel_2
jmp $			; again, not going back
