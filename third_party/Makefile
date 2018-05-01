CROSS=$(ROOT)/third_party/cross

.PHONY: all binutils gcc grub

all: binutils gcc grub

binutils:
	rm -rf build-binutils
	mkdir -p build-binutils $(CROSS)
	cd build-binutils && ../binutils/configure --target=$(PREFIX) --prefix=$(CROSS) \
	--with-sysroot --disable-nls --disable-werror
	$(MAKE) -C build-binutils
	$(MAKE) -C build-binutils install

gcc:
	mkdir -p gcc $(CROSS)
	tar -xvf gcc.xz -C gcc --strip-components=1
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
	cd grub && sh autogen.sh
	cd grub && sh configure --disable-werror --prefix=$(ROOT)/third_party/grub
	$(MAKE) -C grub

musl:
	cd musl && ./configure --prefix=$(ROOT)/third_party/musl --target=$(PREFIX) \
	CC=$(CC)
	$(MAKE) -C musl
