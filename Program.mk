# ------------------------------------------------
# @author Adrian Szczepanski
# @date 06-03-2023
# ------------------------------------------------

# This file is only a template and should be included 
# in other Makefile

project_dir ?= ..

#include custom functions
include $(make_dir)/Functions.mk
$(call check-target)
$(call check-project_name)

# Append Configuration variables from file here
include $(make_dir)/Configuration.mk

# binaries
binaries := $(addprefix $(bin_dir)/$(target)., $(platform_binary_extensions))

# libraries
LDFLAGS := \
$(addprefix -L$(external_dir)/,$(external_library_paths))

# Includes
library_includes := $(addprefix -I$(project_dir)/,$(required_libraries))
internal_library_includes := $(addprefix -I$(project_dir)/lib$(project_name)-,$(required_internal_libraries))
external_library_includes := $(addprefix -I$(external_dir)/,$(external_library_include_path))

cxx_includes += \
$(library_includes) \
$(internal_library_includes) \
$(external_library_includes) \

# libraries
library_flags = $(addprefix -l$(project_name)-,$(required_internal_libraries))
library_flags += $(addprefix -l,$(required_libraries))

LDLIBS := \
$(platform_libraries) \
$(library_flags) \
$(external_library_flags) \

LDLIBS += $(LDLIBS)

# Append GCC flags variables from file here
include $(make_dir)/Flags.mk

# Linker script to linker flags if exist
ifneq ($(ldscript),)
LDFLAGS += -T$(ldscript)
endif

# Targets
.PHONY: all clean install uninstall

all: $(binaries)

# build required libraries if program platform is diffrent than the solution 
$(binaries): $(required_libraries) $(required_internal_libraries)

$(required_internal_libraries):
	+@$(MAKE) -C $(project_dir)/lib$(project_name)-$@ PLATFORM=$(PLATFORM)

$(required_libraries):
	+@$(MAKE) -C $(project_dir)/$@ PLATFORM=$(PLATFORM)

print-%  : ; @echo "$* = $($*)"

# Append rules for building object files, libraries and executables
include $(make_dir)/BuildRules.mk

# clean up
clean:
	@echo Cleaning	
	-@$(RMDIR) $(build_dir)

# install
ifeq ($(PREFIX),)
    PREFIX := /usr/local
endif 

install: $(bin_dir)/$(target).elf
	$(call check-install-platform)
	@echo Installing $< 
	@$(CP) $< $(basename $<)
	@install -d $(DESTDIR)$(PREFIX)/bin/
	@install -m 755 $(basename $<) $(DESTDIR)$(PREFIX)/bin/
	@$(RM) $(basename $<)

uninstall:
	@echo Uninstalling $(target)
	-@$(RM) $(DESTDIR)$(PREFIX)/bin/$(target)