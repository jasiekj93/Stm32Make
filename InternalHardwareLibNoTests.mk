# ------------------------------------------------
# @author Adrian Szczepanski
# @date 06-03-2022
# ------------------------------------------------

# This file is only a template and should be included 
# in other Makefile

project_dir ?= ..

#include custom functions
include $(make_dir)/Functions.mk
$(call check-target)

# Append Configuration variables from file here
include $(make_dir)/Configuration.mk

# Libraries
LDLIBS := -lc -lm -lnosys \

# Append GCC flags variables from file here
include $(make_dir)/Flags.mk

# Targets
.PHONY: all library clean

all: $(lib_internal_dir)/$(target).a

print-%  : ; @echo $* = $($*)

# Append rules for building object files, libraries and executables
include $(make_dir)/BuildRules.mk

# clean up
clean:
	@echo Cleaning
	-@$(RMDIR) $(build_dir)
