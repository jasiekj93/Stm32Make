# ------------------------------------------------
# @author Adrian Szczepanski
# @date 17-02-2023
# ------------------------------------------------

# This file is only a template and should be included 
# in other Makefile

# Toolchain
toolchain_prefix := arm-none-eabi-

# Mcu definition
cpu := -mcpu=cortex-m7
fpu := -mfpu=fpv5-sp-d16
float-abi := -mfloat-abi=hard
mcu := $(cpu) -mthumb $(fpu) $(float-abi)

# Compiler flags
platform_c_flags := -fdata-sections -ffunction-sections 
platform_cxx_flags := -ffreestanding -fno-exceptions -fno-rtti

# Debug flags
platform_debug_flags := -g -gdwarf-2

# Linker flags
platform_linker_flags := -specs=nano.specs -specs=nosys.specs