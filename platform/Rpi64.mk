# ------------------------------------------------
# @author Adrian Szczepanski
# @date 17-02-2023
# ------------------------------------------------

# This file is only a template and should be included 
# in other Makefile

# Toolchain
toolchain_prefix := aarch64-rpi3-linux-gnu-

# Mcu definition
mcu := --sysroot=$(sysroot) 

# Compiler flags
platform_c_flags := 
platform_cxx_flags := 

# Debug flags
platform_debug_flags := -g -gdwarf-2

# Linker flags
platform_linker_flags := 

# Libraries
platform_libraries := 

# Binary extensions
platform_binary_extensions := elf 