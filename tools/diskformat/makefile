CXX_FLAGS = -g -std=c++17 -rdynamic -lz -lstdc++fs
INCLUDES = -I../../common -I../../ext2fs -I.
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

test128K: example128K.img diskformat.elf test_ext2.elf
	./diskformat.elf example128K.img boot_example/dev_layout.json 
	sudo python testfs.py example128K.img
	./test_ext2.elf example128K.img 34
	xxd ../../bootloader/boot1.bin > b1.hex
	xxd boot1.bin > b2.hex
	-diff b1.hex b2.hex
	rm b1.hex b2.hex

test2M: example2M.img diskformat.elf test_ext2.elf
	./diskformat.elf example2M.img boot_example/dev_layout.json 
	sudo python testfs.py example2M.img
	./test_ext2.elf example2M.img 34
	xxd ../../bootloader/boot1.bin > b1.hex
	xxd boot1.bin > b2.hex
	-diff b1.hex b2.hex
	rm b1.hex b2.hex

test20M: example20M.img diskformat.elf test_ext2.elf
	./diskformat.elf example20M.img boot_example/dev_layout.json 
	sudo python testfs.py example20M.img
	./test_ext2.elf example20M.img 34
	xxd ../../bootloader/boot1.bin > b1.hex
	xxd boot1.bin > b2.hex
	-diff b1.hex b2.hex
	rm b1.hex b2.hex

test200M: example200M.img diskformat.elf test_ext2.elf
	./diskformat.elf example200M.img boot_example/dev_layout.json 
	sudo python testfs.py example200M.img
	./test_ext2.elf example200M.img 34
	xxd ../../bootloader/boot1.bin > b1.hex
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

example128K.img:
	dd if=/dev/zero of=example128K.img bs=1k count=128

example2M.img:
	dd if=/dev/zero of=example2M.img bs=1M count=2

example20M.img:
	dd if=/dev/zero of=example20M.img bs=1M count=20

example200M.img:
	dd if=/dev/zero of=example200M.img bs=1M count=200

clean:
	rm -f test_ext2.d
	rm -f test_ext2.elf
	rm -f diskformat.d
	rm -f diskformat.elf
	rm -f example128K.img
	rm -f example2M.img
	rm -f example20M.img
	rm -f example200M.img