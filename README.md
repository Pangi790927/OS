OS second try

Stages
--------------------------------------------------------------------------------
### There are three phases till the OS is loaded and ready:
	* Stage 1: 512 bit phase, the boot loader should do this but we integrate it
				in the OS
	* Stage 2: load Stage 3
	* Stage 3: The rest of the kernel, all the magic is here

### Stages atributes
	* Stage 1 must only load Stage 2 and start the protected mode
	* Stage 2 will load stage 3 and init paging
	* Stage 3 will ... (to be completed)

The following should be updated from time to time as we make changes

OS Image
--------------------------------------------------------------------------------
### The OS Image will start with the kernel as such:
	* 0 - 511 -> Stage 1, here the MBR should reside along the boot loader
	* 512 - 2560 -> gpt
	* 2560 - 3584 -> superblock of ext2
	* 3584 - 64k -> stage 2
	* 64k ... -> stage 3
For testing the image is loaded in a OS.vhs file and run by virtualbox, this
file won't be uploaded because it has 2 GB.

RAM
--------------------------------------------------------------------------------
### RAM is partitioned as such:
	* 0x0 - not a part of kernel
	* 0x7c00 - boot loader (its size is 512 bytes andd will be loaded from disk)
	* 0xA000 + the stack growing downoards, this stack is only for real mode
	* 0xA000 - the kernel loader (stage 2), maximum 63k
	* 0x0100000 - the kernel page directory followed by the page tables
	* 0x0e00000 + the kernel and kernel loader stack, it can grow till 0x0a00000
		from 0x0a00000 to 0x0800000 there is the interrupt stack
	* 0x1000000 - the kernel - maximum 16 MB
	* 0x2000000 - kernel structures:
		- physical pages
	* 0x3000000 - the kernel heap
	* 0x4000000 - kernel end, other programs
	# Obdervation the first 8MB are identity mapped and the rest of the kernel
		resides at 0xc0800000, the kernel starts at 0xc1000000
	# 0x0600000 - the stack of stage 2 (1MB)
	# 0x0100000 - kernel paging


### Useful RAM locations:
	* 0x500:0x503 - ram size as returned by mov ax, 0xE801; int 0x15;
		ax is at 0x500 and bx at 0x502 (ax + bx * 64 is size in KB)
	* 0x504:0x505 - vesa modes saved
	* 0x506:0x507 - vesa current mode
	* 0x1000:0x6000 - vesa bios info and modes info

Ignore the following, those are there for me because I am unable to remember
how to properly make a readme

README HELP TITLE
--------------------------------------------------------------------------------
### Unordered List
	* item1
	* item2

### Ordered List
	1. item1
	2. item2

# 1 Text
## 2 Text
### 3 Text

> This is a quote 

### Heading *contains* **formating**

### Inline code `code`
	code block ? 
	if (x == 0)
		return y;
	else 
		while (true)
			yield 2;