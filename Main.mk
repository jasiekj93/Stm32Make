# ------------------------------------------------
# @author Adrian Szczepanski
# @date 06-03-2022
# ------------------------------------------------

# This file is only a template and should be included 
# in other Makefile

#include main makefile targets(goals) for project
include $(make_dir)/MainGoals.mk

#include custom functions
include $(make_dir)/Functions.mk
$(call check-platform)
$(call check-build)
$(call check-project_name)

# Append GCC flags variables from file here
include $(make_dir)/Flags.mk

# Measuring time feature
# start_time variable is expanded immiediate at the beggining of make process,
# the others are expanded (and executed) during every usage 
# (in this case at the end of build process).
start_time := $(shell date +%s)
end_time = $(shell date +%s)
build_time = $(shell expr $(end_time) - $(start_time) )

# targets
debug: $(external_dirs) $(internal_library_dirs) $(program_dirs) $(library_dirs)
	@echo "Building time: [$(build_time) seconds]"

release: documentation
	+@$(MAKE) --directory=$(project_dir) BUILD=release

libraries: $(library_dirs)
	@echo "Building time: [$(build_time) seconds]"

programs: $(program_dirs)
	@echo "Building time: [$(build_time) seconds]"

$(program_dirs): $(library_dirs) $(external_dirs) $(internal_library_dirs)

$(library_dirs): $(external_dirs) $(internal_library_dirs)

$(internal_library_dirs): $(external_dirs)

$(internal_library_dirs) $(program_dirs) $(library_dirs):
	+@$(MAKE) --directory=$@

$(external_dirs):
	+@$(MAKE) --directory=$@ $(external_build_options)

print-%: ; @echo "$* = $($*)"

# rebuild
rebuild:
	-@$(RMDIR) $(bin_dir)
	+@$(MAKE) -C .
 
documentation:
ifneq ($(wildcard $(docs_dir)/.*),)
	-+@$(MAKE) --directory=$(docs_dir)
endif

# install
ifeq ($(PREFIX),)
    PREFIX := /usr/local
endif 

install deploy: release

install uninstall deploy: 
	-+@for dir in $(program_dirs); do $(MAKE) --directory=$$dir $@ BUILD=release; done
	-+@for dir in $(library_dirs); do $(MAKE) --directory=$$dir $@ BUILD=release; done
ifneq ($(wildcard $(docs_dir)/.*),)
	-+@$(MAKE) --directory=$(docs_dir) $@
endif

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
ifneq ($(wildcard ~/Dropbox/.*),)
	-+@$(MAKE) --directory=$(docs_dir) clean 
endif 

distclean: mrproper
	@echo Cleaning all external projects
	-+@for dir in $(external_dirs); do \
		$(MAKE) --directory=$$dir clean distclean; \
	done
