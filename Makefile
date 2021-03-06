NAME=myos
PREFIX=i686-elf
ROOT=$(shell pwd)
BUILD_DIR=$(ROOT)/build
GRUB=third_party/grub
CROSS=$(ROOT)/third_party/cross
AS=$(CROSS)/bin/$(PREFIX)-as
CC=$(CROSS)/bin/$(PREFIX)-gcc
LD=$(CROSS)/bin/$(PREFIX)-ld

.PHONY: all clean src iso run third_party

all: iso

clean:
	rm -rf $(BUILD_DIR)

src: clean
	mkdir -p $(BUILD_DIR)/boot
	$(MAKE) -C src BUILD_DIR=$(BUILD_DIR) PREFIX=$(PREFIX) ROOT=$(ROOT) \
	AS=$(AS) CC=$(CC) LD=$(LD)

third_party:
	$(MAKE) -C third_party ROOT=$(ROOT) PREFIX=$(PREFIX)

iso: src
	mkdir -p $(BUILD_DIR)/boot/grub
	cp grub.cfg $(BUILD_DIR)/boot/grub/grub.cfg
	$(CROSS)/grub-mkrescue -o $(BUILD_DIR)/$(NAME).iso $(BUILD_DIR)

run: iso
	qemu-system-x86_64 -kernel $(BUILD_DIR)/boot/kernel.bin
	#qemu-system-i386 -cdrom $(BUILD_DIR)/$(NAME).iso
