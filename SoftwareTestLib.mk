# ------------------------------------------------
# @author Adrian Szczepanski
# @date 06-03-2023
# ------------------------------------------------

# This file is only a template and should be included 
# in other Makefile

project_dir ?= ../..
PLATFORM := Pc32

#include custom functions
include $(make_dir)/Functions.mk
$(call check-tested_library_name)
$(call check-project_name)

# Append Configuration variables from file here
include $(make_dir)/Configuration.mk

# Target
target := test$(project_name)-$(tested_library_name)$(platform_name_postfix)

# libraries
LDFLAGS := \
-L$(external_lib_dir)/CppUTest/lib/Pc32 \
$(external_library_paths)

# Includes
library_includes = $(addprefix -I$(project_dir)/lib$(project_name)-,$(tested_library_name))
library_includes += $(addprefix -I$(project_dir)/lib$(project_name)-,$(required_libraries))

cxx_includes += \
$(library_includes) \
-I$(external_lib_dir)/CppUTest/include \

# libraries
library_flags = $(addsuffix $(platform_name_postfix),$(addprefix -l$(project_name)-,$(tested_library_name)))
library_flags += $(addsuffix $(platform_name_postfix),$(addprefix -l$(project_name)-,$(required_libraries)))

LDLIBS := \
-lCppUTest \
$(library_flags) \
$(external_library_flags) \

# Append GCC flags variables from file here
include $(make_dir)/Flags.mk

# Targets
.PHONY: all clean

all: $(test_dir)/$(target).elf
	@$(test_dir)/$(target).elf

print-%  : ; @echo "$* = $($*)"

# Append rules for building object files, libraries and executables
include $(make_dir)/BuildRules.mk

# clean up
clean:
	@echo Cleaning	
	-@$(RMDIR) $(build_dir)

