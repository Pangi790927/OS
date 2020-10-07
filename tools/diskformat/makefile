# life saver:
# gsettings set org.gnome.desktop.media-handling automount-open false

CXX_FLAGS = -g -std=c++17 -rdynamic -lz -lstdc++fs
# INCLUDES = -I../../common -I../../ext2fs -I.

DIRS := ../../common ../../ext2fs .
DIRS := $(foreach dir, $(DIRS), \
		$(shell find $(dir) -type d -print))

INCLUDES := $(patsubst %, -I%/, $(DIRS))

FS_OPTS = ^sparse_super,^large_file,^filetype,^resize_inode,^dir_index,^ext_attr

all: diskformat.elf

-include diskformat.d
-include test_ext2.d

# diskformat.dep: main.cpp makefile
# 	$(CXX) -MM -MF diskformat.dep $(CXX_FLAGS) main.cpp $(INCLUDES)

# test_ext2.dep: test_ext2.cpp makefile
# 	$(CXX) -MM -MF test_ext2.dep $(CXX_FLAGS) test_ext2.cpp $(INCLUDES)

diskformat.elf: main.cpp makefile
	g++-9 $(CXX_FLAGS) -MMD -MP main.cpp $(INCLUDES) -o diskformat.elf

test_ext2.elf: test_ext2.cpp makefile
	g++-9 $(CXX_FLAGS) -MMD -MP test_ext2.cpp $(INCLUDES) -o test_ext2.elf

test128K: boot_example/example128K.img diskformat.elf test_ext2.elf
	./diskformat.elf boot_example/example128K.img boot_example/dev_layout.json 
	sudo python testfs.py boot_example/example128K.img
	./test_ext2.elf boot_example/example128K.img 34
	xxd boot_example/boot1.bin > b1.hex
	xxd boot1.bin > b2.hex
	-diff b1.hex b2.hex
	rm b1.hex b2.hex

test2M: boot_example/example2M.img diskformat.elf test_ext2.elf
	./diskformat.elf boot_example/example2M.img boot_example/dev_layout.json 
	sudo python testfs.py boot_example/example2M.img
	./test_ext2.elf boot_example/example2M.img 34
	xxd boot_example/boot1.bin > b1.hex
	xxd boot1.bin > b2.hex
	-diff b1.hex b2.hex
	rm b1.hex b2.hex

test20M: boot_example/example20M.img diskformat.elf test_ext2.elf
	./diskformat.elf boot_example/example20M.img boot_example/dev_layout.json 
	sudo python testfs.py boot_example/example20M.img
	./test_ext2.elf boot_example/example20M.img 34
	xxd boot_example/boot1.bin > b1.hex
	xxd boot1.bin > b2.hex
	-diff b1.hex b2.hex
	rm b1.hex b2.hex

test200M: boot_example/example200M.img diskformat.elf test_ext2.elf
	./diskformat.elf boot_example/example200M.img boot_example/dev_layout.json 
	sudo python testfs.py boot_example/example200M.img
	./test_ext2.elf boot_example/example200M.img 34
	xxd boot_example/boot1.bin > b1.hex
	xxd boot1.bin > b2.hex
	-diff b1.hex b2.hex
	rm b1.hex b2.hex

test_ext2: test_ext2.elf
	-sudo losetup /dev/loop11 floppy.img
	yes | sudo mkfs -t ext2 -b 1024 -I 128 -O $(FS_OPTS) -r 1 -vvvvv /dev/loop11
	@echo "--------------------------- REFERENCE ------------------------------"
	@sudo mount -t ext2 /dev/loop11 myfloppy
	@sudo touch myfloppy/a myfloppy/b myfloppy/c myfloppy/d myfloppy/e
	@sudo mkdir myfloppy/boot
	@sudo touch myfloppy/boot/boot.boot myfloppy/boot/boot.conf
	@sudo sh -c 'echo "\nana are multe mere" > myfloppy/a_sample_0.txt'
	@sudo sh -c 'echo "\nana are multe mere" > myfloppy/e'
	@sudo dd if=/dev/urandom of=myfloppy/a_sample.txt bs=1K count=32
	cat myfloppy/a_sample_0.txt
	ls -la myfloppy
	ls -la myfloppy/boot
	sudo ls -la myfloppy/lost+found
	@sudo umount myfloppy
	@-sudo losetup -d /dev/loop11
	@echo "--------------------------- TESTER ---------------------------------"
	@./test_ext2.elf floppy.img
	@echo "--------------------------- DONE -----------------------------------"

base_example:
	dd if=/dev/urandom of=boot_example/mbr.bin bs=1b count=512
	dd if=/dev/urandom of=boot_example/boot1.bin bs=1k count=16
	dd if=/dev/urandom of=boot_example/boot2.bin bs=1k count=16
	dd if=/dev/urandom of=boot_example/stage1.bin bs=1k count=16
	dd if=/dev/urandom of=boot_example/stage2.bin bs=1k count=16

boot_example/example128K.img: base_example
	dd if=/dev/zero of=boot_example/example128K.img bs=1k count=128

boot_example/example2M.img: base_example
	dd if=/dev/zero of=boot_example/example2M.img bs=1M count=2

boot_example/example20M.img: base_example
	dd if=/dev/zero of=boot_example/example20M.img bs=1M count=20

boot_example/example200M.img: base_example
	dd if=/dev/zero of=boot_example/example200M.img bs=1M count=200

clean:
	rm -f test_ext2.d
	rm -f test_ext2.elf
	rm -f diskformat.d
	rm -f diskformat.elf
	rm -f boot_example/example128K.img
	rm -f boot_example/example2M.img
	rm -f boot_example/example20M.img
	rm -f boot_example/example200M.img
	rm -f boot_example/mbr.bin
	rm -f boot_example/boot1.bin
	rm -f boot_example/boot2.bin
	rm -f boot_example/stage1.bin
	rm -f boot_example/stage2.bin