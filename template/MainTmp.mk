# ------------------------------------------------
# @author Adrian Szczepanski
# @date 06-03-2022
# ------------------------------------------------

# platform
export PLATFORM := ArmM7

# project
project_name :=

# Directories
project_dir := .
make_dir := $(project_dir)/make

# External libraries
external_names = \

# Project internal libraries
internal_library_names = \

# Project subprograms
program_names = \

# Project libraries
library_names = \

# Append rest of Makefile from template
include $(make_dir)/Main.mk

# Enter the internal library dependencies (by directory name)
# 	E.g.: if libproject-a depends on libproject-b write the line above:
#	libproject-a: libproject-b

# Custom targets