%.elf: %.S
	riscv64-unknown-elf-gcc -nostartfiles -march=rv32i -mabi=ilp32 -Tlink.ld -o$@ $<
%.bin: %.elf
	riscv64-unknown-elf-objcopy -O binary $< $@
%.hex: %.bin
	python3 makehex.py $< 2048 > $@

clean:
	rm -f *.elf *.bin *.hex
