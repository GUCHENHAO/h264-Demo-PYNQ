# -*- coding: UTF-8 -*-
__author__ = 'sonnyhcl'

import struct

from .constants import *


class RTP_FIXED_HEADER:
    """
    /******************************************************************
    RTP_FIXED_HEADER
    0                   1                   2                   3
    0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    |V=2|P|X|  CC   |M|     PT      |       sequence number         |
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    |                           timestamp                           |
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    |           synchronization source (SSRC) identifier            |
    +=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
    |            contributing source (CSRC) identifiers             |
    |                             ....                              |
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

    ******************************************************************/
    typedef struct
    {
        /* byte 0 */
        unsigned char csrc_len:4; /* CC expect 0 */
        unsigned char extension:1;/* X  expect 1, see RTP_OP below */
        unsigned char padding:1;  /* P  expect 0 */
        unsigned char version:2;  /* V  expect 2 */
        /* byte 1 */
        unsigned char payload:7; /* PT  RTP_PAYLOAD_RTSP */
        unsigned char marker:1;  /* M   expect 1 */
        /* byte 2,3 */
        unsigned short seq_no;   /*sequence number*/
        /* byte 4-7 */
        unsigned  long timestamp;
        /* byte 8-11 */
        unsigned long ssrc; /* stream number is used here. */
    } RTP_FIXED_HEADER;/*12 bytes*/
    """

    def __init__(self, ):
        self.csrc_len = 0
        self.extension = 0
        self.padding = 0
        self.version = 2
        self.payload = H264
        self.marker = 1
        self.seq_no = 0
        self.timestamp = 0
        self.ssrc = 0

    def pack(self, ):
        """
        I don't know why it is bit-reversed.
        """
        # increase one when calls a rtp head pack
        self.seq_no += 1

        byte0 = ((self.csrc_len & 0x1111) << 0) + \
                ((self.extension & 0b1) << 4) + \
                ((self.padding & 0b1) << 5) + \
                ((self.version & 0b11) << 6)
        byte1 = ((self.marker & 0b1) << 7) + \
                ((self.payload & 0b11111111) << 0)
        return list(struct.pack("!BBHII",
                                byte0,
                                byte1,
                                (self.seq_no & 0xFFFF),
                                (self.timestamp & 0xFFFFFFFF),
                                (self.ssrc & 0xFFFFFFFF)))


class NALU_HEADER:
    """
    /******************************************************************
    NALU_HEADER
    +---------------+
    |0|1|2|3|4|5|6|7|
    +-+-+-+-+-+-+-+-+
    |F|NRI|  Type   |
    +---------------+
    ******************************************************************/
    typedef struct {
        //byte 0
        unsigned char TYPE:5;
        unsigned char NRI:2;
        unsigned char F:1;
    } NALU_HEADER; /* 1 byte */
    """

    def __init__(self, ):
        self.TYPE = 0
        self.NRI = 0
        self.F = 0

    def pack(self, ):
        byte0 = ((self.TYPE & 0b11111) << 0) + \
                ((self.NRI & 0b11) << 5) + \
                ((self.F & 0b1) << 7)
        return ord(struct.pack("!B", byte0))


class FU_INDICATOR(NALU_HEADER):
    """
    /******************************************************************
    FU_INDICATOR
    +---------------+
    |0|1|2|3|4|5|6|7|
    +-+-+-+-+-+-+-+-+
    |F|NRI|  Type   |
    +---------------+
    ******************************************************************/
    typedef struct {
        //byte 0
        unsigned char TYPE:5;
        unsigned char NRI:2;
        unsigned char F:1;
    } FU_INDICATOR; /*1 byte */
    """


class FU_HEADER:
    """
    /******************************************************************
    FU_HEADER
    +---------------+
    |0|1|2|3|4|5|6|7|
    +-+-+-+-+-+-+-+-+
    |S|E|R|  Type   |
    +---------------+
    ******************************************************************/
    typedef struct {
        //byte 0
        unsigned char TYPE:5;
        unsigned char R:1;
        unsigned char E:1;
        unsigned char S:1;
    } FU_HEADER; /* 1 byte */
    """

    def __init__(self, ):
        self.TYPE = 0
        self.R = 0
        self.E = 0
        self.S = 0

    def pack(self, ):
        byte0 = ((self.TYPE & 0b11111) << 0) + \
                ((self.R & 0b1) << 5) + \
                ((self.E & 0b1) << 6) + \
                ((self.S & 0b1) << 7)
        return ord(struct.pack("!B", byte0))
