[bits 32]
[extern kernel_2]

call kernel_2	; this should be at 0x1000
jmp $			; again never going back
