; we know that data segment must be at 0x10
DATA_SEG equ 0x10

[bits 32]
; first is the intr number, second the called func, third error or not
%macro INTR 3
	[global error_isr%1]
	[extern %2]
	error_isr%1:
		pushad
			cld
			call %2
		popad
		iret
%endmacro

INTR 			 0, isr_error_0, 0
INTR 			 1, isr_error_1, 0
INTR 			 2, isr_error_2, 0
INTR 			 3, isr_error_3, 0
INTR 			 4, isr_error_4, 0
INTR 			 5, isr_error_5, 0
INTR 			 6, isr_error_6, 0
INTR 			 7, isr_error_7, 0
INTR 			 8, isr_error_8, 1
INTR			 9, isr_error_9, 0
INTR 			10, isr_error_10, 1
INTR 			11, isr_error_11, 1
INTR 			12, isr_error_12, 1
INTR 			13, isr_error_13, 1
INTR 			14, isr_error_14, 1
INTR			15, isr_error_handler, 0
INTR			16, isr_error_16, 0
INTR			17, isr_error_17, 1
INTR			18, isr_error_18, 0
INTR			19, isr_error_19, 0
INTR 			20, isr_error_20, 0
INTR 			21, isr_error_handler, 0
INTR 			22, isr_error_handler, 0
INTR 			23, isr_error_handler, 0
INTR 			24, isr_error_handler, 0
INTR 			25, isr_error_handler, 0
INTR 			26, isr_error_handler, 0
INTR 			27, isr_error_handler, 0
INTR 			28, isr_error_handler, 0
INTR			29, isr_error_handler, 0
INTR 			30, isr_error_30, 1
INTR			31, isr_error_handler, 0
