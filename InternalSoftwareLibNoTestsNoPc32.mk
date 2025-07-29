# ------------------------------------------------
# @author Adrian Szczepanski
# @date 06-03-2022
# ------------------------------------------------

# This file is only a template and should be included 
# in other Makefile

project_dir ?= ..

#include custom functions
include $(make_dir)/Functions.mk
$(call check-library_name)
$(call check-project_name)

# Append Configuration variables from file here
include $(make_dir)/Configuration.mk

# target
target := $(lib_internal_dir)/lib$(project_name)-$(library_name).a

ifneq ($(filter $(PLATFORM),$(supported_platforms)), $(PLATFORM))
$(info "Platform $(PLATFORM) not supported - skipping build of lib$(project_name)-$(library_name)")
target = 
endif

# Includes
library_includes := $(addprefix -I$(project_dir)/lib$(project_name)-,$(required_libraries))
external_library_includes := $(addprefix -I$(external_dir)/,$(external_library_include_path))

cxx_includes += \
$(library_includes) \
$(external_library_includes) \

# Append GCC flags variables from file here
include $(make_dir)/Flags.mk

# Targets
.PHONY: all library clean

all: library 

library: $(target)

print-%  : ; @echo "$* = $($*)"

# Append rules for building object files, libraries and executables
include $(make_dir)/BuildRules.mk

# clean up
clean:
	@echo Cleaning
	-@$(RMDIR) $(build_dir)

