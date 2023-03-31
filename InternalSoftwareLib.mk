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

cxx_includes += \
$(library_includes) \

# Append GCC flags variables from file here
include $(make_dir)/Flags.mk

# Targets
.PHONY: all library testLibrary tests clean

all: library testLibrary tests

library: $(lib_dir)/$(target).a

testLibrary: library
ifeq ($(PLATFORM),Pc32)
	@echo Creating library $(lib_dir)/$(target).test.a
	@$(CP) $(lib_dir)/$(target).a $(lib_dir)/$(target).test.a
else
	+@$(MAKE) -C . library test_build_suffix=.test
endif

tests: testLibrary
	+@$(MAKE) -C tests PLATFORM=Pc32

print-%  : ; @echo "$* = $($*)"

# Append rules for building object files, libraries and executables
include $(make_dir)/BuildRules.mk

# clean up
clean:
	@echo Cleaning
	-@$(RMDIR) $(build_dir)

