CXX = g++-9
LD = ld
ASM = nasm
CXX_FLAGS_1 = -ffreestanding -fno-rtti -fno-exceptions \
		-std=c++17 -Os -Wall -Wextra -Werror

CXX_FLAGS_2 = -ffreestanding -fno-rtti -fno-exceptions \
		-std=c++17 -O3 -Wall -Wextra -Werror

DIRS_1 = stage_1 boot_common ../common
INCLUDES_1 = $(patsubst %, -I%/, $(DIRS_1))
HEADERS_1 = $(shell find stage_1 -type f -name "*.h") \
			$(shell find boot_common -type f -name "*.h")
ASM_SRC_1 = $(shell find stage_1 -type f -name "*.asm") \
			$(shell find boot_common -type f -name "*.asm")
CPP_SRC_1 = $(shell find stage_1 -type f -name "*.cpp") \
			$(shell find boot_common -type f -name "*.cpp")
ASM_OBJS_1 = $(patsubst %.asm, %_1.o, $(ASM_SRC_1))
CPP_OBJS_1 = $(patsubst %.cpp, %_1.o, $(CPP_SRC_1))
DEPS_1 = $(patsubst %.cpp, %_1.d, $(CPP_SRC_1))
OBJS_1 = ${ASM_OBJS_1} ${CPP_OBJS_1}

DIRS_2 = stage_2 boot_common ../ext2fs ../common
INCLUDES_2 = $(patsubst %, -I%/, $(DIRS_2))
HEADERS_2 = $(shell find stage_2 -type f -name "*.h") \
			$(shell find boot_common -type f -name "*.h")
ASM_SRC_2 = $(shell find stage_2 -type f -name "*.asm") \
			$(shell find boot_common -type f -name "*.asm")
CPP_SRC_2 = $(shell find stage_2 -type f -name "*.cpp") \
			$(shell find boot_common -type f -name "*.cpp")
ASM_OBJS_2 = $(patsubst %.asm, %_2.o, $(ASM_SRC_2))
CPP_OBJS_2 = $(patsubst %.cpp, %_2.o, $(CPP_SRC_2))
DEPS_2 = $(patsubst %.cpp, %_2.d, $(CPP_SRC_2))
OBJS_2 = ${ASM_OBJS_2} ${CPP_OBJS_2}


all: image.img

mbrboot.bin: mbrboot.asm
	$(ASM) mbrboot.asm -f bin -o mbrboot.bin

${ASM_OBJS_1}: %_1.o: %.asm $(HEADERS_1)
	$(ASM) $< -f elf -F stabs -o $@ $(INCLUDES_1)

${CPP_OBJS_1}: %_1.o: %.cpp makefile
	$(CXX) -m16 -MMD -MP -c $< -o $@ $(CXX_FLAGS_1) $(INCLUDES_1)

-include ${DEPS_1}
-include boot1.d

${ASM_OBJS_2}: %_2.o: %.asm $(HEADERS_2)
	$(ASM) $< -f elf -F stabs -o $@ $(INCLUDES_2)

${CPP_OBJS_2}: %_2.o: %.cpp makefile
	$(CXX) -m32 -MMD -MP -c $< -o $@ $(CXX_FLAGS_2) $(INCLUDES_2)

-include ${DEPS_1}
-include boot1.d
-include ${DEPS_2}
-include boot2.d

boot1.o: boot1.cpp makefile
	$(CXX) -m16 -MMD -MP -c $(CXX_FLAGS_1) boot1.cpp $(INCLUDES_1) -o boot1.o

boot1.bin: ${CPP_OBJS_1} ${ASM_OBJS_1} boot1.o bootcall_1.asm boot_1.ld
	$(ASM) bootcall_1.asm -f elf -F stabs -o bootcall_1
	$(LD) -Tboot_1.ld -m elf_i386 -o boot1.elf \
			bootcall_1 boot1.o $(OBJS_1)
	objcopy -O binary boot1.elf boot1.bin
	rm -f bootcall_1

boot2.o: boot2.cpp makefile
	$(CXX) -m32 -MMD -MP -c $(CXX_FLAGS_2) boot2.cpp $(INCLUDES_2) -o boot2.o

boot2.bin: ${CPP_OBJS_2} ${ASM_OBJS_2} boot2.o bootcall_2.asm boot_2.ld
	$(ASM) bootcall_2.asm -f elf -F stabs -o bootcall_2
	$(LD) -Tboot_2.ld -m elf_i386 -o boot2.elf \
			bootcall_2 boot2.o $(OBJS_2)
	objcopy -O binary boot2.elf boot2.bin
	rm -f bootcall_2

image.img: mbrboot.bin boot1.bin boot2.bin
	dd if=/dev/zero of=boot1.img  bs=1K  count=64
	dd conv=notrunc if=boot1.bin of=boot1.img
	dd if=/dev/zero of=boot2.img  bs=1K  count=256
	dd conv=notrunc if=boot2.bin of=boot2.img
	cat mbrboot.bin boot1.img boot2.img > image.img
	rm -f boot1.img
	rm -f boot2.img

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
		-d int,cpu_reset\
		-no-reboot\
		-D qemu_log.log\
		-vga std

test-bochs: ../tools/diskformat/example2M.img
	bochs

test-vbox:
	VirtualBox --startvm "boot_test9" -E VBOX_GUI_DBG_ENABLED=true --dbg
# 	VBoxManage startvm  
# 	tail -f boot_serial.log &
# 	pkill tail

create_vbox:
	VBoxManage createvm --name "boot_test9" --register
	VBoxManage modifyvm "boot_test9" --uartmode1 file boot_serial.log
	VBoxManage modifyvm "boot_test9" --uart1 0x3F8 4
	VBoxManage storagectl "boot_test9" --name "boot_hdd" --add sata --bootable on
	VBoxManage storageattach "boot_test9" --storagectl "boot_hdd"\
			--port 0 --device 0 --type hdd\
			--medium /home/pangi/OS/tools/diskformat/example200M.vhd

clean:
	rm -f $(DEPS_1)
	rm -f $(OBJS_1)
	rm -f boot1.o
	rm -f boot1.elf
	rm -f boot1.bin

	rm -f $(DEPS_2)
	rm -f $(OBJS_2)
	rm -f boot2.o
	rm -f boot2.elf
	rm -f boot2.bin
	
	rm -f mbrboot.bin
	rm -f image.img
