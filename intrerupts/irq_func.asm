%include "gdt_simple_descriptors.asm"

[bits 32]
; first is the irq number, second is the int asociated, third is call function
%macro IRQ 3
	[global irq%1]
	irq%1:
		cli
		push 0	;
		push %2	; interrupt number

		pusha

			mov ax, ds	
			push eax	; save ds

			mov ax, DATA_SEG
			mov ds, ax
			mov es, ax
			mov fs, ax
			mov gs, ax

			[extern %3]
			call %3 ; call the specific function

			pop ebx	; reload ds
			mov ds, bx
			mov es, bx
			mov fs, bx
			mov gs, bx

		popa
		add esp, 8	

		sti
		iret
%endmacro

IRQ 0,	32,	irq_handler
IRQ 1,	33,	irq_handler
IRQ 2,	34,	irq_handler
IRQ 3,	35,	irq_handler
IRQ 4,	36,	irq_handler
IRQ 5,	37,	irq_handler
IRQ 6,	38,	irq_handler
IRQ 7,	39,	irq_handler
IRQ 8,	40,	irq_handler
IRQ 9,	41,	irq_handler
IRQ 10,	42,	irq_handler
IRQ 11,	43,	irq_handler
IRQ 12,	44,	irq_handler
IRQ 13,	45,	irq_handler
IRQ 14,	46,	irq_handler
IRQ 15,	47,	irq_handler
