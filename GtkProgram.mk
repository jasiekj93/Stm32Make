# ------------------------------------------------
# @author Adrian Szczepanski
# @date 22-04-2024
# ------------------------------------------------

# This file is only a template and should be included 
# in other Makefile

project_dir ?= ..
resource_dir ?= resource

# Resources
gio_source := $(resource_dir)/$(notdir $(gio_resource_file:.xml=.c))
gio_header := $(resource_dir)/$(notdir $(gio_resource_file:.xml=.h))

# Append Gio c/h files to sources/includes
c_sources += $(gio_source)
cxx_includes += -I./$(resource_dir)

# Append rest of Makefile from template
include $(make_dir)/Program.mk

# Append Gtkmm flags and libs to target platform
platform_c_flags += $(shell pkg-config --cflags gtkmm-3.0)
LDLIBS += $(shell pkg-config --libs gtkmm-3.0)

# Generating Gio c/h files build rules
$(objects): $(gio_header) $(gio_source)

$(gio_source): $(gio_resource_file) $(gio_header) Makefile
	@echo Generating $@
	@glib-compile-resources --target=$@ --generate-source $<

$(gio_header): $(gio_resource_file) Makefile 
	@echo Generating $@
	@glib-compile-resources --target=$@ --generate-header $<