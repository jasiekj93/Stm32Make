# ------------------------------------------------
# @author Adrian Szczepanski
# @date 06-03-2023
# ------------------------------------------------

# Target
tested_library_name := @library_name@

# Directories
project_dir ?= ../..
make_dir := $(project_dir)/make
external_dir := $(project_dir)/external

# Sources 
cxx_sources :=  \
$(wildcard *.cpp) \

# Includes
cxx_includes := \
-I. \

# Defines
cxx_defs := \

# Linker script
ldscript = 

# Append rest of Makefile from template
include $(make_dir)/HardwareTestLib.mk