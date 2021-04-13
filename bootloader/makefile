# CXX = ../cross_compiler/cross/bin/i686-elf-g++
# LD = ../cross_compiler/cross/bin/i686-elf-ld
CXX = g++-9 -ffreestanding
LD = ld -m elf_i386
ASM = nasm
DISK_FMT = ../tools/diskformat/diskformat.elf

export OS_IMAGE=${PWD}/boot_example/hdd.img

all: mbrboot.bin boot1.bin boot2.bin

# STAGE 1 ======================================================================

CXX_FLAGS_1 = -fno-rtti -fno-exceptions -nostdlib -lgcc \
		-std=c++17 -Os -Wall -Wextra -Werror

DHDR_1 := stage_1 ../common
DHDR_1 := $(foreach dir, ${DHDR_1}, \
		$(shell find ${dir} -not -path '*/\.*' -type d -print))

DOBJ_1 := stage_1 ../common/ioports ../common/dbg

INCLUDES_1 := $(patsubst %, -I%/, $(DHDR_1))
HEADERS_1 := $(foreach d, ${DHDR_1}, $(shell find ${d} -type f -name "*.h"))
ASM_SRC_1 := $(foreach d, ${DOBJ_1}, $(shell find ${d} -type f -name "*.asm"))
CPP_SRC_1 := $(foreach d, ${DOBJ_1}, $(shell find ${d} -type f -name "*.cpp"))
ASM_OBJS_1 := $(patsubst %.asm, %_1.o, $(ASM_SRC_1))
CPP_OBJS_1 := $(patsubst %.cpp, %_1.o, $(CPP_SRC_1))
DEPS_1 := $(patsubst %.cpp, %_1.d, $(CPP_SRC_1))
OBJS_1 := ${ASM_OBJS_1} ${CPP_OBJS_1}

${ASM_OBJS_1}: %_1.o: %.asm $(HEADERS_1)
	$(ASM) $< -f elf -F stabs -o $@ $(INCLUDES_1)

${CPP_OBJS_1}: %_1.o: %.cpp makefile
	$(CXX) -m16 -MMD -MP -c $< -o $@ $(CXX_FLAGS_1) $(INCLUDES_1)

-include ${DEPS_1}
-include boot1.d

# custom objects: 
mbrboot.bin: mbrboot.asm
	$(ASM) mbrboot.asm -f bin -o mbrboot.bin

boot1.o: boot1.cpp makefile
	$(CXX) -m16 -MMD -MP -c $(CXX_FLAGS_1) boot1.cpp $(INCLUDES_1) -o boot1.o

boot1.bin: ${CPP_OBJS_1} ${ASM_OBJS_1} boot1.o bootcall_1.asm boot_1.ld
	$(ASM) bootcall_1.asm -f elf -F stabs -o bootcall_1
	$(LD) -Tboot_1.ld -o boot1.elf \
			bootcall_1 boot1.o $(OBJS_1)
	objcopy -O binary boot1.elf boot1.bin
	rm -f bootcall_1

clean_1:
	rm -f $(DEPS_1)
	rm -f $(OBJS_1)
	rm -f boot1.o
	rm -f boot1.elf
	rm -f boot1.bin	
	rm -f mbrboot.bin

# STAGE 2 ======================================================================

CXX_FLAGS_2 = -fno-rtti -fno-exceptions -nostdlib -lgcc \
		-std=c++17 -Os -Wall -Wextra -Werror -libsupc++

DHDR_2 := stage_2 ../ext2fs ../common
DHDR_2 := $(foreach dir, ${DHDR_2}, \
		$(shell find ${dir} -not -path '*/\.*' -type d -print))

DOBJ_2 := stage_2 ../ext2fs ../common

INCLUDES_2 := $(patsubst %, -I%/, $(DHDR_2))
HEADERS_2 := $(foreach d, ${DHDR_2}, $(shell find ${d} -type f -name "*.h"))
ASM_SRC_2 := $(foreach d, ${DOBJ_2}, $(shell find ${d} -type f -name "*.asm"))
CPP_SRC_2 := $(foreach d, ${DOBJ_2}, $(shell find ${d} -type f -name "*.cpp"))
ASM_OBJS_2 := $(patsubst %.asm, %_2.o, $(ASM_SRC_2))
CPP_OBJS_2 := $(patsubst %.cpp, %_2.o, $(CPP_SRC_2))
DEPS_2 := $(patsubst %.cpp, %_2.d, $(CPP_SRC_2))
OBJS_2 := ${ASM_OBJS_2} ${CPP_OBJS_2}

${ASM_OBJS_2}: %_2.o: %.asm $(HEADERS_2)
	$(ASM) $< -f elf -F stabs -o $@ $(INCLUDES_2)

${CPP_OBJS_2}: %_2.o: %.cpp makefile
	$(CXX) -m32 -MMD -MP -c $< -o $@ $(CXX_FLAGS_2) $(INCLUDES_2)

-include ${DEPS_2}
-include boot2.d

# custom objects: 
boot2.o: boot2.cpp makefile
	$(CXX) -m32 -MMD -MP -c $(CXX_FLAGS_2) boot2.cpp $(INCLUDES_2) -o boot2.o

boot2.bin: ${CPP_OBJS_2} ${ASM_OBJS_2} boot2.o bootcall_2.asm boot_2.ld
	$(ASM) bootcall_2.asm -f elf -F stabs -o bootcall_2
	$(LD) -Tboot_2.ld -m elf_i386 -o boot2.elf \
			bootcall_2 boot2.o $(OBJS_2)
	objcopy -O binary boot2.elf boot2.bin
	rm -f bootcall_2

clean_2:
	rm -f $(DEPS_2)
	rm -f $(OBJS_2)
	rm -f boot2.o
	rm -f boot2.elf
	rm -f boot2.bin

# COMMON =======================================================================

test: mbrboot.bin boot1.bin boot2.bin
	dd if=/dev/zero of=boot_example/hdd.img bs=1M count=2
	$(DISK_FMT) boot_example/hdd.img \
			boot_example/boot_layout.json 

	make -C ../emulators  ${OS_EMU_SEL}

	rm -f boot_example/hdd.img

test-qemu:	OS_EMU_SEL=qemu
test-qemu:  test

test-vbox:  OS_EMU_SEL=vbox
test-vbox:  test

test-bochs: OS_EMU_SEL=bochs
test-bochs: test

clean: clean_1 clean_2
