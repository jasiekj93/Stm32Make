# ------------------------------------------------
# @author Adrian Szczepanski
# @date 17-02-2023
# ------------------------------------------------

# This file is only a template and should be included 
# in other Makefile

# Toolchain
toolchain_prefix := aarch64-poky-linux-

# Mcu definition
arch := -march=armv8.2-a 
branch_protection := -mbranch-protection=standard
mcu := $(arch) $(branch_protection) --sysroot=$(sysroot)

# Compiler flags
platform_c_flags := -fstack-protector-strong -Wformat -Wformat-security -Werror=format-security
platform_c_flags += -pipe -g -feliminate-unused-debug-types
platform_cxx_flags := 

# Debug flags
platform_debug_flags := -g -gstrict-dwarf 

# Linker flags
platform_linker_flags := -Wl,--hash-style=gnu -Wl,--as-needed -fstack-protector-strong -Wl,-z,relro,-z,now

# Libraries
platform_libraries := 

# Binary extensions
platform_binary_extensions := elf hex bin