NAME = boot_sect

# SOURCES_ASM = boot_sect.asm kernel_start.asm 
# SOURCES_CXX = kernel.cpp
# OBJS_ASM = boot_sect.o
# OBJS_CXX = kernel.o

DEPENDENCES = vga_stdio.o isr_handler.o isr.o flushIDT.o 

all: clean hdd
	VBoxManage startvm "MyOS"

###########################################################################################
# boot sector and os-image
hdd: os-image MyOS.vhd
	dd conv=notrunc if=os-image of=MyOS.vhd

boot_sect.o: boot_sect.asm
	nasm boot_sect.asm -f bin -o boot_sect.o

# mostly kernel
kernel.bin: kernel.o kernel_start.o $(DEPENDENCES)
	ld -m elf_i386 -o kernel.bin -Ttext 0x1000 kernel_start.o kernel.o $(DEPENDENCES) --oformat binary

kernel_start.o: kernel_start.asm 
	nasm kernel_start.asm -f elf -o kernel_start.o

os-image: boot_sect.o kernel.bin
	cat boot_sect.o kernel.bin > os-image

kernel.o:
	g++ -m32 -ffreestanding -c kernel.cpp -o kernel.o -I. -O2

###########################################################################################
# VGA print
vga_stdio.o: vga_stdio.cpp
	g++ -m32 -ffreestanding -c vga_stdio.cpp -o vga_stdio.o -I. -O2

# intrerupts
flushIDT.o: intrerupts/flushIDT.asm
	nasm intrerupts/flushIDT.asm -f elf -o flushIDT.o

isr.o: intrerupts/isr.cpp
	g++ -m32 -ffreestanding -c intrerupts/isr.cpp -o isr.o -I. -O2

isr_handler.o: intrerupts/isr.asm
	nasm intrerupts/isr.asm -f elf -o isr_handler.o

###########################################################################################
# clean and other commands
clean: 
	rm -rf *.o */*.o
	rm -rf *.bin */*.bin