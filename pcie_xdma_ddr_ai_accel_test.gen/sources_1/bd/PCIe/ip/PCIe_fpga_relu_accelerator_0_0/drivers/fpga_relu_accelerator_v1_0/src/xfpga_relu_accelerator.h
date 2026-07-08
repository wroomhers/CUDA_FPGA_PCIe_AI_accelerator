// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.2 (64-bit)
// Tool Version Limit: 2025.11
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
#ifndef XFPGA_RELU_ACCELERATOR_H
#define XFPGA_RELU_ACCELERATOR_H

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/
#ifndef __linux__
#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xil_io.h"
#else
#include <stdint.h>
#include <assert.h>
#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stddef.h>
#endif
#include "xfpga_relu_accelerator_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
#else
typedef struct {
#ifdef SDT
    char *Name;
#else
    u16 DeviceId;
#endif
    u64 Ctrl_BaseAddress;
} XFpga_relu_accelerator_Config;
#endif

typedef struct {
    u64 Ctrl_BaseAddress;
    u32 IsReady;
} XFpga_relu_accelerator;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XFpga_relu_accelerator_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XFpga_relu_accelerator_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XFpga_relu_accelerator_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XFpga_relu_accelerator_ReadReg(BaseAddress, RegOffset) \
    *(volatile u32*)((BaseAddress) + (RegOffset))

#define Xil_AssertVoid(expr)    assert(expr)
#define Xil_AssertNonvoid(expr) assert(expr)

#define XST_SUCCESS             0
#define XST_DEVICE_NOT_FOUND    2
#define XST_OPEN_DEVICE_FAILED  3
#define XIL_COMPONENT_IS_READY  1
#endif

/************************** Function Prototypes *****************************/
#ifndef __linux__
#ifdef SDT
int XFpga_relu_accelerator_Initialize(XFpga_relu_accelerator *InstancePtr, UINTPTR BaseAddress);
XFpga_relu_accelerator_Config* XFpga_relu_accelerator_LookupConfig(UINTPTR BaseAddress);
#else
int XFpga_relu_accelerator_Initialize(XFpga_relu_accelerator *InstancePtr, u16 DeviceId);
XFpga_relu_accelerator_Config* XFpga_relu_accelerator_LookupConfig(u16 DeviceId);
#endif
int XFpga_relu_accelerator_CfgInitialize(XFpga_relu_accelerator *InstancePtr, XFpga_relu_accelerator_Config *ConfigPtr);
#else
int XFpga_relu_accelerator_Initialize(XFpga_relu_accelerator *InstancePtr, const char* InstanceName);
int XFpga_relu_accelerator_Release(XFpga_relu_accelerator *InstancePtr);
#endif

void XFpga_relu_accelerator_Start(XFpga_relu_accelerator *InstancePtr);
u32 XFpga_relu_accelerator_IsDone(XFpga_relu_accelerator *InstancePtr);
u32 XFpga_relu_accelerator_IsIdle(XFpga_relu_accelerator *InstancePtr);
u32 XFpga_relu_accelerator_IsReady(XFpga_relu_accelerator *InstancePtr);
void XFpga_relu_accelerator_EnableAutoRestart(XFpga_relu_accelerator *InstancePtr);
void XFpga_relu_accelerator_DisableAutoRestart(XFpga_relu_accelerator *InstancePtr);

void XFpga_relu_accelerator_Set_num_elements(XFpga_relu_accelerator *InstancePtr, u32 Data);
u32 XFpga_relu_accelerator_Get_num_elements(XFpga_relu_accelerator *InstancePtr);

void XFpga_relu_accelerator_InterruptGlobalEnable(XFpga_relu_accelerator *InstancePtr);
void XFpga_relu_accelerator_InterruptGlobalDisable(XFpga_relu_accelerator *InstancePtr);
void XFpga_relu_accelerator_InterruptEnable(XFpga_relu_accelerator *InstancePtr, u32 Mask);
void XFpga_relu_accelerator_InterruptDisable(XFpga_relu_accelerator *InstancePtr, u32 Mask);
void XFpga_relu_accelerator_InterruptClear(XFpga_relu_accelerator *InstancePtr, u32 Mask);
u32 XFpga_relu_accelerator_InterruptGetEnabled(XFpga_relu_accelerator *InstancePtr);
u32 XFpga_relu_accelerator_InterruptGetStatus(XFpga_relu_accelerator *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
