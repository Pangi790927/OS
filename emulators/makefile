
OS_IMG = ${OS_IMAGE}

all: create_vbox

qemu: ${OS_IMG} tail_serial
	printenv "OS_IMAGE"
	sudo qemu-system-x86_64 ${OS_IMG}\
		-device isa-debug-exit,iobase=0xf4,iosize=0x04\
		-gdb tcp::9000\
		-serial file:boot_serial.log\
		-d int,cpu_reset\
		-no-reboot\
		-D qemu_log.log\
		-vga std

bochs: ${OS_IMG} tail_serial
	printenv "OS_IMAGE"
	bochs

vbox: ${OS_IMG} tail_serial
	printenv "OS_IMAGE"
	dd conv=notrunc if=${OS_IMG} of=example200M.vhd bs=1M count=200
	VirtualBoxVM --startvm "boot_test13" -E VBOX_GUI_DBG_ENABLED=true --dbg

tail_serial:
	touch boot_serial.log
	pkill tail
	tail -f boot_serial.log &

example200M.vhd:
	dd if=/dev/zero of=temp_hdd.img bs=1M count=200
	VBoxManage convertfromraw --format vhd --variant Fixed\
		temp_hdd.img example200M.vhd
	rm -f temp_hdd.img

create_vbox: example200M.vhd
	touch boot_serial.log
	VBoxManage createvm --name "boot_test13" --register
	VBoxManage modifyvm "boot_test13" --uartmode1 file boot_serial.log
	VBoxManage modifyvm "boot_test13" --uart1 0x3F8 4
	VBoxManage storagectl "boot_test13" --name "boot_hdd" --add sata --bootable on
	VBoxManage storageattach "boot_test13" --storagectl "boot_hdd"\
			--port 0 --device 0 --type hdd --medium example200M.vhd
