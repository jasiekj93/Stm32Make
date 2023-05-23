# ------------------------------------------------
# @author Adrian Szczepanski
# @date 06-03-2022
# ------------------------------------------------

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

# internal libraries
export required_libraries = \

# external libraries
#	e.g. if include flag is '-I$(external_dir)/libFoo'
#	write 'libFoo'
export external_library_include_path = \

# 	for testing purposes
export external_library_flags = \

# 	for testing purposes 
#	e.g. if link flag is '-L$(external_dir)/libFoo/lib'
#	write 'libFoo/lib'
export external_library_paths = \

# Append rest of Makefile from template
include $(make_dir)/HardwareLib.mk
