CROSS=$(ROOT)/third_party/cross

.PHONY: clean all binutils gcc grub

all: binutils gcc grub

clean:
	rm -rf build-binutils
	rm -rf build-gcc
	rm -rf grub
	rm -rf *.tar.xz *.tar.gz

binutils:
	rm -rf build-binutils
	mkdir -p build-binutils binutils $(CROSS)
	curl ftp://ftp.gnu.org/gnu/binutils/binutils-2.30.tar.gz > binutils.tar.gz
	tar -xvf binutils.tar.gz -C binutils --strip-components=1
	cd build-binutils && ../binutils/configure --target=$(PREFIX) --prefix=$(CROSS) \
	--with-sysroot --disable-nls --disable-werror
	$(MAKE) -C build-binutils
	$(MAKE) -C build-binutils install

gcc:
	mkdir -p gcc $(CROSS)
	curl ftp://ftp.gnu.org/gnu/gcc/gcc-7.3.0/gcc-7.3.0.tar.xz > gcc.tar.xz
	tar -xvf gcc.tar.xz -C gcc --strip-components=1
	rm -rf build-gcc
	mkdir -p build-gcc
	cd gcc && sh contrib/download_prerequisites
	cd build-gcc && sh ../gcc/configure --target=$(PREFIX) --prefix=$(CROSS) \
	--disable-nls --enable-languages=c,c++ --without-headers
	$(MAKE) -C build-gcc all-gcc
	$(MAKE) -C build-gcc all-target-libgcc
	$(MAKE) -C build-gcc install-gcc
	$(MAKE) -C build-gcc install-target-libgcc

grub:
	mkdir -p grub
	curl ftp://ftp.gnu.org/gnu/grub/grub-2.02.tar.xz > grub.tar.xz
	tar -xvf grub.tar.xz -C grub --strip-components=1
	cd grub && sh autogen.sh
	cd grub && sh configure --disable-werror --prefix=$(CROSS)
	$(MAKE) -C grub