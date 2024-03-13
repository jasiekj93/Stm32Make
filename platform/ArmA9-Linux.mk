# ------------------------------------------------
# @author Adrian Szczepanski
# @date 17-02-2023
# ------------------------------------------------

# This file is only a template and should be included 
# in other Makefile

# Toolchain
toolchain_prefix := arm-poky-linux-gnueabi-

# Mcu definition
cpu := -mcpu=cortex-a9
fpu := -mfpu=neon
float-abi := -mfloat-abi=hard
mcu := $(cpu) $(fpu) $(float-abi) --sysroot=$(sysroot)

# Compiler flags
platform_c_flags := -fstack-protector-strong -Wformat -Wformat-security -Werror=format-security
platform_c_flags += -g -feliminate-unused-debug-types
platform_cxx_flags := 

# Debug flags
platform_debug_flags := -g -gstrict-dwarf 

# Linker flags
platform_linker_flags := -Wl,--hash-style=gnu -Wl,--as-needed -fstack-protector-strong -Wl,-z,relro,-z,now

# Libraries
platform_libraries := 

# Binary extensions
platform_binary_extensions := elf hex bin
