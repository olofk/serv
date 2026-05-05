/*
 * Copyright (c) 2020 Olof Kindgren <olof.kindgren@gmail.com>
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#ifndef __RISCV32_SERVANT_SOC_H_
#define __RISCV32_SERVANT_SOC_H_

#include <soc_common.h>

/* Bitbang UART configuration */
#define UART_BITBANG_BASE 0x40000000

/* Timer configuration */
#define SERV_TIMER_BASE   0x80000000
#define SERV_TIMER_IRQ    7

#endif /* __RISCV32_SERVANT_SOC_H_ */
