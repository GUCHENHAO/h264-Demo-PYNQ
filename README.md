# h264-Demo-PYNQ

1. This project is setup up with vivado 2016.01 and support 720p@30fps encoding.
2. How to run this demo.
	- Browse the website "https://pynq.readthedocs.io" and learn how to setup the PYNQ board.
	- Prepare a micro-sd card and make the JP4 on PYNQ to "SD" mode. 
	- Copy everything from the "PYNQ Environment" to the sd card, such as the "h264" folder and the "jupyter_notebooks" folder.
	- Connect the PYNQ board and PC1 together with jtag-usb and ethernet cable.
	- Connect the PYNQ board and PC2 together with hdmi, which is used as video source.
	- Power on the PYNQ and reconfig IP address.
	- Open a web browser and connect to Jupyter Notebooks.
	- Run the "使用VLC接收HDMI视频流.ipynb".
	- Open the "w.sdp" with VLC on PC1 and click the "play" button.
	- The you can see the decoding result in the VLC.
3. Demo link: https://www.bilibili.com/video/av17380536
	
