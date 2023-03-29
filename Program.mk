# ------------------------------------------------
# @author Adrian Szczepanski
# @date 06-03-2023
# ------------------------------------------------

# This file is only a template and should be included 
# in other Makefile

project_dir ?= ..
PLATFORM := Pc32

#include custom functions
include $(make_dir)/Functions.mk
$(call check-target)
$(call check-project_name)

# Append Configuration variables from file here
include $(make_dir)/Configuration.mk

# libraries
LDFLAGS := \
$(external_library_paths)

# Includes
library_includes = $(addprefix -I$(project_dir)/lib$(project_name)-,$(required_libraries))

cxx_includes += \
$(library_includes) \
$(external_library_includes) \

# libraries
library_flags = $(addsuffix $(platform_name_postfix),$(addprefix -l$(project_name)-,$(required_libraries)))

LDLIBS := \
$(library_flags) \
$(external_library_flags) \

LDLIBS += $(LDLIBS)

# Append GCC flags variables from file here
include $(make_dir)/Flags.mk

# Targets
.PHONY: all clean

all: $(bin_dir)/$(target).elf

$(bin_dir)/$(target).elf: $(required_libraries)

$(required_libraries):
	+@$(MAKE) -C $(project_dir)/lib$(project_name)-$@

print-%  : ; @echo "$* = $($*)"

# Append rules for building object files, libraries and executables
include $(make_dir)/BuildRules.mk

# clean up
clean:
	@echo Cleaning	
	-@$(RMDIR) $(build_dir)