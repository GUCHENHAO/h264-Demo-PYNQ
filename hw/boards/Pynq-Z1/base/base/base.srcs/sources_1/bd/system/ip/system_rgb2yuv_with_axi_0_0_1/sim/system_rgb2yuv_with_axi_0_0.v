// (c) Copyright 1995-2017 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:user:rgb2yuv_with_axi:1.0
// IP Revision: 16

`timescale 1ns/1ps

(* DowngradeIPIdentifiedWarnings = "yes" *)
module system_rgb2yuv_with_axi_0_0 (
  clk,
  rstn,
  apb_prdata,
  apb_paddr,
  apb_penable,
  apb_psel,
  apb_pwdata,
  apb_pwrite,
  apb_pready,
  apb_pslverr,
  axi_m_arready,
  axi_m_awready,
  axi_m_bid,
  axi_m_bresp,
  axi_m_bvalid,
  axi_m_rdata,
  axi_m_rid,
  axi_m_rlast,
  axi_m_rresp,
  axi_m_rvalid,
  axi_m_wready,
  axi_m_araddr,
  axi_m_arburst,
  axi_m_arcache,
  axi_m_arid,
  axi_m_arlen,
  axi_m_arlock,
  axi_m_arprot,
  axi_m_arsize,
  axi_m_arvalid,
  axi_m_awaddr,
  axi_m_awburst,
  axi_m_awcache,
  axi_m_awid,
  axi_m_awlen,
  axi_m_awlock,
  axi_m_awprot,
  axi_m_awsize,
  axi_m_awvalid,
  axi_m_bready,
  axi_m_rready,
  axi_m_wdata,
  axi_m_wid,
  axi_m_wlast,
  axi_m_wstrb,
  axi_m_wvalid
);

(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *)
input wire clk;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rstn RST" *)
input wire rstn;
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 apb PRDATA" *)
output wire [31 : 0] apb_prdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 apb PADDR" *)
input wire [31 : 0] apb_paddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 apb PENABLE" *)
input wire apb_penable;
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 apb PSEL" *)
input wire apb_psel;
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 apb PWDATA" *)
input wire [31 : 0] apb_pwdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 apb PWRITE" *)
input wire apb_pwrite;
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 apb PREADY" *)
output wire apb_pready;
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 apb PSLVERR" *)
output wire apb_pslverr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m ARREADY" *)
input wire axi_m_arready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m AWREADY" *)
input wire axi_m_awready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m BID" *)
input wire [5 : 0] axi_m_bid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m BRESP" *)
input wire [1 : 0] axi_m_bresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m BVALID" *)
input wire axi_m_bvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m RDATA" *)
input wire [63 : 0] axi_m_rdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m RID" *)
input wire [5 : 0] axi_m_rid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m RLAST" *)
input wire axi_m_rlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m RRESP" *)
input wire [1 : 0] axi_m_rresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m RVALID" *)
input wire axi_m_rvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m WREADY" *)
input wire axi_m_wready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m ARADDR" *)
output wire [31 : 0] axi_m_araddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m ARBURST" *)
output wire [1 : 0] axi_m_arburst;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m ARCACHE" *)
output wire [3 : 0] axi_m_arcache;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m ARID" *)
output wire [5 : 0] axi_m_arid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m ARLEN" *)
output wire [3 : 0] axi_m_arlen;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m ARLOCK" *)
output wire [1 : 0] axi_m_arlock;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m ARPROT" *)
output wire [2 : 0] axi_m_arprot;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m ARSIZE" *)
output wire [2 : 0] axi_m_arsize;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m ARVALID" *)
output wire axi_m_arvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m AWADDR" *)
output wire [31 : 0] axi_m_awaddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m AWBURST" *)
output wire [1 : 0] axi_m_awburst;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m AWCACHE" *)
output wire [3 : 0] axi_m_awcache;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m AWID" *)
output wire [5 : 0] axi_m_awid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m AWLEN" *)
output wire [3 : 0] axi_m_awlen;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m AWLOCK" *)
output wire [1 : 0] axi_m_awlock;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m AWPROT" *)
output wire [2 : 0] axi_m_awprot;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m AWSIZE" *)
output wire [2 : 0] axi_m_awsize;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m AWVALID" *)
output wire axi_m_awvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m BREADY" *)
output wire axi_m_bready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m RREADY" *)
output wire axi_m_rready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m WDATA" *)
output wire [63 : 0] axi_m_wdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m WID" *)
output wire [5 : 0] axi_m_wid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m WLAST" *)
output wire axi_m_wlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m WSTRB" *)
output wire [7 : 0] axi_m_wstrb;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi_m WVALID" *)
output wire axi_m_wvalid;

  rgb2yuv_with_axi #(
    .AXI_DW(64),
    .AXI_AW(32),
    .AXI_MIDW(4),
    .AXI_SIDW(6),
    .AXI_WID(0),
    .AXI_RID(0),
    .APB_DW(32),
    .APB_AW(32)
  ) inst (
    .clk(clk),
    .rstn(rstn),
    .apb_prdata(apb_prdata),
    .apb_paddr(apb_paddr),
    .apb_penable(apb_penable),
    .apb_psel(apb_psel),
    .apb_pwdata(apb_pwdata),
    .apb_pwrite(apb_pwrite),
    .apb_pready(apb_pready),
    .apb_pslverr(apb_pslverr),
    .axi_m_arready(axi_m_arready),
    .axi_m_awready(axi_m_awready),
    .axi_m_bid(axi_m_bid),
    .axi_m_bresp(axi_m_bresp),
    .axi_m_bvalid(axi_m_bvalid),
    .axi_m_rdata(axi_m_rdata),
    .axi_m_rid(axi_m_rid),
    .axi_m_rlast(axi_m_rlast),
    .axi_m_rresp(axi_m_rresp),
    .axi_m_rvalid(axi_m_rvalid),
    .axi_m_wready(axi_m_wready),
    .axi_m_araddr(axi_m_araddr),
    .axi_m_arburst(axi_m_arburst),
    .axi_m_arcache(axi_m_arcache),
    .axi_m_arid(axi_m_arid),
    .axi_m_arlen(axi_m_arlen),
    .axi_m_arlock(axi_m_arlock),
    .axi_m_arprot(axi_m_arprot),
    .axi_m_arsize(axi_m_arsize),
    .axi_m_arvalid(axi_m_arvalid),
    .axi_m_awaddr(axi_m_awaddr),
    .axi_m_awburst(axi_m_awburst),
    .axi_m_awcache(axi_m_awcache),
    .axi_m_awid(axi_m_awid),
    .axi_m_awlen(axi_m_awlen),
    .axi_m_awlock(axi_m_awlock),
    .axi_m_awprot(axi_m_awprot),
    .axi_m_awsize(axi_m_awsize),
    .axi_m_awvalid(axi_m_awvalid),
    .axi_m_bready(axi_m_bready),
    .axi_m_rready(axi_m_rready),
    .axi_m_wdata(axi_m_wdata),
    .axi_m_wid(axi_m_wid),
    .axi_m_wlast(axi_m_wlast),
    .axi_m_wstrb(axi_m_wstrb),
    .axi_m_wvalid(axi_m_wvalid)
  );
endmodule
