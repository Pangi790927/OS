# ------------------------------------------------------------------------------
VIRTUAL_MACHINE = OS
OS_HDD = OS.vhd
OS_IMAGE = os_image

DIRS1 = $(shell find stage_1_sources/ -not -path '*/\.*' -type d -print)
DIRS2 = $(shell find stage_2_sources/ -not -path '*/\.*' -type d -print)
DIRS3 = $(shell find stage_3_sources/ -not -path '*/\.*' -type d -print)
INCLUDES1 = $(patsubst %, -I%/, $(DIRS1))
INCLUDES2 = $(patsubst %, -I%/, $(DIRS2))
INCLUDES3 = $(patsubst %, -I%/, $(DIRS3))
HEADERS = $(shell find stage_2_sources/ -type f -name "*.h")

STAGE_2_ASM_SOURCES = $(shell find stage_2_sources/ -type f -name "*.asm")
STAGE_2_CPP_SOURCES = $(shell find stage_2_sources/ -type f -name "*.cpp")
STAGE_2_ASM_OBJS = $(patsubst %.asm, %.o, $(STAGE_2_ASM_SOURCES))
STAGE_2_CPP_OBJS = $(patsubst %.cpp, %.o, $(STAGE_2_CPP_SOURCES))

# probably most of the files will be here
STAGE_3_ASM_SOURCES = $(shell find stage_3_sources/ -not -path '*/\.*' -type f -name "*.asm")
STAGE_3_CPP_SOURCES = $(shell find stage_3_sources/ -not -path '*/\.*' -type f -name "*.cpp")
STAGE_3_ASM_OBJS = $(patsubst %.asm, %.o, $(STAGE_3_ASM_SOURCES))
STAGE_3_CPP_OBJS = $(patsubst %.cpp, %.o, $(STAGE_3_CPP_SOURCES))

CXX = g++-7
ASM = nasm
LD = ld

CXX_FLAGS_2 = -m32 -ffreestanding -fno-rtti -fno-exceptions -std=c++1y -O2
CXX_FLAGS_3 = -m32 -ffreestanding -fno-rtti -nostartfiles				\
				-fno-exceptions -std=c++1y -O2

CRTBEGIN_OBJ:=$(shell $(CXX) $(CXX_FLAGS_3) -print-file-name=crtbegin.o)
CRTEND_OBJ:=$(shell $(CXX) $(CXX_FLAGS_3) -print-file-name=crtend.o)
CRTI_ASM = $(shell find stage_3_sources/ -type f -name "crti.asm")
CRTN_ASM = $(shell find stage_3_sources/ -type f -name "crtn.asm")
CRTI_ASM_OBJ = $(patsubst %.asm, %.o, $(CRTI_ASM))
CRTN_ASM_OBJ = $(patsubst %.asm, %.o, $(CRTN_ASM))

# stage 1 has no objs
STAGE_2_OBJS = kernel_stage_2_load_3.o									\
				$(STAGE_2_ASM_OBJS) $(STAGE_2_CPP_OBJS)
STAGE_3_OBJS =  ${CRTI_ASM_OBJ}	$(CRTBEGIN_OBJ)	kernel_stage_3.o		\
				$(STAGE_3_ASM_OBJS) $(STAGE_3_CPP_OBJS)					\
				 $(CRTEND_OBJ) ${CRTN_ASM_OBJ}
MAKE_ASM := false

re: clean all

asm: CXX_FLAGS_3 := $(CXX_FLAGS_3) -S -masm=intel
asm: MAKE_ASM := true
asm: clean ${STAGE_3_CPP_OBJS}
	echo "called asm ............................"

all: $(OS_HDD)

${STAGE_2_ASM_OBJS}: %.o: %.asm
	$(ASM) $< -f elf -F stabs -o $@ $(INCLUDES2)

${STAGE_2_CPP_OBJS}: %.o: %.cpp
	$(CXX) -c $< -o $@ $(CXX_FLAGS_2) $(INCLUDES2)

${STAGE_3_ASM_OBJS}: %.o: %.asm
	$(ASM) $< -f elf -F stabs -o $@ $(INCLUDES3)

${STAGE_3_CPP_OBJS}: %.o: %.cpp
	$(CXX) -c $< -o $@ $(CXX_FLAGS_3) $(INCLUDES3)
	@if [ $(MAKE_ASM) = "true" ]; then\
        mv $@ $@.asm;\
        echo "build asm ...";\
    fi

${CRTI_ASM_OBJ}: %.o: %.asm
	$(ASM) $< -f elf -F stabs -o $@

${CRTN_ASM_OBJ}: %.o: %.asm
	$(ASM) $< -f elf -F stabs -o $@

# builds stage 1 (the one that must have only 512 bytes)
stage1:
	$(ASM) kernel_stage_1.asm -f bin -o kernel_stage_1.o $(INCLUDES1)

# builds stage 2 (this one is the transition from bios loading to own driver,
# from unprotected to protected, from asm to c++ it will have around 32k bytes)
stage2:
	$(ASM) kernel_stage_2_start.asm -f elf -F stabs -o kernel_stage_2_start.o
	$(CXX) -c kernel_stage_2_load_3.cpp -o kernel_stage_2_load_3.o $(CXX_FLAGS_2) $(INCLUDES2)

# in this stage the real kernel starts as we are finaly able to load the hole os
stage3:
	$(ASM) kernel_stage_3_start.asm -f elf -F stabs -o kernel_stage_3_start.o
	$(CXX) -c kernel_stage_3.cpp -o kernel_stage_3.o $(CXX_FLAGS_3) $(INCLUDES3)

stage1.bin: stage1
	cp kernel_stage_1.o stage1.bin

# kernel_stage_2_start.o is directly here because it needs to be the first binary linked
stage2.bin: stage2 $(STAGE_2_OBJS)
	$(LD) -e kernel_2 -m elf_i386 -o stage2.bin -Ttext 0xA000 kernel_stage_2_start.o $(STAGE_2_OBJS) --oformat binary

stage3.bin: stage3 $(STAGE_3_OBJS)
	$(LD) -T stage_3.ld -m elf_i386 -o stage3.elf kernel_stage_3_start.o $(STAGE_3_OBJS)
	objdump -d stage3.elf -M intel > stage3.o.asm
	objcopy -O binary stage3.elf stage3.bin

# stage 1 and 2 will ocupy only 32k or 
$(OS_IMAGE): stage1.bin stage2.bin stage3.bin
	cat stage1.bin stage2.bin > stage12.bin
	dd if=/dev/zero of=stage12  bs=1K  count=64
	dd conv=notrunc if=stage12.bin of=stage12
	cat stage12 stage3.bin > ${OS_IMAGE}
	rm -f stage12

# run the operating system on a virtual machine
run: $(OS_HDD)
	qemu-system-i386 $(OS_HDD) -device isa-debug-exit,iobase=0xf4,iosize=0x04

rerun: clean $(OS_HDD)
	qemu-system-i386 $(OS_HDD) -device isa-debug-exit,iobase=0xf4,iosize=0x04

# copy the kernel image on the vhd
$(OS_HDD): $(OS_IMAGE)
	dd conv=notrunc if=$(OS_IMAGE) of=$(OS_HDD)

clean:
	find . -type f -name '*.o' -delete -print
	find . -type f -name '*.d' -delete -print
	find . -type f -name '*.o.asm' -delete -print
	find . -type f -name '*.bin' -delete -print
	find . -type f -name '*.elf' -delete -print
	rm -f os_image
