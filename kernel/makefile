# CXX = ../cross_compiler/cross/bin/i686-elf-g++
# LD = ../cross_compiler/cross/bin/i686-elf-ld
CXX = g++-9 -ffreestanding
LD = ld -m elf_i386
ASM = nasm
DISK_FMT = ../tools/diskformat/diskformat.elf
BOOTLOADER = ../bootloader/

export OS_IMAGE=${PWD}/boot_example/hdd.img

all: $(BOOTLOADER)/mbrboot.bin $(BOOTLOADER)/boot1.bin $(BOOTLOADER)/boot2.bin \
		kern1.kern kern2.kern

$(BOOTLOADER)/mbrboot.bin: make_boot
$(BOOTLOADER)/boot1.bin: make_boot
$(BOOTLOADER)/boot2.bin: make_boot

make_boot:
	make -C $(BOOTLOADER)

make_boot_clean:
	make -C $(BOOTLOADER) clean

# STAGE 1 ======================================================================

CXX_FLAGS_3 = -fno-rtti -fno-exceptions -nostdlib -lgcc \
		-std=c++17 -Os -Wall -Wextra -Werror

DHDR_3 := stage_3 ../common
DHDR_3 := $(foreach dir, ${DHDR_3}, \
		$(shell find ${dir} -not -path '*/\.*' -type d -print))

DOBJ_3 := stage_3 ../common/dbg ../common/ioports

INCLUDES_3 := $(patsubst %, -I%/, $(DHDR_3))
HEADERS_3 := $(foreach d, ${DHDR_3}, $(shell find ${d} -type f -name "*.h"))
ASM_SRC_3 := $(foreach d, ${DOBJ_3}, $(shell find ${d} -type f -name "*.asm"))
CPP_SRC_3 := $(foreach d, ${DOBJ_3}, $(shell find ${d} -type f -name "*.cpp"))
ASM_OBJS_3 := $(patsubst %.asm, %_3.o, $(ASM_SRC_3))
CPP_OBJS_3 := $(patsubst %.cpp, %_3.o, $(CPP_SRC_3))
DEPS_3 := $(patsubst %.cpp, %_3.d, $(CPP_SRC_3))
OBJS_3 := ${ASM_OBJS_3} ${CPP_OBJS_3}

${ASM_OBJS_3}: %_3.o: %.asm $(HEADERS_3)
	$(ASM) $< -f elf -F stabs -o $@ $(INCLUDES_3)

${CPP_OBJS_3}: %_3.o: %.cpp makefile
	$(CXX) -m32 -MMD -MP -c $< -o $@ $(CXX_FLAGS_3) $(INCLUDES_3)

-include ${DEPS_3}
-include boot3.d

# custom objects: 

kern1.o: kernel1.cpp makefile
	$(CXX) -m32 -MMD -MP -c $(CXX_FLAGS_3) kernel1.cpp $(INCLUDES_3) -o kern1.o

kern1.kern: ${CPP_OBJS_3} ${ASM_OBJS_3} kern1.o kern_1.ld
	$(LD) -Tkern_1.ld -o kern1.kern kern1.o $(OBJS_3)

clean_1:
	rm -f $(DEPS_3)
	rm -f $(OBJS_3)
	rm -f kern1.o
	rm -f kern1.kern

# STAGE 2 ======================================================================

CXX_FLAGS_4 = -fno-rtti -fno-exceptions -nostdlib -lgcc \
		-std=c++17 -Os -Wall -Wextra -Werror

DHDR_4 := stage_4 ../common
DHDR_4 := $(foreach dir, ${DHDR_4}, \
		$(shell find ${dir} -not -path '*/\.*' -type d -print))

DOBJ_4 := stage_4 ../common/dbg ../common/ioports

INCLUDES_4 := $(patsubst %, -I%/, $(DHDR_4))
HEADERS_4 := $(foreach d, ${DHDR_4}, $(shell find ${d} -type f -name "*.h"))
ASM_SRC_4 := $(foreach d, ${DOBJ_4}, $(shell find ${d} -type f -name "*.asm"))
CPP_SRC_4 := $(foreach d, ${DOBJ_4}, $(shell find ${d} -type f -name "*.cpp"))
ASM_OBJS_4 := $(patsubst %.asm, %_4.o, $(ASM_SRC_4))
CPP_OBJS_4 := $(patsubst %.cpp, %_4.o, $(CPP_SRC_4))
DEPS_$ := $(patsubst %.cpp, %_4.d, $(CPP_SRC_4))
OBJS_$ := ${ASM_OBJS_4} ${CPP_OBJS_4}

${ASM_OBJS_4}: %_4.o: %.asm $(HEADERS_4)
	$(ASM) $< -f elf -F stabs -o $@ $(INCLUDES_4)

${CPP_OBJS_4}: %_4.o: %.cpp makefile
	$(CXX) -m32 -MMD -MP -c $< -o $@ $(CXX_FLAGS_4) $(INCLUDES_4)

-include ${DEPS_4}
-include boot4.d

# custom objects: 

kern2.o: kernel2.cpp makefile
	$(CXX) -m32 -MMD -MP -c $(CXX_FLAGS_4) kernel2.cpp $(INCLUDES_4) -o kern2.o

kern2.kern: ${CPP_OBJS_4} ${ASM_OBJS_4} kern2.o kern_2.ld
	$(LD) -Tkern_2.ld -o kern2.kern kern2.o $(OBJS_4)

clean_2:
	rm -f $(DEPS_4)
	rm -f $(OBJS_4)
	rm -f kern2.o
	rm -f kern2.kern
# COMMON  ======================================================================

clean: clean_1 clean_2 make_boot_clean

