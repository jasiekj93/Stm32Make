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
lib_internal_dir = $(project_dir)/lib/$(build_type)/internal
test_dir = $(project_dir)/test/$(build_type)
external_lib_dir = $(project_dir)/external
docs_dir = $(project_dir)/docs

# Include platform specific settings
include $(make_dir)/platform/$(PLATFORM).mk

# Toolchain
CXX := $(toolchain_prefix)g++
CC := $(toolchain_prefix)gcc
AS := $(toolchain_prefix)gcc -x assembler-with-cpp
CP := $(toolchain_prefix)objcopy
SZ := $(toolchain_prefix)size
AR := $(toolchain_prefix)ar
HEX := $(CP) -O ihex
BIN := $(CP) -O binary -S

# Utilities
RMDIR ?= rm -rf
MKDIR ?= mkdir -p
