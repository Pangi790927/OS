get git:
git clone git://gcc.gnu.org/git/gcc.git 

get binutils:
git clone git://sourceware.org/git/binutils-gdb.git binutils

sudo apt install build-essential build-essential bison flex libmpc-dev \
		libmpfr-dev texinfo libcloog-isl-dev libisl-dev 

export PREFIX="$HOME/OS/cross_compiler/cross"
export TARGET=i686-elf
export PATH="$PREFIX/bin:$PATH"

in binutils: 
	mkdir build-binutils
	cd build-binutils
	../binutils/configure --target=$TARGET --prefix="$PREFIX" \
			--with-sysroot --disable-nls --disable-werror
	make
	make install

# The $PREFIX/bin dir _must_ be in the PATH. We did that above.
which -- $TARGET-as || echo $TARGET-as is not in the PATH

no red zone(only for x86_64):
	>> create gcc/config/i386/t-x86_64-elf :
	# Add libgcc multilib variant without red-zone requirement
	MULTILIB_OPTIONS += mno-red-zone
	MULTILIB_DIRNAMES += no-red-zone

	>> replace
	 x86_64-*-elf*)
 	tm_file="${tm_file} i386/unix.h i386/att.h dbxelf.h elfos.h newlib-stdint.h i386/i386elf.h i386/x86-64.h"
 	;;
 	>> with:
	x86_64-*-elf*)
	tmake_file="${tmake_file} i386/t-x86_64-elf" # include the new multilib configuration
 	tm_file="${tm_file} i386/unix.h i386/att.h dbxelf.h elfos.h newlib-stdint.h i386/i386elf.h i386/x86-64.h"
 	;;

adding libstdc++(edit configure)
	>> cd gcc/libstdc++-v3
	{ { echo "$as_me:$LINENO: error: No support for this host/target combination." >&5
	echo "$as_me: error: No support for this host/target combination." >&2;}
	{ (exit 1); exit 1; }; }
   	;;
	>> and alter the third line so that it reads:
	{ { echo "$as_me:$LINENO: error: No support for this host/target combination." >&5
	echo "$as_me: error: No support for this host/target combination." >&2;}
	}
	;;

cd build-gcc
mkdir build-gcc
CPP=$TARGET-cpp ../gcc/configure --target=$TARGET --prefix="$PREFIX" \
	--enable-languages=c,c++ --disable-hosted-libstdcxx --disable-nls --without-headers
cd include
make all-gcc
make all-target-libgcc
make install-gcc
make install-target-libgcc
cd ../libsupc++
make
make install

   >> must have: malloc, free, abort and strlen.


like this when building:
	-L${OS}/cross/lib
	x86_64-elf-gcc $LDFLAGS -mno-red-zone -o kernel $SOURCES

	including abort, malloc, free, memcpy, memset and strlen.
	Libsupc++ also requires write, fputs, fputc, fwrite, strcpy and strcat for debugging output. 

	 #include <reent.h>
	 static struct _reent global_reent;
	 struct _reent *_impure_ptr = &global_reent;
