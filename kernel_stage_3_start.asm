section .text
[bits 32]
[extern kernel_3]

call kernel_3
jmp $			; guess what, never going back
