// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.2 (64-bit)
// Tool Version Limit: 2025.11
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
/***************************** Include Files *********************************/
#include "xfpga_relu_accelerator.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XFpga_relu_accelerator_CfgInitialize(XFpga_relu_accelerator *InstancePtr, XFpga_relu_accelerator_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Ctrl_BaseAddress = ConfigPtr->Ctrl_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XFpga_relu_accelerator_Start(XFpga_relu_accelerator *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XFpga_relu_accelerator_ReadReg(InstancePtr->Ctrl_BaseAddress, XFPGA_RELU_ACCELERATOR_CTRL_ADDR_AP_CTRL) & 0x80;
    XFpga_relu_accelerator_WriteReg(InstancePtr->Ctrl_BaseAddress, XFPGA_RELU_ACCELERATOR_CTRL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XFpga_relu_accelerator_IsDone(XFpga_relu_accelerator *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XFpga_relu_accelerator_ReadReg(InstancePtr->Ctrl_BaseAddress, XFPGA_RELU_ACCELERATOR_CTRL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XFpga_relu_accelerator_IsIdle(XFpga_relu_accelerator *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XFpga_relu_accelerator_ReadReg(InstancePtr->Ctrl_BaseAddress, XFPGA_RELU_ACCELERATOR_CTRL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XFpga_relu_accelerator_IsReady(XFpga_relu_accelerator *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XFpga_relu_accelerator_ReadReg(InstancePtr->Ctrl_BaseAddress, XFPGA_RELU_ACCELERATOR_CTRL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XFpga_relu_accelerator_EnableAutoRestart(XFpga_relu_accelerator *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XFpga_relu_accelerator_WriteReg(InstancePtr->Ctrl_BaseAddress, XFPGA_RELU_ACCELERATOR_CTRL_ADDR_AP_CTRL, 0x80);
}

void XFpga_relu_accelerator_DisableAutoRestart(XFpga_relu_accelerator *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XFpga_relu_accelerator_WriteReg(InstancePtr->Ctrl_BaseAddress, XFPGA_RELU_ACCELERATOR_CTRL_ADDR_AP_CTRL, 0);
}

void XFpga_relu_accelerator_Set_num_elements(XFpga_relu_accelerator *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XFpga_relu_accelerator_WriteReg(InstancePtr->Ctrl_BaseAddress, XFPGA_RELU_ACCELERATOR_CTRL_ADDR_NUM_ELEMENTS_DATA, Data);
}

u32 XFpga_relu_accelerator_Get_num_elements(XFpga_relu_accelerator *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XFpga_relu_accelerator_ReadReg(InstancePtr->Ctrl_BaseAddress, XFPGA_RELU_ACCELERATOR_CTRL_ADDR_NUM_ELEMENTS_DATA);
    return Data;
}

void XFpga_relu_accelerator_InterruptGlobalEnable(XFpga_relu_accelerator *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XFpga_relu_accelerator_WriteReg(InstancePtr->Ctrl_BaseAddress, XFPGA_RELU_ACCELERATOR_CTRL_ADDR_GIE, 1);
}

void XFpga_relu_accelerator_InterruptGlobalDisable(XFpga_relu_accelerator *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XFpga_relu_accelerator_WriteReg(InstancePtr->Ctrl_BaseAddress, XFPGA_RELU_ACCELERATOR_CTRL_ADDR_GIE, 0);
}

void XFpga_relu_accelerator_InterruptEnable(XFpga_relu_accelerator *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XFpga_relu_accelerator_ReadReg(InstancePtr->Ctrl_BaseAddress, XFPGA_RELU_ACCELERATOR_CTRL_ADDR_IER);
    XFpga_relu_accelerator_WriteReg(InstancePtr->Ctrl_BaseAddress, XFPGA_RELU_ACCELERATOR_CTRL_ADDR_IER, Register | Mask);
}

void XFpga_relu_accelerator_InterruptDisable(XFpga_relu_accelerator *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XFpga_relu_accelerator_ReadReg(InstancePtr->Ctrl_BaseAddress, XFPGA_RELU_ACCELERATOR_CTRL_ADDR_IER);
    XFpga_relu_accelerator_WriteReg(InstancePtr->Ctrl_BaseAddress, XFPGA_RELU_ACCELERATOR_CTRL_ADDR_IER, Register & (~Mask));
}

void XFpga_relu_accelerator_InterruptClear(XFpga_relu_accelerator *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XFpga_relu_accelerator_WriteReg(InstancePtr->Ctrl_BaseAddress, XFPGA_RELU_ACCELERATOR_CTRL_ADDR_ISR, Mask);
}

u32 XFpga_relu_accelerator_InterruptGetEnabled(XFpga_relu_accelerator *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XFpga_relu_accelerator_ReadReg(InstancePtr->Ctrl_BaseAddress, XFPGA_RELU_ACCELERATOR_CTRL_ADDR_IER);
}

u32 XFpga_relu_accelerator_InterruptGetStatus(XFpga_relu_accelerator *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XFpga_relu_accelerator_ReadReg(InstancePtr->Ctrl_BaseAddress, XFPGA_RELU_ACCELERATOR_CTRL_ADDR_ISR);
}

