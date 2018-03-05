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

OS Image
--------------------------------------------------------------------------------
### The OS Image will start with the kernel as such:
	* 0 - 512 -> Stage 1
	* 1024 - max 32k -> stage 2
	* 32k ... -> stage 3
For testing the image is loaded in a OS.vhs file and run by virtualbox, this
file won't be uploaded because it has 2 GB.

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