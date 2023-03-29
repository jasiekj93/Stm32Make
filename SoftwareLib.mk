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

target := lib$(project_name)-$(library_name)$(platform_name_postfix)

# Append GCC flags variables from file here
include $(make_dir)/Flags.mk

# Targets
.PHONY: all library pcLibrary tests clean

all: library pcLibrary tests

library: $(lib_dir)/$(target).a

pcLibrary: 
	+@$(MAKE) -C . library PLATFORM=Pc32 

tests:
	+@$(MAKE) -C tests PLATFORM=Pc32

print-%  : ; @echo "$* = $($*)"

# Append rules for building object files, libraries and executables
include $(make_dir)/BuildRules.mk

# clean up
clean:
	@echo Cleaning
	-@$(RMDIR) $(build_dir)

