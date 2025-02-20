TOOLCHAIN_PREFIX?=riscv64-unknown-elf-
CC?=$(TOOLCHAIN_PREFIX)gcc
OBJCOPY=$(TOOLCHAIN_PREFIX)objcopy

%.elf: %.S link.ld
	$(CC) -nostartfiles -nostdlib -march=rv32i_zicsr -mabi=ilp32 -Tlink.ld -o$@ $<
%.bin: %.elf
	$(OBJCOPY) -O binary $< $@
%.hex: %.bin
	python3 makehex.py $< > $@

clean:
	rm -f *.elf *.bin *.hex
