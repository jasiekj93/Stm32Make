# ------------------------------------------------
# @author Adrian Szczepanski
# @date 17-02-2023
# ------------------------------------------------

# This file is only a template and should be included 
# in other Makefile

# Toolchain
toolchain_prefix := arm-none-eabi-

# Mcu definition
mcu := -mcpu=cortex-a9 

# Compiler flags
platform_c_flags := -fdata-sections -ffunction-sections 
platform_c_flags += -DNOT_USE_STD
platform_c_flags += -Wno-int-to-pointer-cast -fno-operator-names -Wno-write-strings 
platform_cxx_flags := -ffreestanding -fno-exceptions -fno-rtti

# Debug flags
platform_debug_flags := -g -gstrict-dwarf 

# Linker flags
platform_linker_flags := -specs=nano.specs -specs=nosys.specs