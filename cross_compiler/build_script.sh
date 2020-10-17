#!/bin/sh

# CONFIGURE ALL ================================================================
export PREFIX="$(pwd)/cross"
export TARGET=i686-elf
export PATH="$PREFIX/bin:$PATH"
rm -rf "./cross$TARGET"

# INSTALL COMMON REQUIRMENTS ===================================================
sudo apt install build-essential build-essential bison flex libmpc-dev \
		libmpfr-dev texinfo libcloog-isl-dev libisl-dev 

# BUILD BINUTILS ===============================================================
rm -rf ./binutils
rm -rf ./build-binutils
mkdir build-binutils
git clone git://sourceware.org/git/binutils-gdb.git binutils

# build binutils for target
cd build-binutils
../binutils/configure --target=$TARGET --prefix="$PREFIX" \
			--with-sysroot --disable-nls --disable-werror
make
make install
cd ..

# BUILD GCC ====================================================================
rm -rf ./gcc
rm -rf ./build-gcc
mkdir build-gcc
git clone https://github.com/gcc-mirror/gcc.git gcc 

# build gcc
cd build-gcc
../gcc/configure --target=$TARGET --prefix="$PREFIX" --disable-nls \
		--enable-languages=c,c++ --without-headers
make all-gcc
make install-gcc

make all-target-libgcc
make install-target-libgcc
cd ..
