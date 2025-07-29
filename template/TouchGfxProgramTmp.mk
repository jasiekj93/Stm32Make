# ------------------------------------------------
# @author Adrian Szczepanski
# @date 20-12-2024
# ------------------------------------------------

# Platform
# Uncomment if program platform must be diffrent than the solution
# PLATFORM := Pc32
# Uncomment if program support only specific platforms and otherwise must be skipped
# supported_platforms := Pc32 Pc64 ArmA7-Linux ArmA9-Linux Rpi64

# Directories
project_dir ?= ..
make_dir := $(project_dir)/make
external_dir := $(project_dir)/external

# internal libraries
required_internal_libraries = \

# libraries
required_libraries = \

# external libraries
#	e.g. if include flag is '-I$(external_dir)/libFoo'
#	write 'libFoo'
external_library_include_path = \

external_library_flags = \

#	e.g. if link flag is '-L$(external_dir)/libFoo/lib'
#	write 'libFoo/lib'
external_library_paths = \

# Uncomment if gcc should be used for compilation *.c files
# use_gcc_for_c_files := 1

# Uncomment if you want to add custom flags for gcc or g++
# custom_c_flags :=
# custom_cxx_flags :=

# Uncomment if you want to add library flags and the end of the linking command (e.g. -pthread)
# terminating_libs := 

# Append rest of Makefile from template
include $(make_dir)/TouchGfxProgram.mk