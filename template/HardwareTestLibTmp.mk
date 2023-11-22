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

# c_sources := \

# asm_sources := \

# Includes
cxx_includes := \
-I. \

# Defines
cxx_defs := \

# Linker script
ldscript = 

# Uncomment if gcc should be used for compilation *.c files
# use_gcc_for_c_files := 1

# Uncomment if you want to add custom flags for gcc or g++
# custom_c_flags :=
# custom_cxx_flags :=

# Append rest of Makefile from template
include $(make_dir)/HardwareTestLib.mk