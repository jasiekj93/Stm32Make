# ------------------------------------------------
# @author Adrian Szczepanski
# @date 06-03-2023
# ------------------------------------------------

# This file is only a template and should be included 
# in other Makefile

project_dir ?= ..

#include custom functions
include $(make_dir)/Functions.mk
$(call check-target)
$(call check-project_name)

# Append Configuration variables from file here
include $(make_dir)/Configuration.mk

# binaries
binaries := $(addprefix $(bin_dir)/$(target)., $(platform_binary_extensions))

# libraries
LDFLAGS := \
$(external_library_paths)

# Includes
library_includes = $(addprefix -I$(project_dir)/lib$(project_name)-,$(required_libraries))

cxx_includes += \
$(library_includes) \
$(external_library_includes) \

# libraries
library_flags = $(addprefix -l$(project_name)-,$(required_libraries))

LDLIBS := \
$(platform_libraries) \
$(library_flags) \
$(external_library_flags) \

LDLIBS += $(LDLIBS)

# Library path
LDFLAGS	+= $(external_library_paths)

# Append GCC flags variables from file here
include $(make_dir)/Flags.mk

# Linker script to linker flags if exist
ifneq ($(ldscript),)
LDFLAGS += -T$(ldscript)
endif

# Targets
.PHONY: all clean

all: $(binaries)

$(binaries): $(required_libraries)

$(required_libraries):
	+@$(MAKE) -C $(project_dir)/lib$(project_name)-$@

print-%  : ; @echo "$* = $($*)"

# Append rules for building object files, libraries and executables
include $(make_dir)/BuildRules.mk

# clean up
clean:
	@echo Cleaning	
	-@$(RMDIR) $(build_dir)