# ------------------------------------------------
# @author Adrian Szczepanski
# @date 06-03-2023
# ------------------------------------------------

# This file is only a template and should be included 
# in other Makefile
PLATFORM ?= ARM
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

# Toolchain
ifeq ($(PLATFORM), Pc32)
PREFIX := 
else
PREFIX := arm-none-eabi-
endif

CXX := $(PREFIX)g++
CC := $(PREFIX)gcc
AS := $(PREFIX)gcc -x assembler-with-cpp
CP := $(PREFIX)objcopy
SZ := $(PREFIX)size
AR := $(PREFIX)ar
HEX := $(CP) -O ihex
BIN := $(CP) -O binary -S

# MCU definition
ifeq ($(PLATFORM), Pc32)
MCU := -m32
else
CPU := -mcpu=cortex-m7
FPU := -mfpu=fpv5-sp-d16
FLOAT-ABI := -mfloat-abi=hard
MCU := $(CPU) -mthumb $(FPU) $(FLOAT-ABI)
endif 

# Utilities
RMDIR ?= rm -rf
MKDIR ?= mkdir -p
