# -*- coding: UTF-8 -*-
__author__ = 'sonnyhcl'

FRAMERATE = 15
DEST_PORT = 1234
# DEST_IP = "localhost"
# DEST_IP = "10.131.245.147"
DESP_IP = "10.222.234.210"
debug_ = False
# debug_ = True
sep = 40


def debug(msg, buf, length):
    if not debug_:
        return
    print(msg)
    for i in range(int(length / sep)):
        for j in range(sep):
            print("0x{:02x}".format(buf[j + sep * i]), end=" ")
        print()
    for i in range(int(length / sep) * sep, length):
        print("0x{:02x}".format(buf[i]), end=" ")
    print("\n")
