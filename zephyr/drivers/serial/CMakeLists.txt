# Copyright (c) 2020 Olof Kindgren <olof.kindgren@gmail.com>
# SPDX-License-Identifier: Apache-2.0

set(ZEPHYR_CURRENT_LIBRARY drivers__serial)

zephyr_library_sources_ifdef(CONFIG_UART_BITBANG uart_bitbang.c)
