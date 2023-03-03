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

# Append Configuration variables from file here
include $(make_dir)/Configuration.mk

# libraries
LDFLAGS := \
$(external_library_paths)

# Includes
cxx_includes += \
$(library_includes) \

# libraries
LDLIBS := \
$(library_flags) \
$(external_library_flags) \

# Append GCC flags variables from file here
include $(make_dir)/Flags.mk

# Targets
.PHONY: all clean

all: $(bin_dir)/$(target).elf

print-%  : ; @echo "$* = $($*)"

# Append rules for building object files, libraries and executables
include $(make_dir)/BuildRules.mk

# clean up
clean:
	@echo Cleaning	
	-@$(RMDIR) $(build_dir)