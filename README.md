OS second try

Stages
--------------------------------------------------------------------------------
There are three phases till the OS is loaded and ready.
	Stage 1: 512 bit phase, the boot loader should do this but we integrate it
				in the OS
	Stage 2: Enter 32 protected mode and load Stage 3
	Stage 3: The rest of the kernel, all the magic is here

Stage 1 must only load Stage 2.
Stage 2 will load the gdt and ... (to be completed)
Stage 3 will ... (to be completed)

OS Image
--------------------------------------------------------------------------------
The OS Image will start with the kernel as such:
	0 - 512 -> Stage 1
	... (to be completed)
	... (to be completed)