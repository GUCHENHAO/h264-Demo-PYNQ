from pynq.overlays.h264 import H264Overlay
from pynq.lib.video import *
base = H264Overlay("h264.bit")

hdmi_in = base.video.hdmi_in
hdmi_in.configure(pixelformat=PIXEL_RGBA)
hdmi_in.start()


from pynq import MMIO
rgb2yuv = MMIO(base.ip_dict['h264/rgb2yuv_with_axi_0']['phys_addr'], 0x10000)
h264 = MMIO(base.ip_dict['h264/h264enc_with_axi_0']['phys_addr'], 0x10000)

from h264py.h264 import H264
h264_send = H264()

from pynq import Xlnk
xlnk = Xlnk()

size = 1920*1088*4

xlnk.xlnk_reset()
cma_recv = xlnk.cma_array((size,), dtype=np.uint8)
result = xlnk.cma_array((size,), dtype=np.uint8)

for i in range(200):
    cma_send = hdmi_in.readframe()

    rgb2yuv.write(0x04, cma_send.physical_address)
    rgb2yuv.write(0x08, cma_recv.physical_address)
    rgb2yuv.write(0x0c, 1088)
    rgb2yuv.write(0x10, 1920)
    rgb2yuv.write(0x14, 1920*1088)
    rgb2yuv.write(0x00, 1)
    rgb2yuv.write(0x00, 0)    
    while rgb2yuv.read(0x18)==1:
        pass
    while rgb2yuv.read(0x18)==0:
        pass

    h264.write(0x04, 0x00004377) # length 1088*1920
    h264.write(0x08, 0)
    h264.write(0x14, cma_recv.physical_address)
    h264.write(0x18, result.physical_address)
    h264.write(0x00, 1)
    while h264.read(0x24)==1:
        pass
    while h264.read(0x24)==0:
        pass
    
    h264_size = h264.read(0x1c)
    for i in range(20):
        if h264_size <= 1000000:
            print(h264_size)
            h264_send.send_frame(result[:h264_size])
    
    cma_send.freebuffer()
    time.sleep(1)

cma_recv.freebuffer()
result.freebuffer()
hdmi_in.stop()
xlnk.xlnk_reset()

