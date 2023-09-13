# ------------------------------------------------
# @author Adrian Szczepanski
# @date 06-03-2023
# ------------------------------------------------

# This file is only a template and should be included 
# in other Makefile

project_dir ?= ../..

#include custom functions
include $(make_dir)/Functions.mk
$(call check-tested_library_name)
$(call check-ldscript)

# Append Configuration variables from file here
include $(make_dir)/Configuration.mk

# Target
target := test$(tested_library_name)

# libraries
LDFLAGS := \
$(addprefix -L$(external_dir)/,$(external_library_paths))

required_libraries := $(tested_library_name) 

# Includes
library_includes := $(addprefix -I$(project_dir)/,$(required_libraries))
external_library_includes := $(addprefix -I$(external_dir)/,$(external_library_include_path))

cxx_includes += \
$(library_includes) \
$(external_library_includes) \

# libraries
library_flags := $(addprefix -l,$(required_libraries))

LDLIBS :=  \
$(platform_libraries) \
$(library_flags) \
$(external_library_flags) \

binaries := $(addprefix $(test_dir)/$(target)., $(platform_binary_extensions))

# Append GCC flags variables from file here
include $(make_dir)/Flags.mk

# Linker script to linker flags
LDFLAGS += -T$(ldscript)

# Targets
.PHONY: all clean

all: $(binaries) 

print-%  : ; @echo "$* = $($*)"

# Append rules for building object files, libraries and executables
include $(make_dir)/BuildRules.mk

# clean up
clean:
	@echo Cleaning	
	-@$(RMDIR) $(build_dir)

