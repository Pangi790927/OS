[EXTERN isr_handler]
[EXTERN DATA_SEG]

%macro ISR_NO_ERROR 1
	[GLOBAL isr%1]
	isr%1:
		cli 			; disable intrerupts
		push byte 0		; dummy error 
		push byte %1	; the isr code
		jmp common_isr
%endmacro

%macro ISR_ERROR 1
	[GLOBAL isr%1]
	isr%1:
		cli 			; disable intrerupts
						; no more dummy error, isr will push own error 
		push byte %1	; the isr code
		jmp common_isr
%endmacro

common_isr:
	pusha 				; add
		
		mov ax, ds		; save data sector
		push eax;

			mov ax, DATA_SEG
			mov ds, ax
			mov es, ax
			mov fs, ax
			mov gs, ax

			call isr_handler

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

ISR_NO_ERROR	0
ISR_NO_ERROR	1
ISR_NO_ERROR	2
ISR_NO_ERROR	3
ISR_NO_ERROR	4
ISR_NO_ERROR	5
ISR_NO_ERROR	6
ISR_NO_ERROR	7
ISR_ERROR		8
ISR_NO_ERROR	9
ISR_ERROR		10
ISR_ERROR		11
ISR_ERROR		12
ISR_ERROR		13
ISR_ERROR		14
ISR_NO_ERROR	15
ISR_NO_ERROR	16
ISR_NO_ERROR	17
ISR_NO_ERROR	18
ISR_NO_ERROR	19
ISR_NO_ERROR	20
ISR_NO_ERROR	21
ISR_NO_ERROR	22
ISR_NO_ERROR	23
ISR_NO_ERROR	24
ISR_NO_ERROR	25
ISR_NO_ERROR	26
ISR_NO_ERROR	27
ISR_NO_ERROR	28
ISR_NO_ERROR	29
ISR_NO_ERROR	30
ISR_NO_ERROR	31