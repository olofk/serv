#ifndef _COMPLIANCE_MODEL_H
#define _COMPLIANCE_MODEL_H

#define RVMODEL_HALT                                              \
    la a0, begin_signature;	 \
    la a1, end_signature; \
    li a2, 0x80000000; \
    compliance_halt_loop: \
        beq a0, a1, compliance_halt_break; \
        addi a3, a0, 4; \
    compliance_halt_loop2: \
        addi a3, a3, -1; \
    \
        lb a4, 0 (a3); \
        srai a5, a4, 4; \
        andi a5, a5, 0xF; \
        li a6, 10; \
        blt a5, a6, notLetter; \
        addi a5, a5, 39; \
    notLetter: \
        addi a5, a5, 0x30; \
        sw a5, 0 (a2); \
    \
        srai a5, a4, 0; \
        andi a5, a5, 0xF; \
        li a6, 10; \
        blt a5, a6, notLetter2; \
        addi a5, a5, 39; \
    notLetter2: \
        addi a5, a5, 0x30; \
        sw a5, 0 (a2); \
        bne a0, a3,compliance_halt_loop2;  \
        addi a0, a0, 4; \
    \
        li a4, '\n'; \
        sw a4, 0 (a2); \
        j compliance_halt_loop; \
        j compliance_halt_break;		\
    compliance_halt_break:; \
        lui	a0,0x90000000>>12;	\
        sw	a3,0(a0);


#define RVMODEL_DATA_BEGIN                                              \
    .align 4; .global begin_signature; begin_signature: \

#define RVMODEL_DATA_END                                                      \
    .align 4; .global end_signature; end_signature:   \


#define RVMODEL_BOOT \
.section .text.init;                                            \
        .align  4;                                                      \
        .globl _start;                                                  \
_start:  


#define LOCAL_IO_WRITE_STR(_STR) RVMODEL_IO_WRITE_STR(x31, _STR)
#define RVMODEL_IO_WRITE_STR(_SP, _STR)
#define LOCAL_IO_PUSH(_SP)
#define LOCAL_IO_POP(_SP)
#define RVMODEL_IO_ASSERT_GPR_EQ(_SP, _R, _I)
#define RVMODEL_IO_ASSERT_SFPR_EQ(_F, _R, _I)
#define RVMODEL_IO_ASSERT_DFPR_EQ(_D, _R, _I)

#define RVMODEL_SET_MSW_INT
#define RVMODEL_CLEAR_MSW_INT
#define RVMODEL_CLEAR_MTIMER_INT
#define RVMODEL_CLEAR_MEXT_INT

#endif // _COMPLIANCE_MODEL_H