#kernel_start must be first
ASM_NAME = 	kernel_start 									\
			intrerupts/isr_func 							\
				intrerupts/irq_func 						\
				intrerupts/flushIDT 						\
			cpuid/cpuid_supported

# those bellow will only be used to load the whole kernel 
CPP_NAME_START	= vga_stdio						\
				kernel_loader 					\
				c_asm_func 						\
			intrerupts/isr 						\
				intrerupts/c_enable_int			\
				intrerupts/irq 					\
			timer/timer 						\
			utils/stdio 						\
				utils/basic						\
			EDI/edi

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
			keyboard/keyboard					\
			PCI/pci								\
			EDI/edi


DIRS = intrerupts utils timer cpuid keyboard PCI EDI
INC_DIRS = $(patsubst %, -I%/, $(DIRS))

ASM_SRC = $(patsubst %, %.asm, $(ASM_NAME))
ASM_OBJ = $(patsubst %, %.o, $(ASM_NAME))
CPP_SRC = $(patsubst %, %.cpp, $(CPP_NAME))
CPP_OBJ = $(patsubst %, %.o, $(CPP_NAME))
CPP_START_SRC = $(patsubst %, %.cpp, $(CPP_NAME_START))
CPP_START_OBJ = $(patsubst %, %.o, $(CPP_NAME_START))


DEPENDENCES = $(ASM_OBJ) $(CPP_OBJ)
DEPENDENCES_START = $(ASM_OBJ) $(CPP_START_OBJ)

all: clean hdd
	VirtualBox --startvm "MyOS"
	# VBoxManage debugvm "MyOS" show

hdd: os-image MyOS.vhd
	dd conv=notrunc if=os-image of=MyOS.vhd

boot_sect.o: boot_sect.asm
	nasm boot_sect.asm -f bin -o boot_sect.o

kernel.bin: $(DEPENDENCES)
	ld -e main -m elf_i386 -o kernel.bin -Ttext 0x1000 $(DEPENDENCES) --oformat binary

kernel_loader.bin: $(DEPENDENCES_START)
	ld -e main -m elf_i386 -o kernel_loader.bin -Ttext 0x1000 $(DEPENDENCES_START) --oformat binary

$(ASM_OBJ): %.o: %.asm
	nasm $< -f elf -g -F stabs -o $@

$(CPP_START_OBJ): %.o: %.cpp
	g++-6 -g -m32 -ffreestanding -c $< -o $@ -I. $(INC_DIRS) -std=c++1y

$(CPP_OBJ): %.o: %.cpp
	g++-6 -g -m32 -ffreestanding -c $< -o $@ -I. $(INC_DIRS) -std=c++1y -O2

os-image: boot_sect.o kernel_loader.bin
	cat boot_sect.o kernel_loader.bin > os-image

clean: 
	rm -rf *.o */*.o
	rm -rf *.bin */*.bin