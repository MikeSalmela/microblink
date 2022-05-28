CC=arm-none-eabi-gcc
OBJCOPY= arm-none-eabi-objcopy
CFLAGS= -c -mthumb -mcpu=cortex-m3 -o0
LDFLAGS= -nostdlib -T linker.ld

all:main.o vector.o final.elf final.bin

main.o:src/main.c
	$(CC) $(CFLAGS) -o $@ $^

vector.o:src/vector.c
	$(CC) $(CFLAGS) -o $@ $^

final.elf:main.o vector.o
	$(CC) $(LDFLAGS) -o $@ $^

final.bin:final.elf
	$(OBJCOPY) -O binary $^ $@

clean:
	rm *.o *.elf *.bin

flash:
	st-flash write final.bin 0x08000000

