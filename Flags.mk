# ------------------------------------------------
# @author Adrian Szczepanski
# @date 06-03-2023
# ------------------------------------------------

# This file is only a template and should be included 
# in other Makefile

# Release
generate_lst_files = 0
generate_debug_info = 0
optimalization = -Os

# Debug
ifeq ($(build_type), debug)
generate_lst_files = 1
generate_debug_info = 1
optimalization = -O0
endif

### GCC flags ###
CFLAGS = $(MCU) $(cxx_defs) $(cxx_includes) $(optimalization)

ifneq ($(PLATFORM), Pc32)
CFLAGS += -fdata-sections -ffunction-sections 
CXXFLAGS += -ffreestanding -fno-exceptions -fno-rtti 
endif

# Add debug flags
ifeq ($(generate_debug_info), 1)
CFLAGS += -g -gdwarf-2
endif

# Generate dependency information as 'make' rules
CFLAGS += -MMD -MP -MF"$(@:%.o=%.d)" 

# Generate assembly output into build directory
ifeq ($(generate_lst_files), 1)
CFLAGS += -Wa,-a,-ad,-alms=$(build_dir)/$(notdir $(<:.cpp=.lst))
endif

#G++ specyfic flags
CXXFLAGS += $(CFLAGS) -std=c++17 

#Assembler flags
ASFLAGS += $(MCU) $(asm_defs) $(asm_includes) $(optimalization) -Wall -fdata-sections -ffunction-sections -ffreestanding -fno-exceptions

#Linker flags and directories
#Libraries are stored in variable LDLIBS
LDFLAGS += $(MCU) -L$(lib_dir) -Wl,-Map=$(build_dir)/$(target).map,--cref -Wl,--gc-sections

ifeq ($(PLATFORM), ARM)
LDFLAGS += -specs=nano.specs -specs=nosys.specs
endif