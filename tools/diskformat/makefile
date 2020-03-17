CXX_FLAGS = -g -std=c++17 -rdynamic -lz -lstdc++fs
INCLUDES = -I../../common -I../../ext2fs -I.

all: clean diskformat.elf

diskformat.elf:
	g++-9 $(CXX_FLAGS) main.cpp $(INCLUDES) -o diskformat.elf

test128K: example128K.img diskformat.elf
	./diskformat.elf example128K.img boot_example/dev_layout.json 
	sudo python testfs.py example128K.img

test2M: example2M.img diskformat.elf
	./diskformat.elf example2M.img boot_example/dev_layout.json 
	sudo python testfs.py example2M.img

test20M: example20M.img diskformat.elf
	./diskformat.elf example20M.img boot_example/dev_layout.json 
	sudo python testfs.py example20M.img

test200M: example200M.img diskformat.elf
	./diskformat.elf example200M.img boot_example/dev_layout.json 
	sudo python testfs.py example200M.img

example128K.img:
	dd if=/dev/zero of=example128K.img bs=1k count=128

example2M.img:
	dd if=/dev/zero of=example2M.img bs=1M count=2

example20M.img:
	dd if=/dev/zero of=example20M.img bs=1M count=20

example200M.img:
	dd if=/dev/zero of=example200M.img bs=1M count=200

clean:
	rm -f diskformat.elf
	rm -f example128K.img
	rm -f example2M.img
	rm -f example20M.img
	rm -f example200M.img
