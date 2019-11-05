; | 31 -- 16                             | 15 --  0                 |
; | base 0:15                            | limit 0:15               |

; | 63 -- 56   | 55 -- 52  | 51 -- 48    | 47 -- 40    | 39 -- 32   | 
; | base 24:31 | flags     | limit 16:19 | access byte | base 16:23 |

; flags: gr | sz | 0 | 0 
; 	gr - granularity -> 0 means 1 byte / 1 means 4KiB
; 	sz - size bit -> 0 means 16 bit protected mode / 1 means 32 bits

; access byte: pr | privl x 2 | ts | ex | dc | rw | ac
; 	pr - present bit -> must be 1 ???
; 	privl - privilege -> ring level 0 - kernel .. 3 app level
; 	ts - must be 0 for tss and ldt
; 	ex - executable -> 1 if code from segment can be executed 
; 	dc - direction / conforming bit -> direction of growth in data segments (0 means up)
; 			-> for code segments 1 tels that less privileged can get here or something
; 	rw - readable / writable bit
; 	ac - accesed bit -> the cpu sets it to 1 when the segment is accessed 

GDT_START:

NULL_GDT:
	dd 0
	dd 0

CODE_GDT:
	dw 0xffff		;	limit bits (0:15)
	dw 0x0			;	base bits (0:15)
	db 0x0			;	base bits (16:23)
	db 10011010b	; 	1 | privl:0 | 1 | ex:1 | dc:0 | rw:1 | ac:0
	db 11001111b	;	gr:1 | sz:1 | 0 | 0 | limit bits (16:19)
	db 0x0			;	base bits (24:31)

DATA_GDT:
	dw 0xffff		;	limit bits (0:15)
	dw 0x0			;	base bits (0:15)
	db 0x0			;	base bits (16:23)
	db 10010010b	; 	1 | privl:0 | 1 | ex:0 | dc:0 | rw:1 | ac:0
	db 11001111b	;	gr:1 | sz:1 | 0 | 0 | limit bits (16:23)
	db 0x0			;	base bits (24:31)

ADDITIONAL_SPACE:
	times 4 dq 0	;	for TSS and a bonus one maybe ?

GDT_END:

GDT_DESCRIPTOR:
	dw GDT_END - GDT_START - 1	;	size of GDT - 1
	dd GDT_START				;	address of GDT

global CODE_SEG
	CODE_SEG equ CODE_GDT - GDT_START

global DATA_SEG
	DATA_SEG equ DATA_GDT - GDT_START