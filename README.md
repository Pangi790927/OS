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
	* Stage 2 will load stage 3
	* Stage 3 will ... (to be completed)

The following should be updated from time to time as we make changes

OS Image
--------------------------------------------------------------------------------
### The OS Image will start with the kernel as such:
	* 0 - 511 -> Stage 1, here the MBR should reside along the boot loader
	* 512 - 1023 -> right now there is just a string
	* 1024 - 64k -> stage 2
	* 64k ... -> stage 3
For testing the image is loaded in a OS.vhs file and run by virtualbox, this
file won't be uploaded because it has 2 GB.

RAM
--------------------------------------------------------------------------------
### RAM is partitioned as such:
	* 0x0 - not a part of kernel
	* 0x7c00 - boot loader (its size is 512 bytes andd will be loaded from disk)
	* 0xA000 + the stack growing downoards, this stack is only for BIOS mode
	* 0xA000 - the kernel loader (stage 2), maximum 63k
	* 0x0efffff + the kernel and kernel loader stack, it can grow till 0x100000
	* 0x1000000 - the kernel - maximum 16 MB
	* 0x2000000 - the kernel heap

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