-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2026 Advanced Micro Devices, Inc. All Rights Reserved.
-- -------------------------------------------------------------------------------
-- This file contains confidential and proprietary information
-- of AMD and is protected under U.S. and international copyright
-- and other intellectual property laws.
--
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- AMD, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND AMD HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) AMD shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or AMD had been advised of the
-- possibility of the same.
--
-- CRITICAL APPLICATIONS
-- AMD products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of AMD products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
--
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
--
-- DO NOT MODIFY THIS FILE.

-- MODULE VLNV: amd.com:blockdesign:PCIe:1.0

-- The following code must appear in the VHDL architecture header.

-- COMP_TAG     ------ Begin cut for COMPONENT Declaration ------
COMPONENT PCIe
  PORT (
    sys_clk_clk_p : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    sys_clk_clk_n : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    sys_ddr_clk_n : IN STD_LOGIC;
    sys_ddr_clk_p : IN STD_LOGIC;
    DDR3_dq : INOUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    DDR3_dqs_p : INOUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    DDR3_dqs_n : INOUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    DDR3_addr : OUT STD_LOGIC_VECTOR(14 DOWNTO 0);
    DDR3_ba : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    DDR3_ras_n : OUT STD_LOGIC;
    DDR3_cas_n : OUT STD_LOGIC;
    DDR3_we_n : OUT STD_LOGIC;
    DDR3_reset_n : OUT STD_LOGIC;
    DDR3_ck_p : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    DDR3_ck_n : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    DDR3_cke : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    DDR3_cs_n : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    DDR3_dm : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    DDR3_odt : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    pci_exp_rxn : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    pci_exp_rxp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    pci_exp_txn : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    pci_exp_txp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    sys_rst_n : IN STD_LOGIC;
    sys_rst : IN STD_LOGIC;
    version_led_n : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
  );
END COMPONENT;
-- COMP_TAG_END ------  End cut for COMPONENT Declaration  ------

-- The following code must appear in the VHDL architecture
-- body. Substitute your own instance name and net names.

-- INST_TAG     ------ Begin cut for INSTANTIATION Template ------
your_instance_name : PCIe
  PORT MAP (
    sys_clk_clk_p => sys_clk_clk_p,
    sys_clk_clk_n => sys_clk_clk_n,
    sys_ddr_clk_n => sys_ddr_clk_n,
    sys_ddr_clk_p => sys_ddr_clk_p,
    DDR3_dq => DDR3_dq,
    DDR3_dqs_p => DDR3_dqs_p,
    DDR3_dqs_n => DDR3_dqs_n,
    DDR3_addr => DDR3_addr,
    DDR3_ba => DDR3_ba,
    DDR3_ras_n => DDR3_ras_n,
    DDR3_cas_n => DDR3_cas_n,
    DDR3_we_n => DDR3_we_n,
    DDR3_reset_n => DDR3_reset_n,
    DDR3_ck_p => DDR3_ck_p,
    DDR3_ck_n => DDR3_ck_n,
    DDR3_cke => DDR3_cke,
    DDR3_cs_n => DDR3_cs_n,
    DDR3_dm => DDR3_dm,
    DDR3_odt => DDR3_odt,
    pci_exp_rxn => pci_exp_rxn,
    pci_exp_rxp => pci_exp_rxp,
    pci_exp_txn => pci_exp_txn,
    pci_exp_txp => pci_exp_txp,
    sys_rst_n => sys_rst_n,
    sys_rst => sys_rst,
    version_led_n => version_led_n
  );
-- INST_TAG_END ------  End cut for INSTANTIATION Template  ------

-- You must compile the wrapper file PCIe.vhd when simulating
-- the module, PCIe. When compiling the wrapper file, be sure to
-- reference the VHDL simulation library.
