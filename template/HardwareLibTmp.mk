# ------------------------------------------------
# @author Adrian Szczepanski
# @date 06-03-2022
# ------------------------------------------------

# Target
library_name := 

# Directories
project_dir := ..
make_dir := $(project_dir)/make
external_dir := $(project_dir)/external

# Sources 
cxx_sources =  \

c_sources := \

asm_sources := \

# Includes
cxx_includes :=  \
-I. \

# Defines
cxx_defs := \

# internal libraries
export required_libraries = \

# external libraries
export external_library_includes = \

# 	for testing purposes
export external_library_flags = \

# 	for testing purposes 
export external_library_paths = \

# Append rest of Makefile from template
include $(make_dir)/HardwareLib.mk
