[bits 32]
; first is the irq number, second the called func

%macro IRQ 2
	[global irq%1]
	[extern %2]
	irq%1:
		pushad
			call %2
		popad
		iret
%endmacro

; IRQ 			 0, isr_irq_0
IRQ 			 1, isr_irq_1
IRQ 			 2, isr_irq_2
IRQ 			 3, isr_irq_3
IRQ 			 4, isr_irq_4
IRQ 			 5, isr_irq_5
IRQ 			 6, isr_irq_6
IRQ 			 7, isr_irq_7
IRQ 			 8, isr_irq_8
IRQ 			 9, isr_irq_9
IRQ 			 10, isr_irq_10
IRQ 			 11, isr_irq_11
IRQ 			 12, isr_irq_12
IRQ 			 13, isr_irq_13
IRQ 			 14, isr_irq_14
IRQ 			 15, isr_irq_15

[global irq0]
[extern isr_irq_0]
irq0:
	pushad
		mov eax, esp
		push eax
		call isr_irq_0
		pop ebx
		mov esp, eax
	popad
	iret