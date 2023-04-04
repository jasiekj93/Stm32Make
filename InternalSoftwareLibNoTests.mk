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
target := lib$(project_name)-$(library_name)$(test_build_suffix)

# Includes
library_includes := $(addprefix -I$(project_dir)/lib$(project_name)-,$(required_libraries))
external_library_includes := $(addprefix -I$(external_dir)/,$(external_library_include_path))

cxx_includes += \
$(library_includes) \
$(external_library_includes) \

# Append GCC flags variables from file here
include $(make_dir)/Flags.mk

# Targets
.PHONY: all library testLibrary clean

all: library testLibrary

library: $(lib_internal_dir)/$(target).a

# only for use by tests in other libraries
testLibrary: library
ifeq ($(PLATFORM),Pc32)
	@echo Creating library $(lib_internal_dir)/$(target).test.a
	@$(CP) $(lib_internal_dir)/$(target).a $(lib_internal_dir)/$(target).test.a
else
	+@$(MAKE) -C . library test_build_suffix=.test PLATFORM=Pc32
endif

print-%  : ; @echo "$* = $($*)"

# Append rules for building object files, libraries and executables
include $(make_dir)/BuildRules.mk

# clean up
clean:
	@echo Cleaning
	-@$(RMDIR) $(build_dir)

