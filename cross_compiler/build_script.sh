#!/bin/sh

export PREFIX="$HOME/OS/cross_compiler/cross"
export TARGET=i686-elf
export PATH="$PREFIX/bin:$PATH"

rm -rf ./gcc
rm -rf ./binutils
rm -rf ./build-binutils
rm -rf ./build-gcc
rm -rf ./build-libsupc
rm -rf "./cross$TARGET"

mkdir build-binutils
mkdir build-gcc
mkdir build-libsupc

git clone git://gcc.gnu.org/git/gcc.git gcc 
git clone git://sourceware.org/git/binutils-gdb.git binutils

sudo apt install build-essential build-essential bison flex libmpc-dev \
		libmpfr-dev texinfo libcloog-isl-dev libisl-dev 

# build binutils for target
cd build-binutils
../binutils/configure --target=$TARGET --prefix="$PREFIX" \
			--with-sysroot --disable-nls --disable-werror
make
make install
cd ..

# build gcc
cd build-gcc
../gcc/configure --target=$TARGET --prefix="$PREFIX" --disable-nls \
		--enable-languages=c,c++ --without-headers
make all-gcc
make all-target-libgcc
make install-gcc
make install-target-libgcc
cd ..

# build libsupc++
cd build-libsupc
CPP=$TARGET-cpp ../gcc/include/configure --target=$TARGET --prefix="$PREFIX" \
	--enable-languages=c,c++ --disable-hosted-libstdcxx --disable-nls --without-headers
make
make install
cd ../libsupc++
make
make install
cd ../../

