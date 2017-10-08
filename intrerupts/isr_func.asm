%include "gdt_simple_descriptors.asm"

[bits 32]
; first is the intr number, second the called func, third error or not
%macro INTR 3
	[global isr%1]
	[extern %2]
	isr%1:
		cli 			; disable intrerupts
		
		%if %3 == 0
			push byte 0	; if not error INTR then push dumy
		%endif

		push %1	; the isr code
		pusha 
			
			mov ax, ds		; save data sector
			push eax;

				mov ax, DATA_SEG
				mov ds, ax
				mov es, ax
				mov fs, ax
				mov gs, ax

				
				call %2

			pop eax        	; reload the original data segment descriptor
			mov ds, ax
			mov es, ax
			mov fs, ax
			mov gs, ax
		popa
		add esp, 8			; Cleans up the pushed error code and pushed ISR number 
							; ??? pop from stack twice ?
		sti 				; enable intrerupts
		iret 				; return from intrerupt?
							; pops 5 things at once: CS, EIP, EFLAGS, SS, and ESP
%endmacro

INTR 			 0, isr_handler, 0
INTR 			 1, isr_handler, 0
INTR 			 2, isr_handler, 0
INTR 			 3, isr_handler, 0
INTR 			 4, isr_handler, 0
INTR 			 5, isr_handler, 0
INTR 			 6, isr_handler, 0
INTR 			 7, isr_handler, 0
INTR 			 8, isr_handler, 1
INTR			 9, isr_handler, 0
INTR 			10, isr_handler, 1
INTR 			11, isr_handler, 1
INTR 			12, isr_handler, 1
INTR 			13, int13, 		 1
INTR 			14, isr_handler, 1
INTR			15, isr_handler, 0
INTR			16, isr_handler, 0
INTR			17, isr_handler, 1
INTR			18, isr_handler, 0
INTR			19, isr_handler, 0
INTR 			20, isr_handler, 0
INTR 			21, isr_handler, 0
INTR 			22, isr_handler, 0
INTR 			23, isr_handler, 0
INTR 			24, isr_handler, 0
INTR 			25, isr_handler, 0
INTR 			26, isr_handler, 0
INTR 			27, isr_handler, 0
INTR 			28, isr_handler, 0
INTR			29, isr_handler, 0
INTR 			30, isr_handler, 1
INTR			31, isr_handler, 0
