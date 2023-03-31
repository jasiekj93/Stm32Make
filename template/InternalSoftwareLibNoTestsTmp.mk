# ------------------------------------------------
# @author Adrian Szczepanski
# @date 06-03-2022
# ------------------------------------------------

# Target
library_name := 

# Directories
project_dir ?= ..
make_dir := $(project_dir)/make
external_dir := $(project_dir)/external

# Sources 
cxx_sources :=  \

# Includes
cxx_includes := \
-I. \

# Defines
cxx_defs := \

# internal libraries
required_libraries = \

# external libraries
external_library_includes = \

# Append rest of Makefile from template
include $(make_dir)/InternalSoftwareLibNoTests.mk
