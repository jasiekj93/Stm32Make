# ------------------------------------------------
# @author Adrian Szczepanski
# @date 30-05-2025
# ------------------------------------------------

# This file is only a template and should be included 
# in other Makefile

# cmse-nsc-outfile-o is the path to the output file of TrustZone Non-Secure Callable (NSC) functions 
# that will be created during compilation of the Secure program.
# This file is used by Non-secure program and must be added in $(additional_objects) variable in Non-Secure Makefile.
$(if $(cmse-nsc-outfile-o),,$\
	$(error ERROR: Variable 'cmse-nsc-outfile-o' is empty!))

# Toolchain
toolchain_prefix := arm-none-eabi-

# Mcu definition
cpu := -mcpu=cortex-m33
fpu := -mfpu=fpv4-sp-d16
float-abi := -mfloat-abi=hard
mcu := $(cpu) -mthumb $(fpu) $(float-abi)

# Compiler flags
platform_c_flags := -fdata-sections -ffunction-sections -mcmse
platform_cxx_flags := -ffreestanding -fno-exceptions -fno-rtti 

# Debug flags
platform_debug_flags := -g -gdwarf-2

# Linker flags
platform_linker_flags := -specs=nano.specs -specs=nosys.specs -Wl,--print-memory-usage \
-Wl,--cmse-implib -Wl,--out-implib=$(cmse-nsc-outfile-o)

# Libraries
platform_libraries := -lc -lm -lnosys 

# Binary extensions
platform_binary_extensions := elf hex bin