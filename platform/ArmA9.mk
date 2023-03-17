# ------------------------------------------------
# @author Adrian Szczepanski
# @date 17-02-2023
# ------------------------------------------------

# This file is only a template and should be included 
# in other Makefile

# Toolchain
toolchain_prefix := arm-none-eabi-

# Name postfix
platform_name_postfix := ArmA9

# Mcu definition
mcu := -mcpu=cortex-a9 

# Compiler flags
platform_c_flags := -DNOT_USE_STD
platform_c_flags += -Wno-int-to-pointer-cast -Wno-write-strings -fno-operator-names
platform_cxx_flags := 

# Debug flags
platform_debug_flags := -g -gstrict-dwarf 

# Linker flags
platform_linker_flags := -specs=nano.specs -specs=nosys.specs

# Libraries
platform_libraries := -lc -lm -lnosys 

# Binary extensions
platform_binary_extensions := elf hex bin
