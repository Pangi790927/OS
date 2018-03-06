# ------------------------------------------------------------------------------
VIRTUAL_MACHINE = OS
OS_HDD = OS.vhd
OS_IMAGE = os_image

DIRS1 = $(shell find stage_1_sources/ -not -path '*/\.*' -type d -printf " %p")
DIRS2 = $(shell find stage_2_sources/ -not -path '*/\.*' -type d -printf " %p")
DIRS3 = $(shell find stage_3_sources/ -not -path '*/\.*' -type d -printf " %p")
INCLUDES1 = $(patsubst %, -I%/, $(DIRS1))
INCLUDES2 = $(patsubst %, -I%/, $(DIRS2))
INCLUDES3 = $(patsubst %, -I%/, $(DIRS3))

STAGE_2_ASM_SOURCES = $(shell find stage_2_sources/ -type f -name "*.asm")
STAGE_2_CPP_SOURCES = $(shell find stage_2_sources/ -type f -name "*.cpp")
STAGE_2_ASM_OBJS = $(patsubst %.asm, %.o, $(STAGE_2_ASM_SOURCES))
STAGE_2_CPP_OBJS = $(patsubst %.cpp, %.o, $(STAGE_2_CPP_SOURCES))

# probably most of the files will be here
STAGE_3_ASM_SOURCES = $(shell find stage_3_sources/ -type f -name "*.asm")
STAGE_3_CPP_SOURCES = $(shell find stage_3_sources/ -type f -name "*.cpp")
STAGE_3_ASM_OBJS = $(patsubst %.asm, %.o, $(STAGE_3_ASM_SOURCES))
STAGE_3_CPP_OBJS = $(patsubst %.cpp, %.o, $(STAGE_3_CPP_SOURCES))

# stage 1 has no objs
STAGE_2_OBJS = kernel_stage_2_load_3.o									\
				$(STAGE_2_ASM_OBJS) $(STAGE_2_CPP_OBJS)
STAGE_3_OBJS = kernel_stage_3.o											\
				$(STAGE_3_ASM_OBJS) $(STAGE_3_CPP_OBJS)

CXX = g++-7
ASM = nasm
LD = ld

CXX_FLAGS = -m32 -ffreestanding -fno-rtti -fno-exceptions -std=c++1y -O2 -g

all: $(OS_HDD)

${STAGE_2_ASM_OBJS}: %.o: %.asm
	$(ASM) $< -f elf -F stabs -o $@ $(INCLUDES2)

${STAGE_2_CPP_OBJS}: %.o: %.cpp
	$(CXX) -c $< -o $@ $(CXX_FLAGS) $(INCLUDES2)

${STAGE_3_ASM_OBJS}: %.o: %.asm
	$(ASM) $< -f elf -F stabs -o $@ $(INCLUDES3)

${STAGE_3_CPP_OBJS}: %.o: %.cpp
	$(CXX) -c $< -o $@ $(CXX_FLAGS) $(INCLUDES3)

# builds stage 1 (the one that must have only 512 bytes)
stage1:
	$(ASM) kernel_stage_1.asm -f bin -o kernel_stage_1.o $(INCLUDES1)

# builds stage 2 (this one is the transition from bios loading to own driver,
# from unprotected to protected, from asm to c++ it will have around 32k bytes)
stage2:
	$(ASM) kernel_stage_2_start.asm -f elf -F stabs -o kernel_stage_2_start.o
	$(CXX) -c kernel_stage_2_load_3.cpp -o kernel_stage_2_load_3.o $(CXX_FLAGS) $(INCLUDES2)

# in this stage the real kernel starts as we are finaly able to load the hole os
stage3:
	$(ASM) kernel_stage_3_start.asm -f elf -F stabs -o kernel_stage_3_start.o
	$(CXX) -c kernel_stage_3.cpp -o kernel_stage_3.o $(CXX_FLAGS) $(INCLUDES3)

stage1.bin: stage1
	cp kernel_stage_1.o stage1.bin

# kernel_stage_2_start.o is directly here because it needs to be the first binary linked
stage2.bin: stage2 $(STAGE_2_OBJS)
	$(LD) -e kernel_2 -m elf_i386 -o stage2.bin -Ttext 0x1000 kernel_stage_2_start.o $(STAGE_2_OBJS) --oformat binary

stage3.bin: stage3 $(STAGE_3_OBJS)
	$(LD) -e kernel_3 -m elf_i386 -o stage3.bin -Ttext 0x1000000 kernel_stage_3_start.o $(STAGE_3_OBJS) --oformat binary

# stage 1 and 2 will ocupy only 32k or 
$(OS_IMAGE): stage1.bin stage2.bin stage3.bin
	cat stage1.bin stage2.bin > stage12.bin
	dd if=/dev/zero of=stage12  bs=1K  count=32
	dd conv=notrunc if=stage12.bin of=stage12
	cat stage12 stage3.bin > ${OS_IMAGE}
	rm -f stage12

# run the operating system on a virtual machine
run: $(OS_HDD)
	virtualbox --startvm $(VIRTUAL_MACHINE)

# copy the kernel image on the vhd
$(OS_HDD): $(OS_IMAGE)
	dd conv=notrunc if=$(OS_IMAGE) of=$(OS_HDD)

clean:
	find . -type f -name '*.o' -exec rm {} +
	find . -type f -name '*.bin' -exec rm {} +
	rm -f os_image
