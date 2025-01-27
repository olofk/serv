        .section .text
        .global _start
        .global handler
_start:
        la t0, handler
        csrw mtvec, t0
        li t0, 0x8
        csrrs x0, mstatus, t0
        li t0, 0x800
        csrrs x0, mie, t0
loop:
        j loop
handler:
        li t0, 0x8
        csrrc x0, mstatus, t0
        li t0, 0x800
        csrrc x0, mie, t0
        mret
