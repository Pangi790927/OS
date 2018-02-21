# ------------------------------------------------------------------------------
OS_HDD = OS.vhd
OS_IMAGE = os_image

DIRS = $(shell find . -type d -printf ":%p")
INCLUDES = $(patsubst %, -I %, $(DIRS))

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
STAGE_2_OBJS = kernel_stage_2_32_protected.o kernel_stage_2_load_3.o	\
				$(STAGE_2_ASM_OBJS) $(STAGE_2_CPP_OBJS)
STAGE_3_OBJS = kernel_stage_3.o											\
				$(STAGE_3_ASM_OBJS) $(STAGE_3_CPP_OBJS)

CXX = g++-7
ASM = nasm
LD = ld

all: clean run

${STAGE_2_ASM_OBJS}: %.o: %.asm
	$(ASM) $< -f elf -F stabs -o $@

${STAGE_3_ASM_OBJS}: %.o: %.asm
	$(ASM) $< -f elf -F stabs -o $@

${STAGE_2_CPP_OBJS}: %.o: %.cpp
	$(CXX) -m32 --ffreestanding -c $< -o $@ ${INCLUDES} -std=c++1y

${STAGE_3_CPP_OBJS}: %.o: %.asm
	$(CXX) -m32 --ffreestanding -c $< -o $@ ${INCLUDES} -std=c++1y

# builds stage 1 (the one that must have only 512 bytes)
stage1:
	$(ASM) kernel_stage_1.asm -f bin -o kernel_stage_1.o

# builds stage 2 (this one is the transition from bios loading to own driver,
# from unprotected to protected, from asm to c++ it will have around 32k bytes)
stage2:
	$(ASM) kernel_stage_2_32_protected.asm -f bin -o kernel_stage_2_32_protected.o
	$(CXX) -m32 -ffreestanding -c kernel_stage_2_load_3.cpp -o kernel_stage_2_load_3.o -std=c++1y -O2

# in this stage the real kernel starts as we are finaly able to load the hole os
stage3:
	$(CXX) -m32 -ffreestanding -c kernel_stage_3.cpp
			-o kernel_stage_3.o -std=c++1y -O2

stage1.bin: stage1
	cp kernel_stage_1.o stage1.bin

stage2.bin: stage2
	$(LD) -e kernel_2 -m elf_i386 -o stage2.bin -tText 0x1000 $(STAGE_2_OBJS) --oformat binary

stage3.bin: stage3
	$(LD) -e kernel_3 -m elf_i386 -o stage3.bin -tText 0xa000 $(STAGE_3_OBJS) --oformat binary

$(OS_IMAGE): stage1.bin stage2.bin stage3.bin
	cat stage1.bin stage2.bin stage3.bin > ${OS_IMAGE}

# run the operating system on a virtual machine
run: $(OS_HDD)
	virtualbox --startvm $(OS_HDD)

# copy the kernel image on the vhd
$(OS_HDD): $(OS_IMAGE)
	dd conv=notrunc if=$(OS_IMAGE) of=$(OS_HDD)

clean:
	find . -type f -name '*.o' -exec rm {} +
	find . -type f -name '*.bin' -exec rm {} +
	rm -f os_image
