# -*- coding: UTF-8 -*-
__author__ = 'sonnyhcl'
import socket

from config import *

address = (DEST_IP, DEST_PORT)
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.bind(address)


def display(buf, length):
    sep = 30
    for i in range(int(length / sep)):
        for j in range(sep):
            print("0x{:02x}".format(buf[j + sep * i]), end=" ")
        print()
    for i in range(int(length / sep) * sep, length):
        print("0x{:02x}".format(buf[i]), end=" ")
    print("\n")


try:
    print("waiting...")
    while True:
        data, addr = sock.recvfrom(2048)
        display(data, len(data))
finally:
    sock.close()
