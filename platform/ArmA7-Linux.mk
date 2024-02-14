# ------------------------------------------------
# @author Adrian Szczepanski
# @date 17-02-2023
# ------------------------------------------------

# This file is only a template and should be included 
# in other Makefile

# Toolchain
toolchain_prefix := arm-ostl-linux-gnueabi-

# Mcu definition
cpu := -mcpu=cortex-a7
fpu := -mfpu=neon-vfpv4
float-abi := -mfloat-abi=hard
mcu := $(cpu) -mthumb $(fpu) $(float-abi) --sysroot=$(sysroot)

# Compiler flags
platform_c_flags := -feliminate-unused-debug-types 
platform_cxx_flags := 

# Debug flags
platform_debug_flags := -g -gstrict-dwarf 

# Linker flags
platform_linker_flags := -feliminate-unused-debug-types 

# Libraries
platform_libraries := 

# Binary extensions
platform_binary_extensions := elf 