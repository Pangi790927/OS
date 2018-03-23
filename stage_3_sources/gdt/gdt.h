// | 31 -- 16                             | 15 --  0                 |
// | base 0:15                            | limit 0:15               |

// | 63 -- 56   | 55 -- 52  | 51 -- 48    | 47 -- 40    | 39 -- 32   | 
// | base 24:31 | flags     | limit 16:19 | access byte | base 16:23 |

// flags: gr | sz | 0 | 0 
// 	gr - granularity -> 0 means 1 byte / 1 means 4KiB
// 	sz - size bit -> 0 means 16 bit protected mode / 1 means 32 bits

// access byte: pr | privl x 2 | ts | ex | dc | rw | ac
// 	pr - present bit -> must be 1 ???
// 	privl - privilege -> ring level 0 - kernel .. 3 app level
// 	ts - must be 0 for tss and ldt
// 	ex - executable -> 1 if code from segment can be executed 
// 	dc - direction / conforming bit 
// 		-> direction of growth in data segments (0 means up)
// 		-> for code segments 1 tels that less privileged can get here or something
// 	rw - readable / writable bit
// 	ac - accesed bit -> the cpu sets it to 1 when the segment is accessed 

// example of Code Descriptor
// dw 0xffff		;	limit bits (0:15)
// dw 0x0			;	base bits (0:15)
// db 0x0			;	base bits (16:23)
// db 10011010b		; 	1 | privl:0 | 1 | ex:1 | dc:0 | rw:1 | ac:0
// db 11001111b		;	gr:1 | sz:1 | 0 | 0 | limit bits (16:23)
// db 0x0			;	base bits (24:31)

#ifndef GDT_H
#define GDT_H

#include "Types.h"
#include "ostream.h"

namespace gdt {
	struct Descriptor;
}

#define K_CODE_INDEX	1
#define K_DATA_INDEX	2
#define U_CODE_INDEX	3
#define U_DATA_INDEX	4
#define K_TSS_INDEX		5

#define KERNEL_CODE_SEL	(K_CODE_INDEX * sizeof(gdt::Descriptor))
#define KERNEL_DATA_SEL	(K_DATA_INDEX * sizeof(gdt::Descriptor))
#define USER_CODE_SEL	(U_CODE_INDEX * sizeof(gdt::Descriptor))
#define USER_DATA_SEL	(U_DATA_INDEX * sizeof(gdt::Descriptor))
#define KERNEL_TSS_SEL	(K_TSS_INDEX * sizeof(gdt::Descriptor))


std::ostream& operator << (std::ostream& stream,
				const gdt::Descriptor& arg);

namespace gdt
{
	struct __attribute__((__packed__)) Descriptor {
		uint16	limitLo;
		uint16	baseLo;
		uint8	baseMi;
		uint8	access;
		uint8	flags_limitHi;
		uint8	baseHi;

		void	init();
		void	zero();
		void	setLimit (uint32 limit);
		void	setBase (uint32 base);
		void	setPrivilege (uint8 value);
		void	setTss (bool value);
		void	setExecutable (bool value);
		void	setConfDir (bool value);
		void	setReadWrite (bool value);
		void	setAccessBit (bool value = false);	// should I really set it?
		void	setAccess (uint8 access);

		uint32	getLimit() const;
		uint32	getBase() const;
		uint8	getPrivilege() const;
		bool	getTss() const;
		bool	getExecutable() const;
		bool	getConfDir() const;
		bool	getReadWrite() const;
		bool	getAccessBit() const;
		uint8	getAccess() const;

		void	setGranularity (bool paging = true);
		void	setMode (bool mode = true);

		bool	getGranularity() const;
		bool	getMode() const;

		friend std::ostream& (::operator <<) (std::ostream& stream,
				const gdt::Descriptor& arg);
	};

	struct __attribute__((__packed__)) DescriptorPtr {
		uint16 size;
		uint32 addr;

		void pointTo (Descriptor *start, uint32 count);
		void loadDescriptorTable();
	};
}

#endif