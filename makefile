#kernel_start must be first
ASM_NAME = 	kernel_start 									\
			intrerupts/isr_func 							\
				intrerupts/irq_func 						\
				intrerupts/flushIDT 						\
			cpuid/cpuid_supported

CPP_NAME = 		vga_stdio 						\
				kernel 							\
				c_asm_func 						\
			intrerupts/isr 						\
				intrerupts/c_enable_int			\
				intrerupts/irq 					\
			timer/timer 						\
			utils/stdio 						\
				utils/basic						\
			cpuid/cpuid 						\
			keyboard/keyboard

DIRS = intrerupts utils timer cpuid keyboard
INC_DIRS = $(patsubst %, -I%/, $(DIRS))

ASM_SRC = $(patsubst %, %.asm, $(ASM_NAME))
ASM_OBJ = $(patsubst %, %.o, $(ASM_NAME))
CPP_SRC = $(patsubst %, %.cpp, $(CPP_NAME))
CPP_OBJ = $(patsubst %, %.o, $(CPP_NAME))


DEPENDENCES = $(ASM_OBJ) $(CPP_OBJ)

all: clean hdd
	VirtualBox --startvm "MyOS"
	# VBoxManage debugvm "MyOS" show

hdd: os-image MyOS.vhd
	dd conv=notrunc if=os-image of=MyOS.vhd

boot_sect.o: boot_sect.asm
	nasm boot_sect.asm -f bin -o boot_sect.o

kernel.bin: $(DEPENDENCES)
	ld -e main -m elf_i386 -o kernel.bin -Ttext 0x1000 $(DEPENDENCES) --oformat binary

$(ASM_OBJ): %.o: %.asm
	nasm $< -f elf -g -F stabs -o $@

$(CPP_OBJ): %.o: %.cpp
	g++ -g -m32 -ffreestanding -c $< -o $@ -I. $(INC_DIRS) -std=c++1y

os-image: boot_sect.o kernel.bin
	cat boot_sect.o kernel.bin > os-image

clean: 
	rm -rf *.o */*.o
	rm -rf *.bin */*.bin