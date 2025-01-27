        .section .text
        .global _start
        .global handler
        .equ DELAY, 1500
_start:
        la t0, handler
        csrw mtvec, t0
        li t0, 0x80000000
        li t1, DELAY
        sw t1, 0(t0)
        li t0, 0x8
        csrrs x0, mstatus, t0
        li t0, 0x80
        csrrs x0, mie, t0
wait:
        j wait
handler:
        li t0, 0x8
        csrrc x0, mstatus, t0
        li t0, 0x80
        csrrc x0, mie, t0
        mret
