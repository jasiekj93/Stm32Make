# ------------------------------------------------
# @author Adrian Szczepanski
# @date 06-03-2022
# ------------------------------------------------

# This file is only a template and should be included 
# in other Makefile

#include custom functions
include $(make_dir)/Functions.mk
$(call check-platform)
$(call check-target)

# Append Configuration variables from file here
include $(make_dir)/Configuration.mk

target := $(target)$(platform_name_postfix)

# Measuring time feature
# start_time variable is expanded immiediate at the beggining of make process,
# the others are expanded (and executed) during every usage 
# (in this case at the end of build process).
start_time := $(shell date +%s)
end_time = $(shell date +%s)
build_time = $(shell expr $(end_time) - $(start_time) )

project_dir := .

external_dirs := $(addprefix $(external_lib_dir)/, $(external_names))
external_library_includes := $(addprefix -I$(external_lib_dir)/, $(external_names))

# Includes
cxx_includes += \
$(external_library_includes) \

# Append GCC flags variables from file here
include $(make_dir)/Flags.mk

# targets
.PHONY: all $(external_dirs) library pcLibrary tests rebuild clean mrproper distclean 

all: $(external_dirs) library pcLibrary tests
	@echo "Building time: [$(build_time) seconds]"

library: $(external_dirs) $(lib_dir)/$(target).a

pcLibrary: 
	+@$(MAKE) -C . library PLATFORM=Pc32 

tests:
	+@$(MAKE) -C tests PLATFORM=Pc32

$(external_dirs):
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
