NAME = boot_sect

# SOURCES_ASM = boot_sect.asm kernel_start.asm 
# SOURCES_CXX = kernel.cpp
# OBJS_ASM = boot_sect.o
# OBJS_CXX = kernel.o

all: clean hdd
	VBoxManage startvm "MyOS"

hdd: os-image
	dd conv=notrunc if=os-image of=MyOS.vhd

boot_sect.o: boot_sect.asm
	nasm boot_sect.asm -f bin -o boot_sect.o

kernel.bin: kernel.o kernel_start.o
	ld -m elf_i386 -o kernel.bin -Ttext 0x1000 kernel_start.o kernel.o --oformat binary

kernel_start.o: kernel_start.asm 
	nasm kernel_start.asm -f elf -o kernel_start.o

os-image: boot_sect.o kernel.bin
	cat boot_sect.o kernel.bin > os-image

kernel.o:
	g++ -m32 -ffreestanding -c kernel.cpp -o kernel.o	

clean: 
	rm -rf *.o
	rm -rf *.bin