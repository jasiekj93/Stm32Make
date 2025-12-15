# ------------------------------------------------
# @author Adrian Szczepanski
# @date 15-02-2024
# ------------------------------------------------

# This file is only a template and should be included 
# in other Makefile

# Append Configuration variables from file here
include $(make_dir)/Configuration.mk

project_dir := .

internal_library_dirs := $(addprefix lib$(project_name)-, $(internal_library_names))
program_dirs := $(program_names)
library_dirs := $(library_names)
external_dirs := $(addprefix $(external_lib_dir)/, $(external_names))

# targets
make_goals := debug release libraries programs $(external_dirs) $(internal_library_dirs) $(program_dirs) $(library_dirs) \
rebuild clean mrproper distclean documentation install uninstall deploy

.PHONY: $(make_goals)