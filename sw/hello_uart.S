#define GPIO_ADDR 0x40000000
#define HALT_ADDR 0x90000000

	/*
	a0 = GPIO address
	a1 = String address
	t0 = Character to write
	*/

.globl _start
_start:
	/* Load gpio address to a0 */
	li	a0, GPIO_ADDR

	/* Set GPIO high initially */
	addi	t0, zero, 1
	sb	t0, 0(a0)

	/* Load string address to a1 */
	la	a1, str

next_char:
	/* Read char from string */
	lbu	t0, 0(a1)

	/* If zero, we reached end of string and will exit the simulation */
	beqz	t0, halt

	/* Bitbanged UART loop */
	ori	t0, t0, 0x100
	slli	t0, t0, 1
1:	sb	t0, 0(a0)
	srli	t0, t0, 1

	/*
	 * Adding delay nops to achieve an approximate
	 * baud rate of 57600 at 16MHz
	*/
	nop
	nop
	bnez	t0, 1b

	/* Increase address to next char in string */
	addi	a1, a1, 1

	j	next_char

	/* Writing anything to HALT_ADDR will exit simulation */
halt:	li	t0, HALT_ADDR
	sw	zero, 0(t0)
	/*
	 * Loop to prevent PC from keep reading memory in case
	 * we run on real HW and not in simulation
	*/
	j	halt
str:
	.section .data
	.string "Hi, I'm Servant!\n"
