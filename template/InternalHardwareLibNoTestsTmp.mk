# ------------------------------------------------
# @author Adrian Szczepanski
# @date 06-03-2022
# ------------------------------------------------

# Platform
# Uncomment if program platform must be diffrent than the solution
# override PLATFORM := Pc32

# Target
library_name := @library_name@

# Directories
project_dir := ..
make_dir := $(project_dir)/make
external_dir := $(project_dir)/external

# Sources 
cxx_sources =  \
$(wildcard @library_sources@/*.cpp) \

c_sources := \

asm_sources := \

# Includes
cxx_includes :=  \
-I. \

# Defines
cxx_defs := \

# Uncomment if gcc should be used for compilation *.c files
# use_gcc_for_c_files := 1

# Append rest of Makefile from template
include $(make_dir)/InternalHardwareLibNoTests.mk
