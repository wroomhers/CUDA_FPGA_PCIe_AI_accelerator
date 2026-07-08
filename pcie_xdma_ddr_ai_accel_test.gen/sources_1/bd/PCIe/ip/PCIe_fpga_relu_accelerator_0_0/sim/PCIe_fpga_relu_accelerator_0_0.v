// (c) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// (c) Copyright 2022-2026 Advanced Micro Devices, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of AMD and is protected under U.S. and international copyright
// and other intellectual property laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// AMD, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND AMD HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) AMD shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or AMD had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// AMD products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of AMD products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:hls:fpga_relu_accelerator:1.0
// IP Revision: 2114627989

`timescale 1ns/1ps

(* IP_DEFINITION_SOURCE = "HLS" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module PCIe_fpga_relu_accelerator_0_0 (
  s_axi_ctrl_ARADDR,
  s_axi_ctrl_ARREADY,
  s_axi_ctrl_ARVALID,
  s_axi_ctrl_AWADDR,
  s_axi_ctrl_AWREADY,
  s_axi_ctrl_AWVALID,
  s_axi_ctrl_BREADY,
  s_axi_ctrl_BRESP,
  s_axi_ctrl_BVALID,
  s_axi_ctrl_RDATA,
  s_axi_ctrl_RREADY,
  s_axi_ctrl_RRESP,
  s_axi_ctrl_RVALID,
  s_axi_ctrl_WDATA,
  s_axi_ctrl_WREADY,
  s_axi_ctrl_WSTRB,
  s_axi_ctrl_WVALID,
  ap_clk,
  ap_rst_n,
  interrupt,
  in_data_TDATA,
  in_data_TDEST,
  in_data_TID,
  in_data_TKEEP,
  in_data_TLAST,
  in_data_TREADY,
  in_data_TSTRB,
  in_data_TUSER,
  in_data_TVALID,
  out_data_TDATA,
  out_data_TDEST,
  out_data_TID,
  out_data_TKEEP,
  out_data_TLAST,
  out_data_TREADY,
  out_data_TSTRB,
  out_data_TUSER,
  out_data_TVALID
);

(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_ctrl ARADDR" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi_ctrl, ADDR_WIDTH 5, DATA_WIDTH 32, PROTOCOL AXI4LITE, READ_WRITE_MODE READ_WRITE, FREQ_HZ 125000000, ID_WIDTH 0, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN PCIe_xdma_0_1_axi_aclk, NUM_READ_THREADS 1, NUM_WRITE_TH\
READS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *)
input wire [4 : 0] s_axi_ctrl_ARADDR;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_ctrl ARREADY" *)
output wire s_axi_ctrl_ARREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_ctrl ARVALID" *)
input wire s_axi_ctrl_ARVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_ctrl AWADDR" *)
input wire [4 : 0] s_axi_ctrl_AWADDR;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_ctrl AWREADY" *)
output wire s_axi_ctrl_AWREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_ctrl AWVALID" *)
input wire s_axi_ctrl_AWVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_ctrl BREADY" *)
input wire s_axi_ctrl_BREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_ctrl BRESP" *)
output wire [1 : 0] s_axi_ctrl_BRESP;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_ctrl BVALID" *)
output wire s_axi_ctrl_BVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_ctrl RDATA" *)
output wire [31 : 0] s_axi_ctrl_RDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_ctrl RREADY" *)
input wire s_axi_ctrl_RREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_ctrl RRESP" *)
output wire [1 : 0] s_axi_ctrl_RRESP;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_ctrl RVALID" *)
output wire s_axi_ctrl_RVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_ctrl WDATA" *)
input wire [31 : 0] s_axi_ctrl_WDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_ctrl WREADY" *)
output wire s_axi_ctrl_WREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_ctrl WSTRB" *)
input wire [3 : 0] s_axi_ctrl_WSTRB;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_ctrl WVALID" *)
input wire s_axi_ctrl_WVALID;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 ap_clk CLK" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_clk, ASSOCIATED_BUSIF s_axi_ctrl:in_data:out_data, ASSOCIATED_RESET ap_rst_n, FREQ_HZ 125000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN PCIe_xdma_0_1_axi_aclk, INSERT_VIP 0" *)
input wire ap_clk;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 ap_rst_n RST" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
input wire ap_rst_n;
(* X_INTERFACE_INFO = "xilinx.com:signal:interrupt:1.0 interrupt INTERRUPT" *)
(* X_INTERFACE_MODE = "master" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME interrupt, SENSITIVITY LEVEL_HIGH, PortWidth 1" *)
output wire interrupt;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in_data TDATA" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME in_data, TUSER_WIDTH 1, TDATA_NUM_BYTES 4, TDEST_WIDTH 1, TID_WIDTH 1, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 125000000, PHASE 0.0, CLK_DOMAIN PCIe_xdma_0_1_axi_aclk, LAYERED_METADATA undef, INSERT_VIP 0" *)
input wire [31 : 0] in_data_TDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in_data TDEST" *)
input wire [0 : 0] in_data_TDEST;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in_data TID" *)
input wire [0 : 0] in_data_TID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in_data TKEEP" *)
input wire [3 : 0] in_data_TKEEP;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in_data TLAST" *)
input wire [0 : 0] in_data_TLAST;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in_data TREADY" *)
output wire in_data_TREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in_data TSTRB" *)
input wire [3 : 0] in_data_TSTRB;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in_data TUSER" *)
input wire [0 : 0] in_data_TUSER;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in_data TVALID" *)
input wire in_data_TVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_data TDATA" *)
(* X_INTERFACE_MODE = "master" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME out_data, TUSER_WIDTH 1, TDATA_NUM_BYTES 4, TDEST_WIDTH 1, TID_WIDTH 1, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 125000000, PHASE 0.0, CLK_DOMAIN PCIe_xdma_0_1_axi_aclk, LAYERED_METADATA undef, INSERT_VIP 0" *)
output wire [31 : 0] out_data_TDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_data TDEST" *)
output wire [0 : 0] out_data_TDEST;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_data TID" *)
output wire [0 : 0] out_data_TID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_data TKEEP" *)
output wire [3 : 0] out_data_TKEEP;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_data TLAST" *)
output wire [0 : 0] out_data_TLAST;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_data TREADY" *)
input wire out_data_TREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_data TSTRB" *)
output wire [3 : 0] out_data_TSTRB;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_data TUSER" *)
output wire [0 : 0] out_data_TUSER;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_data TVALID" *)
output wire out_data_TVALID;

(* SDX_KERNEL = "true" *)
(* SDX_KERNEL_TYPE = "hls" *)
(* SDX_KERNEL_SIM_INST = "inst" *)
  fpga_relu_accelerator #(
    .C_S_AXI_CTRL_ADDR_WIDTH(5),
    .C_S_AXI_CTRL_DATA_WIDTH(32)
  ) inst (
    .s_axi_ctrl_ARADDR(s_axi_ctrl_ARADDR),
    .s_axi_ctrl_ARREADY(s_axi_ctrl_ARREADY),
    .s_axi_ctrl_ARVALID(s_axi_ctrl_ARVALID),
    .s_axi_ctrl_AWADDR(s_axi_ctrl_AWADDR),
    .s_axi_ctrl_AWREADY(s_axi_ctrl_AWREADY),
    .s_axi_ctrl_AWVALID(s_axi_ctrl_AWVALID),
    .s_axi_ctrl_BREADY(s_axi_ctrl_BREADY),
    .s_axi_ctrl_BRESP(s_axi_ctrl_BRESP),
    .s_axi_ctrl_BVALID(s_axi_ctrl_BVALID),
    .s_axi_ctrl_RDATA(s_axi_ctrl_RDATA),
    .s_axi_ctrl_RREADY(s_axi_ctrl_RREADY),
    .s_axi_ctrl_RRESP(s_axi_ctrl_RRESP),
    .s_axi_ctrl_RVALID(s_axi_ctrl_RVALID),
    .s_axi_ctrl_WDATA(s_axi_ctrl_WDATA),
    .s_axi_ctrl_WREADY(s_axi_ctrl_WREADY),
    .s_axi_ctrl_WSTRB(s_axi_ctrl_WSTRB),
    .s_axi_ctrl_WVALID(s_axi_ctrl_WVALID),
    .ap_clk(ap_clk),
    .ap_rst_n(ap_rst_n),
    .interrupt(interrupt),
    .in_data_TDATA(in_data_TDATA),
    .in_data_TDEST(in_data_TDEST),
    .in_data_TID(in_data_TID),
    .in_data_TKEEP(in_data_TKEEP),
    .in_data_TLAST(in_data_TLAST),
    .in_data_TREADY(in_data_TREADY),
    .in_data_TSTRB(in_data_TSTRB),
    .in_data_TUSER(in_data_TUSER),
    .in_data_TVALID(in_data_TVALID),
    .out_data_TDATA(out_data_TDATA),
    .out_data_TDEST(out_data_TDEST),
    .out_data_TID(out_data_TID),
    .out_data_TKEEP(out_data_TKEEP),
    .out_data_TLAST(out_data_TLAST),
    .out_data_TREADY(out_data_TREADY),
    .out_data_TSTRB(out_data_TSTRB),
    .out_data_TUSER(out_data_TUSER),
    .out_data_TVALID(out_data_TVALID)
  );
endmodule
