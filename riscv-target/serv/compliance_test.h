// RISC-V Compliance Test Header File
// Copyright (c) 2017, Codasip Ltd. All Rights Reserved.
// See LICENSE for license details.
//
// Description: Common header file for RV32I tests

#ifndef _COMPLIANCE_TEST_H
#define _COMPLIANCE_TEST_H

//-----------------------------------------------------------------------
// RV Compliance Macros
//-----------------------------------------------------------------------

#define RV_COMPLIANCE_HALT              \
la a0, data_begin;	 \
        la a1, data_end; \
        li a2, 0x80000000; \
complience_halt_loop: \
        beq a0, a1, complience_halt_break; \
        addi a3, a0, 4; \
complience_halt_loop2: \
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
        bne a0, a3,complience_halt_loop2;  \
        addi a0, a0, 4; \
	\
        li a4, '\n'; \
        sw a4, 0 (a2); \
        j complience_halt_loop; \
  j complience_halt_break;		\
complience_halt_break:; \
	lui	a0,0x90000000>>12;	\
	sw	a3,0(a0);		

#define RV_COMPLIANCE_RV32M

#define RV_COMPLIANCE_CODE_BEGIN                                              \
        .section .text.init;                                            \
        .align  4;                                                      \
        .globl _start;                                                  \
_start:                                                                 \

#define RV_COMPLIANCE_CODE_END

#define RV_COMPLIANCE_DATA_BEGIN .align 4; .global data_begin; data_begin:

#define RV_COMPLIANCE_DATA_END .align 4; .global data_end; data_end:

#endif
