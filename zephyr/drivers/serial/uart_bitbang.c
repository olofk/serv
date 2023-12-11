/*
 * Copyright (c) 2020 Olof Kindgren <olof.kindgren@gmail.com>
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <zephyr/kernel.h>
#include <zephyr/arch/cpu.h>
#include <zephyr/device.h>
#include <zephyr/drivers/uart.h>

#define DT_DRV_COMPAT olofk_serial

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

struct my_dev_data {

};

struct my_dev_cfg {

};

#define CREATE_MY_DEVICE(inst)                                       \
     static struct my_dev_data my_data_##inst = {                    \
     };                                                              \
     static const struct my_dev_cfg my_cfg_##inst = {                \
     };                                                              \
     DEVICE_DT_INST_DEFINE(inst,                                     \
                           uart_bitbang_init,                        \
                           NULL,                                     \
                           &my_data_##inst,                          \
                           &my_cfg_##inst,                           \
                           PRE_KERNEL_1, CONFIG_SERIAL_INIT_PRIORITY,  \
                           &uart_bitbang_driver_api);

DT_INST_FOREACH_STATUS_OKAY(CREATE_MY_DEVICE)
