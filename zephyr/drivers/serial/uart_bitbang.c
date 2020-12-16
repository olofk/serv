/*
 * Copyright (c) 2020 Olof Kindgren <olof.kindgren@gmail.com>
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <kernel.h>
#include <arch/cpu.h>
#include <drivers/uart.h>

#define reg_uart_data (*(volatile uint32_t*)UART_BITBANG_BASE)

static struct k_spinlock lock;

static void uart_bitbang_poll_out(const struct device *dev, unsigned char c)
{
	ARG_UNUSED(dev);

	k_spinlock_key_t key = k_spin_lock(&lock);

	int cout = (c|0x100) << 1;
	do {
	  reg_uart_data = cout;
	  cout >>= 1;
	  __asm__ __volatile__ ("nop");
	  __asm__ __volatile__ ("nop");
	} while (cout);

	k_spin_unlock(&lock, key);
}

static int uart_bitbang_poll_in(const struct device *dev, unsigned char *c)
{
	ARG_UNUSED(dev);

	*c = reg_uart_data;
	return 0;
}

static int uart_bitbang_init(const struct device *dev)
{
  ARG_UNUSED(dev);
  reg_uart_data = 1;
	return 0;
}

static const struct uart_driver_api uart_bitbang_driver_api = {
	.poll_in          = uart_bitbang_poll_in,
	.poll_out         = uart_bitbang_poll_out,
	.err_check        = NULL,
};


DEVICE_AND_API_INIT(uart_bitbang, "uart0", &uart_bitbang_init,
		    NULL, NULL,
		    PRE_KERNEL_1, CONFIG_KERNEL_INIT_PRIORITY_DEVICE,
		    &uart_bitbang_driver_api);
