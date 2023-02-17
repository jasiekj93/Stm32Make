# ------------------------------------------------
# @author Adrian Szczepanski
# @date 06-03-2022
# ------------------------------------------------

# This file is only a template and should be included 
# in other Makefile

project_dir ?= ..

#include custom functions
include $(make_dir)/Functions.mk

target := $(call set-target-name,$(target))

# Append Configuration variables from file here
include $(make_dir)/Configuration.mk
# Append GCC flags variables from file here
include $(make_dir)/Flags.mk

# Targets
.PHONY: all library pcLibrary clean

all: library pcLibrary 

library: $(lib_dir)/$(target).a

pcLibrary: 
	+@$(MAKE) -C . library PLATFORM=Pc32 

print-%  : ; @echo "$* = $($*)"

# Append rules for building object files, libraries and executables
include $(make_dir)/BuildRules.mk

# clean up
clean:
	@echo Cleaning
	-@$(RMDIR) $(build_dir)

