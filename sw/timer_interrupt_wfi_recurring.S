        .section .text
        .global _start
        .global handler
        .equ DELAY, 8000
_start:
        la t0, handler
        csrw mtvec, t0

        li t0, 0x80000000
        li s2, DELAY
        sw s2, 0(t0)

        li t0, 0x8
        csrrs x0, mstatus, t0
        li t0, 0x80
        csrrs x0, mie, t0
wait:
        wfi
        j wait

handler:
        
        li t1, DELAY
        add s2, t1, s2

        li t0, 0x80000000
        sw s2, 0(t0)
        
        mret
