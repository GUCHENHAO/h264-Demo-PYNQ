# -*- coding: UTF-8 -*-
__author__ = 'sonnyhcl'

import socket

import numpy as np

from .config import *
from .rtp import *


class H264:
    '''
    TODO
    this H264 class actually needs a Singleton instance mode.
    '''

    def __init__(self):
        # UDP socket client
        self.sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        # print((DEST_IP, DEST_PORT))
        self.sock.connect(("10.222.234.210",1234))

        # initial rtp related struct
        self.rtp_hdr = RTP_FIXED_HEADER()
        self.fu_ind = FU_INDICATOR()
        self.fu_hdr = FU_HEADER()

        self.seq_no = 0
        self.timestamp = 0
        self.timestamp_delta = int(90000.0 / FRAMERATE)

    def send_frame(self, raw_h264):
        """

        :param raw_bs:np.array, dtype=np.uint8
        :return:
        """
        # constants
        padding_len = 12 + 2 + 5 - 1  # 这些常量都是些什么鬼 TODO
        fbs_cnt = padding_len + len(raw_h264)
        middle = fbs_cnt / MAX_RTP_PKT_LENGTH - 1
        last = fbs_cnt % MAX_RTP_PKT_LENGTH

        # SPS
        sps = np.zeros(RTP_FIXED_HEADER_LEN + SPS_LEN, dtype=np.uint8)
        sps[:12] = self.rtp_hdr.pack()
        sps[12:] = sps_rtp
        debug("SPS:", sps, RTP_FIXED_HEADER_LEN + SPS_LEN)
        self.sock.send(sps)

        # PPS
        pps = np.zeros(RTP_FIXED_HEADER_LEN + PPS_LEN, dtype=np.uint8)
        pps[:12] = self.rtp_hdr.pack()
        pps[12:] = pps_rtp
        debug("PPS:", pps, RTP_FIXED_HEADER_LEN + PPS_LEN)
        self.sock.send(pps)

        # SLICE
        self.rtp_hdr.marker = 0
        padding = np.zeros(padding_len, dtype=np.uint8)
        padding[:RTP_FIXED_HEADER_LEN] = self.rtp_hdr.pack()
        padding[13:(13 + SLC_LEN)] = slc_rtp

        # fu_ind和fu_hdr的计算过程 不明 TODO
        self.fu_ind.F = padding[13] & 0x80
        self.fu_ind.NRI = (padding[13] & 0x60) >> 5
        self.fu_ind.TYPE = 28  # FU-A type = FU indicator + FU header
        padding[12] = self.fu_ind.pack()

        self.fu_hdr.S = 1
        self.fu_hdr.E = 0
        self.fu_hdr.R = 0
        self.fu_hdr.TYPE = padding[13] & 0x1f
        padding[13] = self.fu_hdr.pack()

        send_buf = np.concatenate((padding, raw_h264, np.zeros(100, dtype=np.uint8)))
        debug("SLICE:", send_buf, MAX_RTP_PKT_LENGTH + 14)
        self.sock.send(send_buf[:MAX_RTP_PKT_LENGTH + 14])

        # Middle block
        for t in range(int(middle)):
            send_buf = send_buf[MAX_RTP_PKT_LENGTH:]
            send_buf[0:RTP_FIXED_HEADER_LEN] = self.rtp_hdr.pack()
            send_buf[12] = self.fu_ind.pack()

            self.fu_hdr.S = 0
            self.fu_hdr.E = 0
            self.fu_hdr.R = 0
            send_buf[13] = self.fu_hdr.pack()
            debug("Middle-{:02d}:".format(t), send_buf,
                  MAX_RTP_PKT_LENGTH + 14)
            self.sock.send(send_buf[:MAX_RTP_PKT_LENGTH + 14])

        # Last Block
        self.rtp_hdr.marker = 1
        # print(int(middle), last)
        send_buf = send_buf[MAX_RTP_PKT_LENGTH:]
        send_buf[:RTP_FIXED_HEADER_LEN] = self.rtp_hdr.pack()
        send_buf[12] = self.fu_ind.pack()

        self.fu_hdr.S = 0
        self.fu_hdr.E = 1
        self.fu_hdr.R = 0
        send_buf[13] = self.fu_hdr.pack()

        debug("Last:", send_buf, last)
        self.sock.send(send_buf[:last])

        self.rtp_hdr.timestamp += self.timestamp_delta


# h264 = H264()

# raw_h264 = np.fromfile('final', dtype=np.uint8)
# for i in range(10000):
#     print(i)
#     h264.send_frame(raw_h264)
