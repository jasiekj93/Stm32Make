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

# Append Configuration variables from file here
include $(make_dir)/Configuration.mk

# target
target := lib$(library_name)

# Includes
external_library_includes := $(addprefix -I$(external_dir)/,$(external_library_include_path))

cxx_includes += \
$(external_library_includes) \

# Append GCC flags variables from file here
include $(make_dir)/Flags.mk

# Targets
.PHONY: all library tests clean install uninstall

all: library tests

library: $(lib_dir)/$(target).a

tests: library
	+@$(MAKE) -C tests 

print-%  : ; @echo "$* = $($*)"

# Append rules for building object files, libraries and executables
include $(make_dir)/BuildRules.mk

# clean up
clean:
	@echo Cleaning
	-@$(RMDIR) $(build_dir)

install: $(lib_dir)/$(target).a
	$(warning WARNING: Platform $(PLATFORM) is not supporting installation! Skipped for $<.)

uninstall:
	$(warning WARNING: Platform $(PLATFORM) is not supporting installation! Skipped for $<.)