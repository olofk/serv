TOOLCHAIN_PREFIX?=riscv64-unknown-elf-
CC?=$(TOOLCHAIN_PREFIX)gcc
OBJCOPY=$(TOOLCHAIN_PREFIX)objcopy

%.elf: %.S link.ld
	$(CC) -nostartfiles -nostdlib -march=rv32i_zicsr -mabi=ilp32 -Tlink.ld -o$@ $<
%.bin: %.elf
	$(OBJCOPY) -O binary $< $@
%.hex: %.bin
	python3 makehex.py $< > $@

# RV32E targets: compile with rv32e march so the toolchain restricts
# register allocation to x0-x15 and uses the ilp32e ABI
hello_uart_rv32e.elf: hello_uart.S link.ld
	$(CC) -nostartfiles -nostdlib -march=rv32e -mabi=ilp32e -Tlink.ld -o$@ $<

trap_test_rv32e.elf: trap_test_rv32e.S link.ld
	$(CC) -nostartfiles -nostdlib -march=rv32e_zicsr -mabi=ilp32e -Tlink.ld -o$@ $<

clean:
	rm -f *.elf *.bin *.hex
