#!/usr/bin/env python3
#
# This is free and unencumbered software released into the public domain.
#
# Anyone is free to copy, modify, publish, use, compile, sell, or
# distribute this software, either in source code form or as a compiled
# binary, for any purpose, commercial or non-commercial, and by any
# means.

import sys

with open(sys.argv[1], "rb") as f:
    cnt = 3
    s = ["00"]*4
    while True:
        data = f.read(1)
        if not data:
            print(''.join(s))
            exit(0)
        s[cnt] = "{:02X}".format(data[0])
        if cnt == 0:
            print(''.join(s))
            s = ["00"]*4
            cnt = 4
        cnt -= 1