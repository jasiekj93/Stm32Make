# ------------------------------------------------
# @author Adrian Szczepanski
# @date 06-03-2023
# ------------------------------------------------

# This file is only a template and should be included 
# in other Makefile

# Release
generate_lst_files = 0
generate_debug_info = 0
optimalization = -O0

# Debug
ifeq ($(build_type), debug)
generate_lst_files = 1
generate_debug_info = 1
optimalization = -O0
endif

### GCC flags ###
CFLAGS = $(mcu) $(cxx_defs) $(cxx_includes) $(optimalization)
CFLAGS += $(platform_c_flags)
CXXFLAGS += $(platform_cxx_flags)

# Add debug flags
ifeq ($(generate_debug_info), 1)
CFLAGS += $(platform_debug_flags)
endif

# Generate dependency information as 'make' rules
CFLAGS += -MMD -MP -MF"$(@:%.o=%.d)" 

# Generate assembly output into build directory
ifeq ($(generate_lst_files), 1)
CFLAGS += -Wa,-a,-ad,-alms=$(build_dir)/$(notdir $(<:.cpp=.lst))
endif

# G++ specyfic flags
CXXFLAGS += $(CFLAGS) -std=c++17 

# Assembler flags
ASFLAGS += $(mcu) $(asm_defs) $(asm_includes) $(optimalization) -Wall -fdata-sections -ffunction-sections -ffreestanding -fno-exceptions

# Linker flags and directories
# Libraries are stored in variable LDLIBS
LDFLAGS += $(mcu) -L$(lib_dir) -Wl,-Map=$(build_dir)/$(target).map,--cref -Wl,--gc-sections
LDFLAGS += $(platform_linker_flags)