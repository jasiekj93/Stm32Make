# ------------------------------------------------
# @author Adrian Szczepanski
# @date 06-03-2022
# ------------------------------------------------

# Platform
# Uncomment if program platform must be diffrent than the solution
# PLATFORM := Pc32

# Target
library_name := @library_name@

# Directories
project_dir ?= ..
make_dir := $(project_dir)/make
external_dir := $(project_dir)/external

# Sources 
cxx_sources :=  \
$(wildcard @library_sources@/*.cpp) \

# Includes
cxx_includes := \
-I. \

# Defines
cxx_defs := \

# internal libraries
required_libraries = \

# external libraries
#	e.g. if include flag is '-I$(external_dir)/libFoo'
#	write 'libFoo'
external_library_include_path = \

# Append rest of Makefile from template
include $(make_dir)/InternalSoftwareLibNoTests.mk
