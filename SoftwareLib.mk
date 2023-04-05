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
.PHONY: all library testLibrary tests clean install uninstall

all: library testLibrary tests

library: $(lib_dir)/$(target).a

testLibrary: 
	+@$(MAKE) -C . library PLATFORM=Pc32

tests: testLibrary
	+@$(MAKE) -C tests PLATFORM=Pc32

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

install: $(lib_dir)/$(target).a
ifeq ($(PLATFORM),Pc32)
	@echo Installing $<
	@install -d $(DESTDIR)$(PREFIX)/lib/
	@install -m 644 $(lib_dir)/$(target).a $(DESTDIR)$(PREFIX)/lib/
	@install -d $(DESTDIR)$(PREFIX)/include/
	@install -m 644 $(installed_include_files) $(DESTDIR)$(PREFIX)/include/
	@for dir in $(installed_include_directories); do \
		install -d $(DESTDIR)$(PREFIX)/include/$$dir; \
		install -m 644 $$dir/*.hpp $(DESTDIR)$(PREFIX)/include/$$dir; \
	done
else
	$(warning WARNING: Platform $(PLATFORM) is not supporting installation! Skipped for $<.)
endif

uninstall:
ifeq ($(PLATFORM),Pc32)
	@echo Uninstalling $(target).a
	-@$(RM) $(DESTDIR)$(PREFIX)/lib/$(target).a
	-@for dir in $(installed_include_directories); do \
		$(RMDIR) $(DESTDIR)$(PREFIX)/include/$$dir; \
	done
	-@for file in $(installed_include_files); do \
		$(RM) $(DESTDIR)$(PREFIX)/include/$$file; \
	done
else
	$(warning WARNING: Platform $(PLATFORM) is not supporting installation! Skipped for $<.)
endif