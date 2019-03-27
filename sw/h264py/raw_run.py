# -*- coding: UTF-8 -*-
__author__ = 'sonnyhcl'
import socket
import time

import numpy as np

from config import *
from rtp import *

# UDP client
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
server_address = (DEST_IP, DEST_PORT)

# connect to VLC player
sock.connect(server_address)

# init rtp struct
rtp_hdr = RTP_FIXED_HEADER()
fu_ind = FU_INDICATOR()
fu_hdr = FU_HEADER()


def send_frame(sendbuf, seq_no_start, timestamp_start, fbs_cnt):
    # SPS
    rtp_hdr.seq_no = seq_no_start
    rtp_hdr.timestamp = timestamp_start
    sps = np.zeros(RTP_FIXED_HEADER_LEN + SPS_LEN, dtype=np.uint8)
    sps[:12] = rtp_hdr.pack()
    sps[12:] = sps_rtp
    debug("SPS:", sps, RTP_FIXED_HEADER_LEN + SPS_LEN)
    sock.send(sps)

    # PPS
    rtp_hdr.seq_no += 1
    pps = np.zeros(RTP_FIXED_HEADER_LEN + PPS_LEN, dtype=np.uint8)
    pps[:12] = rtp_hdr.pack()
    pps[12:] = pps_rtp
    debug("PPS:", pps, RTP_FIXED_HEADER_LEN + PPS_LEN)
    sock.send(pps)

    # SLICE
    rtp_hdr.marker = 0
    rtp_hdr.seq_no += 1
    sendbuf[:RTP_FIXED_HEADER_LEN] = rtp_hdr.pack()
    sendbuf[13:(13 + SLC_LEN)] = slc_rtp

    # fu_ind和fu_hdr的计算过程 不明 TODO
    fu_ind.F = sendbuf[13] & 0x80
    fu_ind.NRI = (sendbuf[13] & 0x60) >> 5
    fu_ind.TYPE = 28  # FU-A type = FU indicator + FU header
    sendbuf[12] = fu_ind.pack()

    fu_hdr.S = 1
    fu_hdr.E = 0
    fu_hdr.R = 0
    fu_hdr.TYPE = sendbuf[13] & 0x1f
    sendbuf[13] = fu_hdr.pack()
    debug("SLICE:", sendbuf, MAX_RTP_PKT_LENGTH + 14)
    sock.send(sendbuf[:MAX_RTP_PKT_LENGTH + 14])

    # Middle block
    middle = fbs_cnt / MAX_RTP_PKT_LENGTH - 1
    for t in range(int(middle)):
        rtp_hdr.seq_no += 1

        sendbuf = sendbuf[MAX_RTP_PKT_LENGTH:]
        sendbuf[0:RTP_FIXED_HEADER_LEN] = rtp_hdr.pack()
        sendbuf[12] = fu_ind.pack()

        fu_hdr.S = 0
        fu_hdr.E = 0
        fu_hdr.R = 0
        sendbuf[13] = fu_hdr.pack()
        debug("Middle-{:02d}:".format(t), sendbuf, MAX_RTP_PKT_LENGTH + 14)
        sock.send(sendbuf[:MAX_RTP_PKT_LENGTH + 14])

    # Last Block
    rtp_hdr.seq_no += 1
    rtp_hdr.marker = 1
    sendbuf = sendbuf[MAX_RTP_PKT_LENGTH:]
    sendbuf[:RTP_FIXED_HEADER_LEN] = rtp_hdr.pack()
    sendbuf[12] = fu_ind.pack()

    fu_hdr.S = 0
    fu_hdr.E = 1
    fu_hdr.R = 0
    sendbuf[13] = fu_hdr.pack()

    last = fbs_cnt % MAX_RTP_PKT_LENGTH
    debug("Last:", sendbuf, last)
    sock.send(sendbuf[:last])

    return rtp_hdr.seq_no + 1


if __name__ == "__main__":
    seq_no_start = 0
    timestamp_start = 0
    timestamp_delta = int(90000.0 / FRAMERATE)
    try:
        while True:
            with open("final", "rb") as f:
                raw_bs = f.read()
                rbs_len = len(raw_bs)
                fbs = np.zeros(rbs_len + 100, dtype=np.uint8)
                fbs_cur = 12 + 5 + 2 - 1  # 这些常量都是些什么鬼 TODO
                fbs[fbs_cur:(fbs_cur + rbs_len)] = list(raw_bs)

                fbs_cnt = rbs_len + fbs_cur

                seq_no_start = send_frame(fbs, seq_no_start, timestamp_start,
                                          fbs_cnt)
                timestamp_start += timestamp_delta
                time.sleep(0.2)
    finally:
        sock.close()