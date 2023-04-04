# ------------------------------------------------
# @author Adrian Szczepanski
# @date 06-03-2022
# ------------------------------------------------

# This file is only a template and should be included 
# in other Makefile

# Append Configuration variables from file here
include $(make_dir)/Configuration.mk

#include custom functions
include $(make_dir)/Functions.mk
$(call check-platform)
$(call check-project_name)

# Measuring time feature
# start_time variable is expanded immiediate at the beggining of make process,
# the others are expanded (and executed) during every usage 
# (in this case at the end of build process).
start_time := $(shell date +%s)
end_time = $(shell date +%s)
build_time = $(shell expr $(end_time) - $(start_time) )

project_dir := .

internal_library_dirs := $(addprefix lib$(project_name)-, $(internal_library_names))
program_dirs := $(program_names)
library_dirs := $(library_names)
external_dirs := $(addprefix $(external_lib_dir)/, $(external_names))

# Append GCC flags variables from file here
include $(make_dir)/Flags.mk

# targets
.PHONY: debug release $(external_dirs) $(internal_library_dirs) $(program_dirs) $(library_dirs) rebuild clean mrproper distclean documentation

debug: $(external_dirs) $(internal_library_dirs) $(program_dirs) $(library_dirs)
	@echo "Building time: [$(build_time) seconds]"

release: documentation
	+@$(MAKE) --directory=$(project_dir) build_type=release


$(program_dirs): $(library_dirs) $(external_dirs) $(internal_library_dirs)

$(library_dirs): $(external_dirs) $(internal_library_dirs)

$(internal_library_dirs): $(external_dirs)

$(internal_library_dirs) $(external_dirs) $(program_dirs) $(library_dirs):
	+@$(MAKE) --directory=$@

print-%: ; @echo "$* = $($*)"

# rebuild
rebuild:
	-@$(RMDIR) $(bin_dir)
	+@$(MAKE) -C .
 
documentation:
	+@$(MAKE) --directory=$(docs_dir)

# clean up
clean:
	@echo Cleaning build directory
	-@$(RMDIR) $(build_root_dir)

mrproper: clean
	@echo Cleaning bin, lib and test directories
	-@$(RMDIR) $(build_root_dir)
	-@$(RMDIR) $(bin_root_dir)
	-@$(RMDIR) $(lib_root_dir)
	-@$(RMDIR) $(test_root_dir)
	-+@$(MAKE) --directory=$(docs_dir) clean 


distclean: mrproper
	@echo Cleaning all external projects
	-+@for dir in $(external_dirs); do \
		$(MAKE) --directory=$$dir clean distclean; \
	done
