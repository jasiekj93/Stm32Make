# ------------------------------------------------
# @author Adrian Szczepanski
# @date 06-03-2023
# ------------------------------------------------

# This file is only a template and should be included 
# in other Makefile
PLATFORM ?= ArmM7
build_type ?= debug

# directories
project_dir ?= ..
build_root_dir = $(project_dir)/build
bin_root_dir = $(project_dir)/bin
lib_root_dir = $(project_dir)/lib
test_root_dir = $(project_dir)/test
build_dir = $(project_dir)/build/$(build_type)/$(target)
bin_dir = $(project_dir)/bin/$(build_type)
lib_dir = $(project_dir)/lib/$(build_type)
test_dir = $(project_dir)/test/$(build_type)
external_lib_dir = $(project_dir)/external

include $(make_dir)/platform/$(PLATFORM).mk

# Toolchain
ifeq ($(PLATFORM), Pc32)
prefix := 
else
prefix := arm-none-eabi-
endif

CXX := $(prefix)g++
CC := $(prefix)gcc
AS := $(prefix)gcc -x assembler-with-cpp
CP := $(prefix)objcopy
SZ := $(prefix)size
AR := $(prefix)ar
HEX := $(CP) -O ihex
BIN := $(CP) -O binary -S

# mcu definition
ifeq ($(PLATFORM), Pc32)
mcu := -m32
else ifeq ($(PLATFORM), ArmA9)
mcu := -mcpu=cortex-a9 
else ifeq ($(PLATFORM), ArmM7)
cpu := -mcpu=cortex-m7
fpu := -mfpu=fpv5-sp-d16
float-abi := -mfloat-abi=hard
mcu := $(cpu) -mthumb $(fpu) $(float-abi)
else
cpu := -mcpu=cortex-m4
fpu := -mfpu=fpv4-sp-d16
float-abi := -mfloat-abi=hard
mcu := $(cpu) -mthumb $(fpu) $(float-abi)
endif

# Utilities
RMDIR ?= rm -rf
MKDIR ?= mkdir -p
