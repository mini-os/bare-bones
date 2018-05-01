LIBC=$(ROOT)/third_party/musl
C_SRCS=kernel.c

.PHONY: all

all:
	$(AS) boot.s -o $(BUILD_DIR)/boot.o

	$(CC) -c $(C_SRCS) -o $(BUILD_DIR)/kernel.o \
	-std=gnu99 -ffreestanding -O2 -Wall -Wextra
	
	$(CC) -T linker.ld -o $(BUILD_DIR)/boot/kernel.bin \
	-ffreestanding -shared -O2 -nostdlib \
	-I $(LIBC)/include \
	$(BUILD_DIR)/boot.o $(BUILD_DIR)/kernel.o \
	-lgcc

