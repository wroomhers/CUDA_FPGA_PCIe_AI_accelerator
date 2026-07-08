// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.2 (64-bit)
// Tool Version Limit: 2025.11
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#ifdef SDT
#include "xparameters.h"
#endif
#include "xfpga_relu_accelerator.h"

extern XFpga_relu_accelerator_Config XFpga_relu_accelerator_ConfigTable[];

#ifdef SDT
XFpga_relu_accelerator_Config *XFpga_relu_accelerator_LookupConfig(UINTPTR BaseAddress) {
	XFpga_relu_accelerator_Config *ConfigPtr = NULL;

	int Index;

	for (Index = (u32)0x0; XFpga_relu_accelerator_ConfigTable[Index].Name != NULL; Index++) {
		if (!BaseAddress || XFpga_relu_accelerator_ConfigTable[Index].Ctrl_BaseAddress == BaseAddress) {
			ConfigPtr = &XFpga_relu_accelerator_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XFpga_relu_accelerator_Initialize(XFpga_relu_accelerator *InstancePtr, UINTPTR BaseAddress) {
	XFpga_relu_accelerator_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XFpga_relu_accelerator_LookupConfig(BaseAddress);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XFpga_relu_accelerator_CfgInitialize(InstancePtr, ConfigPtr);
}
#else
XFpga_relu_accelerator_Config *XFpga_relu_accelerator_LookupConfig(u16 DeviceId) {
	XFpga_relu_accelerator_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XFPGA_RELU_ACCELERATOR_NUM_INSTANCES; Index++) {
		if (XFpga_relu_accelerator_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XFpga_relu_accelerator_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XFpga_relu_accelerator_Initialize(XFpga_relu_accelerator *InstancePtr, u16 DeviceId) {
	XFpga_relu_accelerator_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XFpga_relu_accelerator_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XFpga_relu_accelerator_CfgInitialize(InstancePtr, ConfigPtr);
}
#endif

#endif

