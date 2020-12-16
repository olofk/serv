# Copyright (c) 2020 Olof Kindgren <olof.kindgren@gmail.com>
# SPDX-License-Identifier: Apache-2.0

add_subdirectory_ifdef(CONFIG_SERIAL_HAS_DRIVER serial)
add_subdirectory_ifdef(CONFIG_SYS_CLOCK_EXISTS timer)

