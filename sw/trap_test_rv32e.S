/*
 * trap_test_rv32e.S : RV32E trap/mret CSR path test
 *
 * Verifies that mtvec (RF[17] in RV32E) and mepc (RF[18] in RV32E)
 * are correctly read/written through the complete trap cycle:
 *   ecall -> trap_handler -> mret -> resume
 *
 * Uses only registers x0-x5 (well within x0-x15 RV32E limit).
 */

#define HALT_ADDR 0x90000000

	.globl _start
_start:
	/* Point mtvec at trap_handler (writes RF[17] in RV32E) */
	la	t0, trap_handler
	csrw	mtvec, t0

	/* Trigger a machine-mode trap via ecall */
	ecall

	/*
	 * mret in the handler advanced mepc past ecall and returned here.
	 * A timeout instead of reaching here would mean mtvec or mepc
	 * address mapping is wrong in the RV32E register file.
	 */
	li	t0, HALT_ADDR
	sw	zero, 0(t0)
	j	.		/* spin on real HW */

	.balign 4
trap_handler:
	/* Advance mepc past the ecall instruction (reads/writes RF[18]) */
	csrr	t0, mepc
	addi	t0, t0, 4
	csrw	mepc, t0
	mret
