# ------------------------------------------------
# @author Adrian Szczepanski
# @date 06-03-2022
# ------------------------------------------------

# platform
export PLATFORM := ArmM7

# target
target = 

# Directories
project_dir := .
make_dir := $(project_dir)/make

# External libraries
external_names := \

external_lib_names := \

external_lib_dirs := \

# Sources 
cxx_sources :=  \

# Includes
cxx_includes :=  \
-I. \

# Append rest of Makefile from template
include $(make_dir)/MainLib.mk