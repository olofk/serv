/*
 * Copyright (c) 2020 Olof Kindgren <olof.kindgren@gmail.com>
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#ifndef __RISCV32_SERVANT_SOC_H_
#define __RISCV32_SERVANT_SOC_H_

#include <soc_common.h>
#include <devicetree.h>

/* Bitbang UART configuration */
#define UART_BITBANG_BASE 0x40000000

/* Timer configuration */
#define SERV_TIMER_BASE   0x80000000
#define SERV_TIMER_IRQ    7

/* lib-c hooks required RAM defined variables */
#define RISCV_RAM_BASE    DT_SRAM_BASE_ADDR_ADDRESS
#define RISCV_RAM_SIZE    DT_SRAM_SIZE

#endif /* __RISCV32_SERVANT_SOC_H_ */
