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
$(call check-target)

# Measuring time feature
# start_time variable is expanded immiediate at the beggining of make process,
# the others are expanded (and executed) during every usage 
# (in this case at the end of build process).
start_time := $(shell date +%s)
end_time = $(shell date +%s)
build_time = $(shell expr $(end_time) - $(start_time) )

project_dir := .

library_dirs := $(addprefix lib$(project_name)-, $(library_names))
program_dirs := $(program_names)
external_dirs := $(addprefix $(external_lib_dir)/, $(external_names))

library_includes := $(addprefix -I, $(library_dirs))
library_flags := $(addsuffix $(platform_name_postfix),$(addprefix -l$(target)-,$(notdir $(library_names))))

external_library_includes := $(addprefix -I$(external_lib_dir)/, $(external_names))
external_library_flags := $(addprefix -l, $(external_lib_names))
external_search_path := $(addprefix -L$(external_lib_dir)/, $(external_lib_dirs))

binaries := $(addprefix $(bin_dir)/$(target)., $(platform_binary_extensions))

# Includes
cxx_includes += \
$(library_includes) \
$(external_library_includes) \

# Libraries
LDLIBS := $(platform_libraries)
LDLIBS += $(library_flags) $(external_library_flags) 
LDLIBS += $(library_flags) $(external_library_flags) 

# Library path
LDFLAGS	+= $(external_search_path)

# Append GCC flags variables from file here
include $(make_dir)/Flags.mk

# Linker script to linker flags if exist
ifneq ($(ldscript),)
LDFLAGS += -T$(ldscript)
endif

# targets
.PHONY: debug release $(external_dirs) $(library_dirs) $(binaries) $(program_dirs) rebuild clean mrproper distclean

debug: $(external_dirs) $(library_dirs) $(binaries) $(program_dirs)
	@echo "Building time: [$(build_time) seconds]"

release:
	+@$(MAKE) --directory=$(project_dir) build_type=release

$(binaries): $(external_dirs) $(library_dirs) $(program_dirs)

$(library_dirs): $(external_dirs)

$(library_dirs) $(external_dirs) $(program_dirs):
	@echo Making libraries:
	+@$(MAKE) --directory=$@

print-%: ; @echo "$* = $($*)"

# Append rules for building object files, libraries and executables
include $(make_dir)/BuildRules.mk

# rebuild
rebuild:
	-@$(RMDIR) $(bin_dir)
	+@$(MAKE) -C .
 
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

distclean: mrproper
	@echo Cleaning all external projects
	-+@for dir in $(external_dirs); do \
		$(MAKE) --directory=$$dir clean distclean; \
	done
