import sys
import os
import subprocess
import traceback

def run_stats():
	print(subprocess.check_output(["df", "-h"]))
	print(subprocess.check_output(["sudo", "losetup", "-a"]))

def attach_to_dev(fs_image, dev, off):
	ret = subprocess.check_call(["sudo", "losetup", "-o", off, dev, fs_image])
	if ret != 0:
		raise Exception("Can't attach loopdev")

def dettach_dev(dev):
	ret = subprocess.check_call(["sudo", "losetup", "-d", dev])
	if ret != 0:
		raise Exception("Can't dettach loopdev")

def mount_fs(dev, mount_point):
	ret = subprocess.check_call(["sudo", "mount", "-t", "ext2",
			dev, mount_point])
	if ret != 0:
		raise Exception("Can't mount loopdev")

def umount_fs(mount_point):
	ret = subprocess.check_call(["sudo", "umount", mount_point])
	if ret != 0:
		raise Exception("Can't umount loopdev")

def dmesg_print():
	ps = subprocess.Popen(["sudo", "dmesg"], stdout=subprocess.PIPE)
	output = subprocess.check_output(["tail"], stdin=ps.stdout)
	ps.wait()
	print output

if len(sys.argv) != 2:
	raise Exception("testfs: missing image to test")

fs_image = sys.argv[1]
dev = "/dev/loop10"
mount_point = "mount_point"
try:
	attach_to_dev(fs_image, dev, "17408")
	try:
		run_stats()
		mount_fs(dev, mount_point)
		os.system("ls -l " + mount_point)
		os.system("ls -l " + mount_point + "/etc")
		umount_fs(mount_point)
	except:
		dmesg_print()
		print("error while mounting fs", traceback.print_exc())
		umount_fs(mount_point)
	dettach_dev(dev)
except:
	print("error while testing dev")
	dettach_dev(dev)
