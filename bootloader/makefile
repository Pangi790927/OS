CXX = g++-9
LD = ld
ASM = nasm
CXX_FLAGS = -m16 -ffreestanding -fno-rtti -fno-exceptions \
		-std=c++17 -Os -Wall -Wextra -Werror

DIRS = include ../ext2fs ../common
INCLUDES = $(patsubst %, -I%/, $(DIRS))
HEADERS = $(shell find include/ -type f -name "*.h")
ASM_SRC = $(shell find src/ -type f -name "*.asm")
CPP_SRC = $(shell find src/ -type f -name "*.cpp")
ASM_OBJS = $(patsubst %.asm, %.o, $(ASM_SRC))
CPP_OBJS = $(patsubst %.cpp, %.o, $(CPP_SRC))
DEPS = $(patsubst %.cpp, %.d, $(CPP_SRC))
OBJS = ${ASM_OBJS} ${CPP_OBJS}

all: image.img

mbrboot.bin: mbrboot.asm
	$(ASM) mbrboot.asm -f bin -o mbrboot.bin

${ASM_OBJS}: %.o: %.asm $(HEADERS)
	$(ASM) $< -f elf -F stabs -o $@ $(INCLUDES)

${CPP_OBJS}: %.o: %.cpp %.dep makefile
	$(CXX) -MMD -MP -c $< -o $@ $(CXX_FLAGS) $(INCLUDES)

-include ${DEPS}
-include bootloader.d

bootloader.o: bootloader.cpp makefile
	$(CXX) -MMD -MP -c $(CXX_FLAGS) bootloader.cpp $(INCLUDES) -o bootloader.o

bootloader.bin: ${CPP_OBJS} ${ASM_OBJS} bootloader.o
	$(ASM) bootcall.asm -f elf -F stabs -o bootcall
	objdump -d -Mi8086 -Mintel bootcall
	$(LD) -Tbootloader.ld -m elf_i386 -o bootloader.elf \
			bootcall bootloader.o $(OBJS)
	objcopy -O binary bootloader.elf bootloader.bin
	rm -f bootcall

image.img: mbrboot.bin bootloader.bin
	dd if=/dev/zero of=bootloader.img  bs=1K  count=64
	dd conv=notrunc if=bootloader.bin of=bootloader.img
	cat mbrboot.bin bootloader.img > image.img
	rm -f bootloader.img

test: image.img
	sudo qemu-system-x86_64 image.img\
		-device isa-debug-exit,iobase=0xf4,iosize=0x04\
		-gdb tcp::9000\
		-serial file:boot_serial.log\
		-vga std
	cat boot_serial.log 

test-example: ../tools/diskformat/example2M.img
	sudo qemu-system-x86_64 ../tools/diskformat/example2M.img\
		-device isa-debug-exit,iobase=0xf4,iosize=0x04\
		-gdb tcp::9000\
		-serial file:boot_serial.log\
		-vga std
	cat boot_serial.log 

clean:
	rm -f $(DEPS)
	rm -f $(OBJS)
	rm -f bootloader.o
	rm -f bootloader.elf
	rm -f bootloader.bin
	rm -f mbrboot.bin
	rm -f image.img
