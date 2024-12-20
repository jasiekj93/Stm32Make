# ------------------------------------------------
# @author Adrian Szczepanski
# @date 20-12-2024
# ------------------------------------------------

# This file is only a template and should be included 
# in other Makefile

project_dir ?= ..

#include custom functions
include $(make_dir)/Functions.mk
$(call check-project_name)

# Append Configuration variables from file here
include $(make_dir)/Configuration.mk

# binaries
touchgfx_binaries_dir := TouchGFX/build/bin
touchgfx_binaries := target.hex intflash.elf intflash.hex extflash.bin

binaries := $(addprefix $(touchgfx_binaries_dir)/,$(touchgfx_binaries))

# libraries
LDFLAGS := \
$(addprefix -L$(external_dir)/,$(external_library_paths)) \
-L$(lib_dir) -L$(lib_internal_dir)

# Includes
library_includes := $(addprefix -I$(project_dir)/,$(required_libraries))
internal_library_includes := $(addprefix -I$(project_dir)/lib$(project_name)-,$(required_internal_libraries))
external_library_includes := $(addprefix -I$(external_dir)/,$(external_library_include_path))

cxx_includes += \
$(library_includes) \
$(internal_library_includes) \
$(external_library_includes) \

# Append Configuration variables from TouchGFX project
include TouchGFX/config/gcc/app.mk
user_cflags += $(cxx_includes)

# libraries
library_flags = $(addprefix $(project_name)-,$(required_internal_libraries))
library_flags += $(required_libraries)

LDLIBS := \
$(library_flags) \
$(external_library_flags) \
touchgfx

LDLIBS += $(LDLIBS)

# Targets
.PHONY: all clean $(required_libraries) $(required_internal_libraries) 

# build required libraries if program platform is diffrent than the solution 
all: $(required_libraries) $(required_internal_libraries) | $(bin_dir)
	+@$(MAKE) -C gcc PLATFORM=$(PLATFORM) user_cflags="$(user_cflags)" linker_options_local="$(LDFLAGS)" libraries="$(LDLIBS)"
	@cp $(binaries) $(bin_dir)/

$(required_internal_libraries):
	+@$(MAKE) -C $(project_dir)/lib$(project_name)-$@ PLATFORM=$(PLATFORM)

$(required_libraries):
	+@$(MAKE) -C $(project_dir)/$@ PLATFORM=$(PLATFORM)

print-%  : ; @echo "$* = $($*)"

# clean up
clean:
	@echo Cleaning	
	+@$(MAKE) -C gcc clean 

# create directories
$(bin_dir):
	@echo Creating directory $@
	@$(MKDIR) $@	