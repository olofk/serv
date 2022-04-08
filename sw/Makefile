TOOLCHAIN_PREFIX=riscv64-unknown-elf-

%.elf: %.S link.ld
	$(TOOLCHAIN_PREFIX)gcc -nostartfiles -nostdlib -march=rv32i -mabi=ilp32 -Tlink.ld -o$@ $<
%.bin: %.elf
	$(TOOLCHAIN_PREFIX)objcopy -O binary $< $@
%.hex: %.bin
	python3 makehex.py $< 2048 > $@

clean:
	rm -f *.elf *.bin *.hex
