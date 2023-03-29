# ------------------------------------------------
# @author Adrian Szczepanski
# @date 06-03-2022
# ------------------------------------------------

# platform
export PLATFORM := ArmM7

# project
project_name :=

# target
target = 

# Directories
project_dir := .
make_dir := $(project_dir)/make

# External libraries
external_names = \

external_lib_names = \

external_lib_dirs = \

# Project libraries
library_names = \

# Project subprograms
program_names = \

# Sources 
cxx_sources =  \

# Includes
cxx_includes =  \
-I. \

# Linker script
export ldscript = 

# Append rest of Makefile from template
include $(make_dir)/Main.mk